//
//  ActionSelector.swift
//  PoseTest
//
//  Created by Apple on 2020/10/15.
//

import Foundation
import CoreImage
import Accelerate
import TensorFlowLite


class ActionDetectorSelector{
    
    var detectorList:[DetectorRange]
    private var modelDataHandler: ImageHandler?
    
    init() {
        detectorList=[DetectorRange]()
        do {
          modelDataHandler = try ImageHandler()
        } catch let error {
          fatalError(error.localizedDescription)
        }
        
        let punchUpDownDetector=ActionDetector(
            action: ActionEnum.PunchUpDown,
            motionDetectorList: [PunchUpMotionDetector(),PunchDownMotionDetector()])
        detectorList.append((
                            startSeconds: 0,
                            endSeconds: 20,
                            detector:punchUpDownDetector))
    }
    
    func getDetector(seconds:Double) -> ActionDetector? {
        for item in detectorList{
            if seconds>item.startSeconds && seconds<item.endSeconds{
                return item.detector
            }
        }
        return nil
    }
    
    func detect(pixelbuffer: CVPixelBuffer,seconds:Double) -> [DetectResult] {
        if let detector=getDetector(seconds: seconds){
            guard
              let kpRes = self.modelDataHandler?.runPoseNet(on: pixelbuffer)
            else {
                os_log("Cannot get inference result.", type: .error)
                return []
            }
            
            return detector.detect(kpResult: kpRes, seconds: seconds)
        }
        return []
    }
}

typealias DetectorRange = (startSeconds: Double, endSeconds: Double,detector:ActionDetector)
