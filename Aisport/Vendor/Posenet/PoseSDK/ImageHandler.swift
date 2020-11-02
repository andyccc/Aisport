// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Accelerate
import CoreImage
import Foundation
import TensorFlowLite
import UIKit

/// This class handles all data preprocessing and makes calls to run inference on a given frame
/// by invoking the `Interpreter`. It then formats the inferences obtained.
class ImageHandler {
  // MARK: - Private Properties

  /// TensorFlow Lite `Interpreter` object for performing inference on a given model.
  private var interpreter: Interpreter

  /// TensorFlow lite `Tensor` of model input and output.
  private var inputTensor: Tensor

  private var heatsTensor: Tensor
  private var offsetsTensor: Tensor
    
    var size:CGSize

  // MARK: - Initialization

  /// A failable initializer for `ImageHandler`. A new instance is created if the model is
  /// successfully loaded from the app's main bundle. Default `threadCount` is 2.
  init(
    threadCount: Int = Constants.defaultThreadCount,
    delegate: Delegates = Constants.defaultDelegate
  ) throws {
    // Construct the path to the model file.
    guard
      let modelPath = Bundle.main.path(
        forResource: Model.file.name,
        ofType: Model.file.extension
      )
    else {
      fatalError("Failed to load the model file with name: \(Model.file.name).")
    }

    // Specify the options for the `Interpreter`.
    var options = Interpreter.Options()
    options.threadCount = threadCount
    size=CGSize.zero

    // Specify the delegates for the `Interpreter`.
    var delegates: [Delegate]?
    switch delegate {
    case .Metal:
      delegates = [MetalDelegate()]
    case .CoreML:
      if let coreMLDelegate = CoreMLDelegate() {
        delegates = [coreMLDelegate]
      } else {
        delegates = nil
      }
    default:
      delegates = nil
    }

    // Create the `Interpreter`.
    interpreter = try Interpreter(modelPath: modelPath, options: options, delegates: delegates)

    // Initialize input and output `Tensor`s.
    // Allocate memory for the model's input `Tensor`s.
    try interpreter.allocateTensors()

    // Get allocated input and output `Tensor`s.
    inputTensor = try interpreter.input(at: 0)
    heatsTensor = try interpreter.output(at: 0)
    offsetsTensor = try interpreter.output(at: 1)

    // Check if input and output `Tensor`s are in the expected formats.
    guard (inputTensor.dataType == .uInt8) == Model.isQuantized else {
      fatalError("Unexpected Model: quantization is \(!Model.isQuantized)")
    }

    guard inputTensor.shape.dimensions[0] == Model.input.batchSize,
      inputTensor.shape.dimensions[1] == Model.input.height,
      inputTensor.shape.dimensions[2] == Model.input.width,
      inputTensor.shape.dimensions[3] == Model.input.channelSize
    else {
      fatalError("Unexpected Model: input shape")
    }

    guard heatsTensor.shape.dimensions[0] == Model.output.batchSize,
      heatsTensor.shape.dimensions[1] == Model.output.height,
      heatsTensor.shape.dimensions[2] == Model.output.width,
      heatsTensor.shape.dimensions[3] == Model.output.keypointSize
    else {
      fatalError("Unexpected Model: heat tensor")
    }

    guard offsetsTensor.shape.dimensions[0] == Model.output.batchSize,
      offsetsTensor.shape.dimensions[1] == Model.output.height,
      offsetsTensor.shape.dimensions[2] == Model.output.width,
      offsetsTensor.shape.dimensions[3] == Model.output.offsetSize
    else {
      fatalError("Unexpected Model: offset tensor")
    }

  }

  /// Runs PoseNet model with given image with given source area to destination area.
  ///
  /// - Parameters:
  ///   - on: Input image to run the model.
  ///   - from: Range of input image to run the model.
  ///   - to: Size of view to render the result.
  /// - Returns: Result of the inference and the times consumed in every steps.
  func runPoseNet(on pixelbuffer: CVPixelBuffer)
    -> KPResult?
  {
    
    size=pixelbuffer.size
    guard let data = preprocess(of: pixelbuffer) else {
      os_log("Preprocessing failed", type: .error)
      return nil
    }

    inference(from: data)

    guard let result = postprocess() else {
      os_log("Postprocessing failed", type: .error)
      return nil
    }

    return result
  }

