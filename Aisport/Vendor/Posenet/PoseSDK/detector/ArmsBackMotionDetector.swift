//
//  ArmsBackMotionDetector.swift
//  Aisport
//
//  Created by 堂正 on 2020/10/27.
//

import Foundation
class ArmsBackMotionDetector:BaseMotionDetector{
    
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
        motion=MotionEnum.ArmsBack
    }
    
    //动作检测
    override func detect(kpResList:[KPResult])->MotionMsg?{
        updateState(kpResList:kpResList)
        
        if state==ArmsBackMotionDetector.STATE_END{
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
        let wirstXList=newKpList.map{(kpResult)->Float in
            return Float(kpResult.dots[KP.LEFT_WRIST.rawValue]!.x)
        }
        
        guard let maxX=wirstXList.max(),let minX=wirstXList.min() else {
            return MotionMsg(motion: motion, status: MotionStatus.good, msg: "")
        }
        //判断左手的变动幅度
        if maxX-minX<100{
            return MotionMsg(motion: motion, status: MotionStatus.bad, msg:"打开幅度不足")
        }
        
        
        return MotionMsg(motion: motion, status: MotionStatus.good, msg: "标准")
    }
    
    //更新状态机
    func updateState(kpResList:[KPResult]){
        if kpResList.count<4{
            state=ArmsBackMotionDetector.STATE_NOT_DOING
            return
        }
        
        let curRes=kpResList[kpResList.count-1]
        let preRes=kpResList[kpResList.count-4]
        
        guard let curPos=curRes.dots[KP.LEFT_WRIST.rawValue],let prePos=preRes.dots[KP.LEFT_WRIST.rawValue] else {
            return
        }
        if state==ArmsBackMotionDetector.STATE_START{
            state = (curPos.x-prePos.x<0) ? ArmsBackMotionDetector.STATE_DOING : ArmsBackMotionDetector.STATE_END
        }
        else if state==ArmsBackMotionDetector.STATE_DOING{
            state = (curPos.x-prePos.x<0) ? ArmsBackMotionDetector.STATE_DOING : ArmsBackMotionDetector.STATE_END
        }
        else if state==ArmsBackMotionDetector.STATE_END{
            state = ArmsBackMotionDetector.STATE_NOT_DOING
        }
        else if state==ArmsBackMotionDetector.STATE_NOT_DOING{
            state = (curPos.x-prePos.x < -40) ? ArmsBackMotionDetector.STATE_START : ArmsBackMotionDetector.STATE_NOT_DOING
        }
        
        if state==ArmsBackMotionDetector.STATE_END{
            lastDetSeconds=curRes.seconds
        }
        if state==ArmsBackMotionDetector.STATE_START{
            startSecond=preRes.seconds
        }
    }
}


