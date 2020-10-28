//
//  MotionMsg.swift
//  PoseNet
//
//  Created by Apple on 2020/10/20.
//  Copyright © 2020 tensorflow. All rights reserved.
//

import Foundation

enum MotionStatus:Int {
    case detected=0
    case undetected=1
    case good=2
    case bad=3
}

@objc
class MotionMsg:NSObject {
    var action:Action
    @objc
    var motion:Motion
//    @objc
    var status:MotionStatus?
    @objc
    var statusType:Int
    @objc
    var msg:String
    
    init(action:Action=ActionEnum.Unknown,motion:Motion,status:MotionStatus,msg:String, statusType:Int = 0) {
        self.action=action
        self.motion=motion
        self.status=status
        self.msg=msg
        self.statusType = self.status?.rawValue ?? 0
    }
}

