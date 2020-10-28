//
//  PunchDownMotion.swift
//  PoseTest
//
//  Created by Apple on 2020/10/14.
//

import Foundation
import CoreImage

class PunchDownMotionDetector:BaseMotionDetector{
    static let motion=MotionEnum.PunchDown
    
    override func detect(kpResult:KPResult,seconds:Double)->DetectResult?{
        return nil
        //return DetectResult(seconds:seconds,motion: PunchUpMotionDetector.motion, status: DetectStatus.undetected, msg: "")
    }
}
