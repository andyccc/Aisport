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

import UIKit

/// UIView for rendering inference output.
class OverlayView: UIView {
    
    @objc
  var dots = [Point]()
    @objc
  var lines = [LineData]()

  override func draw(_ rect: CGRect) {
    for dot in dots {
      drawDot(of: dot)
    }
    for line in lines {
      drawLine(of: line)
    }
  }

  func drawDot(of dot: Point) {
    let dotRect = CGRect(
        x: CGFloat(dot.x) - Traits.dot.radius / 2, y: CGFloat(dot.y) - Traits.dot.radius / 2,
      width: Traits.dot.radius, height: Traits.dot.radius)
    let dotPath = UIBezierPath(ovalIn: dotRect)

    Traits.dot.color.setFill()
    dotPath.fill()
  }

  func drawLine(of line: LineData) {
    let linePath = UIBezierPath()
    
    let from : CGPoint = CGPoint(x : CGFloat(line.from.x), y: CGFloat(line.from.y))
    let to : CGPoint = CGPoint(x : CGFloat(line.to.x), y: CGFloat(line.to.y))
    
    linePath.move(to: from)
    linePath.addLine(to: to)
    linePath.close()

    linePath.lineWidth = Traits.line.width
    Traits.line.color.setStroke()

    linePath.stroke()
  }

    @objc
  func clear() {
    self.dots = []
    self.lines = []
  }
    
    @objc
    func drawResult(result: DetectResult) {
        self.dots = result.dots;
        self.lines = result.lines;
        self.setNeedsDisplay();
    }
    
    @objc
    func clearResult() {
        self.clear()
        self.setNeedsDisplay()
    }
    
    
}

private enum Traits {
  static let dot = (radius: CGFloat(5), color: UIColor.orange)
  static let line = (width: CGFloat(1.0), color: UIColor.orange)
}
