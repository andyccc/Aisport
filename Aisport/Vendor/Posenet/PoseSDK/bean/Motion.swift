//
//  ActionType.swift
//  PoseTest
//
//  Created by Apple on 2020/10/15.
//

import Foundation

enum MotionEnum {
    static let Unknown=Motion(name: "")
    static let PunchUp=Motion(name: "手臂向上举起")
    static let PunchDown=Motion(name: "手臂放下")
    static let StepRightOut=Motion(name: "右脚迈出")
    static let StepRightIn=Motion(name: "右脚收回")
    static let StepLeftOut=Motion(name: "左脚迈出")
    static let StepLeftIn=Motion(name: "左脚收回")
    static let SquatDown=Motion(name: "深蹲")
    static let SquatUp=Motion(name: "站起")
    static let BodyRoll=Motion(name: "身体摇")

    static let TouchLeftShoulder=Motion(name: "左手拍肩")
    static let TouchLeftHip=Motion(name: "左手拍臀")
    static let TouchLeftHead=Motion(name: "左手拍头")
    static let TouchRightShoulder=Motion(name: "右手拍肩")
    static let TouchRightHip=Motion(name: "右手拍臀")
    static let TouchRightHead=Motion(name: "右手拍头")
    static let StepWalkLeft=Motion(name: "左走三步")
    static let StepWalkRight=Motion(name: "左走三步")

    static let SideShuffleToLeft=Motion(name: "右手摸左脚")
    static let SideShuffleToRight=Motion(name: "左手摸右脚")
    static let ArmsOpen=Motion(name: "双手打开")
    static let ArmsBack=Motion(name: "双手收回")
    
    static func getDetector(motion:Motion?)->BaseMotionDetector{
        switch motion {
        case PunchUp:
            return PunchUpMotionDetector(maxCycleSeconds: 2)
        case PunchDown:
            return PunchDownMotionDetector(maxCycleSeconds: 2)
        case StepRightOut:
            return StepLeftOutMotionDetector(maxCycleSeconds: 2)
        case StepRightIn:
            return StepRightInMotionDetector(maxCycleSeconds: 2)
        case StepLeftOut:
            return StepLeftOutMotionDetector(maxCycleSeconds: 2)
        case StepLeftIn:
            return StepLeftInMotionDetector(maxCycleSeconds: 2)
        case SquatDown:
            return SquatDownMotionDetector(maxCycleSeconds: 2)
        case SquatUp:
            return SquatUpMotionDetector(maxCycleSeconds: 2)
//        case BodyRoll:
//            return BodyRollMotionDetector(maxCycleSeconds: 2)
        case TouchLeftShoulder:
            return TouchMotionDetector(kp1:KP.LEFT_WRIST,kp2:KP.LEFT_SHOULDER,maxCycleSeconds: 10)
        case TouchLeftHip:
            return TouchMotionDetector(kp1:KP.LEFT_WRIST,kp2:KP.LEFT_HIP,maxCycleSeconds: 10)
        case TouchLeftHead:
            return TouchMotionDetector(kp1:KP.LEFT_WRIST,kp2:KP.NOSE,maxCycleSeconds: 10)
        case TouchRightShoulder:
            return TouchMotionDetector(kp1:KP.RIGHT_WRIST,kp2:KP.RIGHT_SHOULDER,maxCycleSeconds: 10)
        case TouchRightHip:
            return TouchMotionDetector(kp1:KP.RIGHT_WRIST,kp2:KP.RIGHT_HIP,maxCycleSeconds: 10)
        case TouchRightHead:
            return TouchMotionDetector(kp1:KP.RIGHT_WRIST,kp2:KP.NOSE,maxCycleSeconds: 10)
        case StepWalkLeft:
            return StepWalkLeftMotionDetector(maxCycleSeconds: 2)
        case StepWalkRight:
            return StepWalkRightMotionDetector(maxCycleSeconds: 2)
        case SideShuffleToLeft:
            return SideShuffleToLeftMotionDetector(maxCycleSeconds: 2)
        case SideShuffleToRight:
            return SideShuffleToRightMotionDetector(maxCycleSeconds: 2)
            
        case ArmsOpen:
            return ArmsOpenMotionDetector(maxCycleSeconds: 2)
        case ArmsBack:
            return ArmsBackMotionDetector(maxCycleSeconds: 2)
        default:
            return BaseMotionDetector(maxCycleSeconds: 100)
        }
        
    }
}

@objc
class Motion:NSObject{
    @objc
    var name:String
        
    fileprivate init(name:String) {
        self.name=name
    }
}
