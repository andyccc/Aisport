//
//  PoseDelegate.swift
//  PoseTest
//
//  Created by Apple on 2020/10/14.
//

import Foundation
import CoreImage


class BaseMotionDetector {
    var motion:Motion=MotionEnum.Unknown
    var lastDetSeconds:Double?
    var maxCycleSeconds:Double
    
    init(maxCycleSeconds:Double) {
        self.maxCycleSeconds=maxCycleSeconds
    }
    
    func detect(kpResList:[KPResult])->MotionMsg?{
        if kpResList.count>0{
            let kpResult=kpResList[0]
            
            guard let lastSecond=lastDetSeconds else {
                lastDetSeconds=kpResult.seconds
                return nil
            }
            
            if kpResult.seconds-lastSecond>maxCycleSeconds{
                lastDetSeconds=kpResult.seconds
                return MotionMsg(motion: motion, status: MotionStatus.undetected, msg: "未检测到动作")
            }
        }
        
        return nil
    }
    
}
