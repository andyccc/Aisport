//
//  PunchDownMotion.swift
//  PoseTest
//
//  Created by Apple on 2020/10/14.
//

import Foundation
import CoreImage

class PunchDownMotionDetector:BaseMotionDetector{
    
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
        motion=MotionEnum.PunchDown
    }
    
    //动作检测
    override func detect(kpResList:[KPResult])->MotionMsg?{
        updateState(kpResList:kpResList)
        
        if state==PunchDownMotionDetector.STATE_END{
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
        
        //判断手的摆动幅度
        let wirstYList=newKpList.map{(kpResult)->Float in
            return Float(kpResult.dots[KP.LEFT_WRIST.rawValue]!.y)
        }
        
        guard let maxY=wirstYList.max(),let minY=wirstYList.min() else {
            return MotionMsg(motion: motion, status: MotionStatus.good, msg: "")
        }
        
        if maxY-minY<80{
            return MotionMsg(motion: motion, status: MotionStatus.bad, msg:"手臂向下幅度不足")
        }
        
        //TODO 判断最近5帧手交叉
        let distList=newKpList[(newKpList.endIndex-5)..<newKpList.endIndex].map{(kpResult)->Float in
            let wristDistX=kpResult.dots[KP.LEFT_WRIST.rawValue]!.x-kpResult.dots[KP.RIGHT_WRIST.rawValue]!.x
            let shoulderDistX=kpResult.dots[KP.LEFT_SHOULDER.rawValue]!.x-kpResult.dots[KP.RIGHT_SHOULDER.rawValue]!.x
            return Float(wristDistX-shoulderDistX)
        }
        
        if distList.max()!<0{
            return MotionMsg(motion: motion, status: MotionStatus.bad, msg:"手臂向下时超过肩宽")
        }
        
        return MotionMsg(motion: motion, status: MotionStatus.good, msg: "标准")
    }
    
    //更新状态机
    func updateState(kpResList:[KPResult]){
        if kpResList.count<4{
            state=PunchDownMotionDetector.STATE_NOT_DOING
            return
        }
        
        let curRes=kpResList[kpResList.count-1]
        let preRes=kpResList[kpResList.count-4]
        
        guard let curWrist=curRes.dots[KP.LEFT_WRIST.rawValue],let preWrist=preRes.dots[KP.LEFT_WRIST.rawValue] else {
            return
        }
        
        if state==PunchDownMotionDetector.STATE_START{
            state = (curWrist.y-preWrist.y>0) ? PunchDownMotionDetector.STATE_DOING : PunchDownMotionDetector.STATE_END
        }
        else if state==PunchDownMotionDetector.STATE_DOING{
            state = (curWrist.y-preWrist.y>0) ? PunchDownMotionDetector.STATE_DOING : PunchDownMotionDetector.STATE_END
        }
        else if state==PunchDownMotionDetector.STATE_END{
            state = PunchDownMotionDetector.STATE_NOT_DOING
        }
        else if state==PunchDownMotionDetector.STATE_NOT_DOING{
            state = (curWrist.y-preWrist.y > 40) ? PunchDownMotionDetector.STATE_START : PunchDownMotionDetector.STATE_NOT_DOING
        }
        
        if state==PunchDownMotionDetector.STATE_END{
            lastDetSeconds=curRes.seconds
        }
        if state==PunchDownMotionDetector.STATE_START{
            startSecond=preRes.seconds
        }
    }
}
