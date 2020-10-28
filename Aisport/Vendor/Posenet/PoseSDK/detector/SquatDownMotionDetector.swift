//
//  SquatDownMotionDetector.swift
//  Aisport
//
//  Created by 堂正 on 2020/10/26.
//

import Foundation
import CoreImage

class SquatDownMotionDetector:BaseMotionDetector{
    

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
        motion=MotionEnum.SquatDown
    }
    
    //动作检测
    override func detect(kpResList:[KPResult])->MotionMsg?{
        updateState(kpResList:kpResList)
        
        if state==SquatDownMotionDetector.STATE_END{
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
        
        let noseYList=newKpList.map{(kpResult)->Float in
            return Float(kpResult.dots[KP.NOSE.rawValue]!.y)
        }
        
        guard let maxY=noseYList.max(),let minY=noseYList.min() else {
            return MotionMsg(motion: motion, status: MotionStatus.good, msg: "")
        }
        //判断鼻子的变动幅度
        if maxY-minY<100{
            return MotionMsg(motion: motion, status: MotionStatus.bad, msg:"深蹲幅度不足")
        }
        
        return MotionMsg(motion: motion, status: MotionStatus.good, msg: "标准")
    }
    
    //更新状态机
    func updateState(kpResList:[KPResult]){
        if kpResList.count<4{
            state=SquatDownMotionDetector.STATE_NOT_DOING
            return
        }
        
        let curRes=kpResList[kpResList.count-1]
        let preRes=kpResList[kpResList.count-4]
        
        guard let curPos=curRes.dots[KP.NOSE.rawValue],let prePos=preRes.dots[KP.NOSE.rawValue] else {
            return
        }
        
        if state==SquatDownMotionDetector.STATE_START{
            state = (curPos.y-prePos.y>0) ? SquatDownMotionDetector.STATE_DOING : SquatDownMotionDetector.STATE_END
        }
        else if state==SquatDownMotionDetector.STATE_DOING{
            state = (curPos.y-prePos.y>0) ? SquatDownMotionDetector.STATE_DOING : SquatDownMotionDetector.STATE_END
        }
        else if state==SquatDownMotionDetector.STATE_END{
            state = SquatDownMotionDetector.STATE_NOT_DOING
        }
        else if state==SquatDownMotionDetector.STATE_NOT_DOING{
            state = (curPos.y-prePos.y > 50) ? SquatDownMotionDetector.STATE_START : SquatDownMotionDetector.STATE_NOT_DOING
        }
        
        if state==SquatDownMotionDetector.STATE_END{
            lastDetSeconds=curRes.seconds
        }
        if state==SquatDownMotionDetector.STATE_START{
            startSecond=preRes.seconds
        }
    }
}