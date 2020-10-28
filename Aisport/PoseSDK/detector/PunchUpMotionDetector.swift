//
//  Pos1.swift
//  PoseTest
//
//  Created by Apple on 2020/10/14.
//

import Foundation
import CoreImage

class PunchUpMotionDetector:BaseMotionDetector{
    
    static let motion=MotionEnum.PunchUp
    
    override func detect(kpResult:KPResult,seconds:Double)->DetectResult?{
        return nil
        //return DetectResult(seconds:seconds,motion: PunchUpMotionDetector.motion, status: DetectStatus.undetected, msg: "")
    }
}
