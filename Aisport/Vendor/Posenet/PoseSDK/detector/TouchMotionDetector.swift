//
//  TouchMotionDetector.swift
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

import Foundation

class TouchMotionDetector:BaseMotionDetector{
    
    var kp1:KP
    var kp2:KP
    var thresDist:Float=30
    
    init(kp1:KP,kp2:KP,maxCycleSeconds:Double) {
        self.kp1=kp1
        self.kp2=kp2
        super.init(maxCycleSeconds:maxCycleSeconds)
        motion=MotionEnum.PunchUp
    }
    
    func setKp(kp1:KP,kp2:KP){
    }
    
    //动作检测
    override func detect(kpResList:[KPResult])->MotionMsg?{
        guard let res=analyse(kpResList: kpResList) else {
            return super.detect(kpResList:kpResList)
        }
        
        return res
    }
    
    //判断动作准确性
    func analyse(kpResList:[KPResult])->MotionMsg?{
        
        guard let curKpRes=kpResList.last else {
            return nil
        }
        let curSeconds=curKpRes.seconds
        let preKpList=kpResList.filter{ (kpRes) in
            return kpRes.seconds>=curSeconds-1 && kpRes.seconds<curSeconds
        }
        
        if preKpList.count<=0{
            return nil
        }
        
        let curDist=dist(kpRes: curKpRes)
        if curDist>thresDist{
            return nil
        }
        
        let preDistList=preKpList.map{(kpResult)->Float in
            return dist(kpRes: kpResult)
        }
        
        //之前曾经拍过 不重复返回
        if preDistList.min()!<thresDist{
            return nil
        }
        
        return MotionMsg(motion: motion, status: MotionStatus.good, msg: "标准")
    }
    
    func dist(kpRes:KPResult)->Float{
        guard let p1=kpRes.dots[kp1.rawValue],let p2=kpRes.dots[kp2.rawValue] else {
            return Float(Int.max)
        }
        
        let dx=p1.x-p2.x
        let dy=p1.y-p2.y
        
        return sqrt(dx*dx+dy*dy)
    }
}
