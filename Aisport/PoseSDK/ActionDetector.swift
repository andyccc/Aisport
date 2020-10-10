//
//  ActionDetector.swift
//  PoseTest
//
//  Created by Apple on 2020/10/15.
//

import Foundation
import CoreImage

class ActionDetector{
    var action:ActionEnum
    var motionDetectorList:[BaseMotionDetector]
    
    init(action:ActionEnum,motionDetectorList:[BaseMotionDetector]){
        self.action=action
        self.motionDetectorList=motionDetectorList
    }
    
    func detect(kpResult:KPResult,seconds:Double)->[DetectResult]{
        var resList=[DetectResult]()
        for detector in motionDetectorList{
            if let detRes=detector.detect(kpResult:kpResult,seconds:seconds){
                resList.append(detRes)
            }
        }
        return resList
    }
}
