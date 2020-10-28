//
//  ActionDetector.swift
//  PoseTest
//
//  Created by Apple on 2020/10/15.
//

import Foundation
import CoreImage

//大动作分析器
class ActionDetector{
    var action:Action
    //小动作分析器列表
    var motionDetectorList:[BaseMotionDetector]
    //骨架流列表
    var kpResList:[KPResult]
    
    init(action:Action){
        self.action=action
        motionDetectorList=[BaseMotionDetector]()
        for motion in action.motions{
            self.motionDetectorList.append(MotionEnum.getDetector(motion: motion))
        }
        
        kpResList=[KPResult]()
    }
    
    func detect(kpResult:KPResult)->DetectResult{
        kpResList.append(kpResult)
        
        let result=DetectResult(seconds: kpResult.seconds, rect: kpResult.rect, motionMsgs: [MotionMsg](),score: kpResult.score, dots: kpResult.dots, lines: kpResult.lines)
        
        //执行所有小动作分析
        for detector in motionDetectorList{
            if let motionMsg=detector.detect(kpResList:kpResList){
                //将每个小动作检测器的结果添加到结果集
                motionMsg.action=self.action
                result.motionMsgs.append(motionMsg)
            }
        }
        return result
    }
    
}
