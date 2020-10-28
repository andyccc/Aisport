//
//  ActionSelector.swift
//  PoseTest
//
//  Created by Apple on 2020/10/15.
//

import Foundation
import CoreImage
import Accelerate
import TensorFlowLite

//大动作分析器的分类器
@objc
class ActionDetectorSelector:NSObject{
    //大动作片段列表
    var flagmentList:[ActionFlagment]
    //骨架流滤波器
    var filter:KPFilter
    var modelDataHandler: ImageHandler
    
    var stdSize:Float?
    
    override init() {
        flagmentList=[ActionFlagment]()
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.PunchUpDown))
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.BodyTornAdoSideStep))
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.SquatAndSideStep))
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.BodyRollAndSideStep))//摇 加了文件 动作没做
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.SideShuffle))
        
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.SquatButtSlap))
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.StepWalk))
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.LegStretch))
        
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.SquatHoldTouches))
//        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.SumoSquat))
        flagmentList.append(ActionFlagment(startSeconds: 0,endSeconds: 10000,action:ActionEnum.StepArmCircles))
        
        filter=KPFilter()
        do {
          modelDataHandler = try ImageHandler()
        } catch let error {
          fatalError(error.localizedDescription)
        }
        
    }
    
    init(actionFlagments:[ActionFlagment]) {
        filter=KPFilter()
        flagmentList=actionFlagments
        do {
          modelDataHandler = try ImageHandler()
        } catch let error {
          fatalError(error.localizedDescription)
        }
    }
    
    
    
    //获取大动作分类器
    func getDetector(seconds:Double) -> ActionDetector? {
        for item in flagmentList{
            if seconds>=item.startSeconds && seconds<item.endSeconds{
                return item.getDetector()
            }
        }
        return nil
    }
    
    @objc
    func detect(pixelbuffer: CVPixelBuffer,seconds:Double) -> DetectResult? {
        guard
            var kpRes = self.modelDataHandler.runPoseNet(on: pixelbuffer)
        else {
            os_log("Cannot get inference result.", type: .error)
            return nil
        }
        
        kpRes.seconds=seconds
        
        //根据时间来获取大动作分析器
        if let detector=getDetector(seconds: seconds){
            //坐标归一化
            //kpRes.dots=standardize(curPoints: kpRes.dots)
            //滤波 骨架流
            //kpRes.dots=filter.filter(curPoints: kpRes.dots)
            //执行分析
            return detector.detect(kpResult: kpRes)
        }
        return nil
    }
    
    func standardize(curPoints:[String:Point]) -> [String:Point] {
        if stdSize==nil{
            let shoulderY=curPoints[KP.LEFT_SHOULDER.rawValue]!.y+curPoints[KP.RIGHT_SHOULDER.rawValue]!.y
            let hipY=curPoints[KP.LEFT_HIP.rawValue]!.y+curPoints[KP.RIGHT_HIP.rawValue]!.y
            stdSize=(hipY-shoulderY)/2
        }
        
        var resPoints=[String:Point]()
        
        curPoints.map{ key , curPoint in
            let x=curPoint.x/stdSize!
            let y=curPoint.y/stdSize!
            resPoints[key]=Point(x:x,y:y)
        }
        return resPoints
    }
}


@objc
class ActionFlagment:NSObject {
    var startSeconds:Double
    var endSeconds:Double
    var action:Action
    var detector:ActionDetector?
    
    @objc
    init(startSeconds:Double,endSeconds:Double,action:Action){
        self.startSeconds=startSeconds
        self.endSeconds=endSeconds
        self.action=action
    }
    
    func getDetector()->ActionDetector{
        guard let dtor=self.detector else {
            detector = ActionDetector(action: action)
            return detector!
        }
        return dtor
    }
}