  // MARK: - Private functions to run model
  /// Preprocesses given rectangle image to be `Data` of disired size by croping and resizing it.
  ///
  /// - Parameters:
  ///   - of: Input image to crop and resize.
  ///   - from: Target area to be cropped and resized.
  /// - Returns: The cropped and resized image. `nil` if it can not be processed.
  private func preprocess(of pixelBuffer: CVPixelBuffer) -> Data? {
    //assert(sourcePixelFormat == kCVPixelFormatType_32RGBA)

    // Resize `targetSquare` of input image to `modelSize`.
    let modelSize = CGSize(width: Model.input.width, height: Model.input.height)
    let orgRange=CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    guard let thumbnail = pixelBuffer.resize(from: orgRange, to: modelSize)
    
    else {
      return nil
    }

    // Remove the alpha component from the image buffer to get the initialized `Data`.
    guard
      let inputData = thumbnail.rgbData(
        isModelQuantized: Model.isQuantized
      )
    else {
      os_log("Failed to convert the image buffer to RGB data.", type: .error)
      return nil
    }

    return inputData
  }

  /// Postprocesses output `Tensor`s to `Result` with size of view to render the result.
  ///
  /// - Parameters:
  ///   - to: Size of view to be displaied.
  /// - Returns: Postprocessed `Result`. `nil` if it can not be processed.
  private func postprocess() -> KPResult? {
    // MARK: Formats output tensors
    // Convert `Tensor` to `FlatArray`. As PoseNet is not quantized, convert them to Float type
    // `FlatArray`.
    let heats = FlatArray<Float32>(tensor: heatsTensor)
    let offsets = FlatArray<Float32>(tensor: offsetsTensor)

    // MARK: Find position of each key point
    // Finds the (row, col) locations of where the keypoints are most likely to be. The highest
    // `heats[0, row, col, keypoint]` value, the more likely `keypoint` being located in (`row`,
    // `col`).
    let keypointPositions = (0..<Model.output.keypointSize).map { keypoint -> (Int, Int) in
      var maxValue = heats[0, 0, 0, keypoint]
      var maxRow = 0
      var maxCol = 0
      for row in 0..<Model.output.height {
        for col in 0..<Model.output.width {
          if heats[0, row, col, keypoint] > maxValue {
            maxValue = heats[0, row, col, keypoint]
            maxRow = row
            maxCol = col
          }
        }
      }
      return (maxRow, maxCol)
    }

    // MARK: Calculates total confidence score
    // Calculates total confidence score of each key position.
    let totalScoreSum = keypointPositions.enumerated().reduce(0.0) { accumulator, elem -> Float32 in
      accumulator + sigmoid(heats[0, elem.element.0, elem.element.1, elem.offset])
    }
    let totalScore = totalScoreSum / Float32(Model.output.keypointSize)
    var minX:Float=Float(size.width-1)
    var minY:Float=Float(size.height-1)
    var maxX:Float=0
    var maxY:Float=0

    // MARK: Calculate key point position on model input
    // Calculates `KeyPoint` coordination model input image with `offsets` adjustment.
    let coords = keypointPositions.enumerated().map { index, elem -> Point in
        let (y, x) = elem
        let yCoord = Float32(y) / Float32(Model.output.height - 1) * Float32(Model.input.height)
            + offsets[0, y, x, index]
        let xCoord = Float32(x) / Float32(Model.output.width - 1) * Float32(Model.input.width)
            + offsets[0, y, x, index + Model.output.keypointSize]
        
        if yCoord>maxY && yCoord<Float(size.height){
            maxY=yCoord
        }
        if yCoord<minY && yCoord>=0{
            minY=yCoord
        }
        if xCoord>maxX && xCoord<Float(size.width){
            maxX=xCoord
        }
        if xCoord<minX && xCoord>=0{
            minX=xCoord
        }
        
        return Point(x:xCoord,y:yCoord)
    }

    var dots=[String:Point]()
    for (index, part) in KP.allCases.enumerated() {
        
        let position = Point(
            x: coords[index].x * Float(size.width) / Float(Model.input.width),
            y: coords[index].y * Float(size.height) / Float(Model.input.height)
        )
        dots[part.rawValue] = position
        //print(part,position.x,position.y)
    }
    
    let rectSize=CGSize(width: CGFloat(maxX)-CGFloat(minX), height: CGFloat(maxY)-CGFloat(minY))
    let rect=CGRect(origin: CGPoint(x:CGFloat(minX),y:CGFloat(minY)), size: rectSize)
    //let rect=CGRect.zero
    
    var lines:[LineData]?
    do {
        try lines = BodyPart.lines.map { map throws -> LineData in
            guard let from = dots[map.from.rawValue] else {
          throw PostprocessError.missingBodyPart(of: map.from)
        }
        guard let to = dots[map.to.rawValue] else {
          throw PostprocessError.missingBodyPart(of: map.to)
        }
        return LineData(from: from, to: to)
      }
    } catch PostprocessError.missingBodyPart(let missingPart) {
      os_log("Postprocessing error: %s is missing.", type: .error, missingPart.rawValue)
      return nil
    } catch {
      os_log("Postprocessing error: %s", type: .error, error.localizedDescription)
      return nil
    }
    
    // MARK: Transform key point position and make lines
    // Make `Result` from `keypointPosition'. Each point is adjusted to `ViewSize` to be drawn.
    let result = KPResult(dots:dots,lines: lines!,rect:rect, score: totalScore,seconds: 0)

    return result
  }

