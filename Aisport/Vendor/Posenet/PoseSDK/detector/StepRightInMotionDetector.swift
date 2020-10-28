//
//  StepRightInMotionDetector.swift
//  Aisport
//
//  Created by 堂正 on 2020/10/23.
//

import Foundation
import CoreImage

class StepRightInMotionDetector:BaseMotionDetector{
        
    //正在做动作
    static let STATE_DOING=0
    //未在做动作
    static let STATE_NOT_DOING=1
    //动作开始
    static let STATE_START=2
    //动作结束
    static let STATE_END=3
    
    //状态
    var state:Int=STATE_NOT_DOING
    var startSecond:Double?
    
    override init(maxCycleSeconds:Double) {
        super.init(maxCycleSeconds:maxCycleSeconds)
        motion=MotionEnum.StepRightIn
    }
    
    //动作检测
    override func detect(kpResList:[KPResult])->MotionMsg?{
        updateState(kpResList:kpResList)
        
        if state==StepRightInMotionDetector.STATE_END{
            return analyse(kpResList:kpResList)
        }
        
        return super.detect(kpResList:kpResList)
    }
    
    //判断动作准确性
    func analyse(kpResList:[KPResult])->MotionMsg?{
        
        let newKpList=kpResList.filter{ (kpRes) in
            return kpRes.seconds>startSecond!
        }
        if newKpList.count<=5{
            return nil
        }
        
        //判断右脚
        let ankleXList=newKpList.map{(kpResult)->Float in
            return Float(kpResult.dots[KP.RIGHT_ANKLE.rawValue]!.x)
        }
        guard let maxX=ankleXList.max(),let minX=ankleXList.min() else {
            return nil
        }
        
        if maxX-minX<40{
            return MotionMsg(motion: motion, status: MotionStatus.bad, msg:"收回幅度太小")
        }
        
        return MotionMsg(motion: motion, status: MotionStatus.good, msg: "标准")
    }
    
    //更新状态机
    func updateState(kpResList:[KPResult]){
        if kpResList.count<4{
            state=StepRightInMotionDetector.STATE_NOT_DOING
            return
        }
        
        let curRes=kpResList[kpResList.count-1]
        let preRes=kpResList[kpResList.count-4]
        
        guard let curAnkle=curRes.dots[KP.RIGHT_ANKLE.rawValue],let preAnkle=preRes.dots[KP.RIGHT_ANKLE.rawValue] else {
            return
        }
        
        if state==StepRightInMotionDetector.STATE_START{
            state = (curAnkle.x-preAnkle.x>0) ? StepRightInMotionDetector.STATE_DOING : StepRightInMotionDetector.STATE_END
        }
        else if state==StepRightInMotionDetector.STATE_DOING{
            state = (curAnkle.x-preAnkle.x>0) ? StepRightInMotionDetector.STATE_DOING : StepRightInMotionDetector.STATE_END
        }
        else if state==StepRightInMotionDetector.STATE_END{
            state = StepRightInMotionDetector.STATE_NOT_DOING
        }
        else if state==StepRightInMotionDetector.STATE_NOT_DOING{
            state = (curAnkle.x-preAnkle.x>40) ? StepRightInMotionDetector.STATE_START : StepRightInMotionDetector.STATE_NOT_DOING
        }
        
        if state==StepRightInMotionDetector.STATE_END{
            lastDetSeconds=curRes.seconds
        }
        if state==StepRightInMotionDetector.STATE_START{
            startSecond=preRes.seconds
        }
    }
}

