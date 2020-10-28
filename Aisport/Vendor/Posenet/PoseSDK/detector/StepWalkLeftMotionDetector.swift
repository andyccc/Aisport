//
//  StepWalkLeftMotionDetector.swift
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

import Foundation


class StepWalkLeftMotionDetector:BaseMotionDetector{
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
        motion=MotionEnum.PunchUp
    }
    
    //动作检测
    override func detect(kpResList:[KPResult])->MotionMsg?{
        updateState(kpResList:kpResList)
        
        if state==PunchUpMotionDetector.STATE_END{
            return analyse(kpResList:kpResList)
        }
        
        return super.detect(kpResList:kpResList)
    }
    
    //判断动作准确性
    func analyse(kpResList:[KPResult])->MotionMsg?{
        //TODO
        let newKpList=kpResList.filter{ (kpRes) in
            return kpRes.seconds>startSecond!
        }
        
        if newKpList.count<=5{
            return nil
        }
        
        //判断手的摆动幅度
        let wirstYList=newKpList.map{(kpResult)->Float in
            return Float(kpResult.dots[KP.LEFT_WRIST.rawValue]!.y)
        }
        guard let maxY=wirstYList.max(),let minY=wirstYList.min() else {
            return nil
        }
        
        if maxY-minY<80{
            return MotionMsg(motion: motion, status: MotionStatus.bad, msg:"手臂向上幅度不足")
        }
        
        //TODO 判断最近5帧手交叉
        let distList=newKpList[(newKpList.endIndex-5)..<newKpList.endIndex].map{(kpResult)->Float in
            let wristDistX=kpResult.dots[KP.LEFT_WRIST.rawValue]!.x-kpResult.dots[KP.RIGHT_WRIST.rawValue]!.x
            let shoulderDistX=kpResult.dots[KP.LEFT_SHOULDER.rawValue]!.x-kpResult.dots[KP.RIGHT_SHOULDER.rawValue]!.x
            return Float(wristDistX-shoulderDistX)
        }
        
        if distList.min()!>0{
            return MotionMsg(motion: motion, status: MotionStatus.bad, msg:"手臂向上时没有交叉")
        }
        
        return MotionMsg(motion: motion, status: MotionStatus.good, msg: "标准")
    }
    
    //更新状态机
    func updateState(kpResList:[KPResult]){
        if kpResList.count<4{
            state=PunchUpMotionDetector.STATE_NOT_DOING
            return
        }
        
        let curRes=kpResList[kpResList.count-1]
        let preRes=kpResList[kpResList.count-4]
        
        guard let curNose=curRes.dots[KP.NOSE.rawValue],let preNose=preRes.dots[KP.NOSE.rawValue] else {
            return
        }
        
        if state==PunchUpMotionDetector.STATE_START{
            state = (curNose.y-preNose.y>0) ? PunchUpMotionDetector.STATE_DOING : PunchUpMotionDetector.STATE_END
        }
        else if state==PunchUpMotionDetector.STATE_DOING{
            state = (curNose.y-preNose.y>0) ? PunchUpMotionDetector.STATE_DOING : PunchUpMotionDetector.STATE_END
        }
        else if state==PunchUpMotionDetector.STATE_END{
            state = PunchUpMotionDetector.STATE_NOT_DOING
        }
        else if state==PunchUpMotionDetector.STATE_NOT_DOING{
            state = (curNose.y-preNose.y > 20) ? PunchUpMotionDetector.STATE_START : PunchUpMotionDetector.STATE_NOT_DOING
        }
        
        if state==PunchUpMotionDetector.STATE_END{
            lastDetSeconds=curRes.seconds
        }
        if state==PunchUpMotionDetector.STATE_START{
            startSecond=preRes.seconds
        }
    }
}
