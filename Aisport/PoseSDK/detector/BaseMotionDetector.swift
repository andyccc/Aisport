//
//  PoseDelegate.swift
//  PoseTest
//
//  Created by Apple on 2020/10/14.
//

import Foundation
import CoreImage


class BaseMotionDetector {
    var lastDetectedSeconds:Float
    
    init() {
        lastDetectedSeconds=0
    }
    
    func detect(kpResult:KPResult,seconds:Double)->DetectResult?{
        return nil
    }
    
}