  /// Run inference with given `Data`
  ///
  /// Parameter `from`: `Data` of input image to run model.
  private func inference(from data: Data) {
    // Copy the initialized `Data` to the input `Tensor`.
    do {
      try interpreter.copy(data, toInputAt: 0)

      // Run inference by invoking the `Interpreter`.
      try interpreter.invoke()

      // Get the output `Tensor` to process the inference results.
      heatsTensor = try interpreter.output(at: 0)
      offsetsTensor = try interpreter.output(at: 1)

    } catch let error {
      os_log(
        "Failed to invoke the interpreter with error: %s", type: .error,
        error.localizedDescription)
      return
    }
  }

  /// Returns value within [0,1].
  private func sigmoid(_ x: Float32) -> Float32 {
    return (1.0 / (1.0 + exp(-x)))
  }
}

@objc(PointData)
class Point :NSObject{
    var x:Float
    var y:Float
    
    init(x:Float, y:Float) {
        self.x = x
        self.y = y
    }
}

@objc
class LineData: NSObject {
    let from: Point
    let to: Point
    
    init(from: Point, to: Point) {
        self.from = from
        self.to = to
    }
}

struct KPResult {
    var dots: [String:Point]
    var lines: [LineData]
    var rect:CGRect
    var score: Float
    var seconds:Double

}

enum KP:String , CaseIterable{
    case NOSE = "nose"
    case LEFT_EYE = "left eye"
    case RIGHT_EYE = "right eye"
    case LEFT_EAR = "left ear"
    case RIGHT_EAR = "right ear"
    case LEFT_SHOULDER = "left shoulder"
    case RIGHT_SHOULDER = "right shoulder"
    case LEFT_ELBOW = "left elbow"
    case RIGHT_ELBOW = "right elbow"
    case LEFT_WRIST = "left wrist"
    case RIGHT_WRIST = "right wrist"
    case LEFT_HIP = "left hip"
    case RIGHT_HIP = "right hip"
    case LEFT_KNEE = "left knee"
    case RIGHT_KNEE = "right knee"
    case LEFT_ANKLE = "left ankle"
    case RIGHT_ANKLE = "right ankle"
}

// MARK: - Delegates Enum
@objc
public enum Delegates: Int, CaseIterable {
  case CPU
  case Metal
  case CoreML

  var description: String {
    switch self {
    case .CPU:
      return "CPU"
    case .Metal:
      return "GPU"
    case .CoreML:
      return "NPU"
    }
  }
}


// MARK: - Information about the model file.
typealias FileInfo = (name: String, extension: String)

public enum Model {
  static let file: FileInfo = (
    name: "posenet_mobilenet_v1_100_257x257_multi_kpt_stripped", extension: "tflite"
  )

  static let input = (batchSize: 1, height: 257, width: 257, channelSize: 3)
  static let output = (batchSize: 1, height: 9, width: 9, keypointSize: 17, offsetSize: 34)
  static let isQuantized = false
}
