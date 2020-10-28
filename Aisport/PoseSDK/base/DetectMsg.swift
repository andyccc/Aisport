//
//  ActionDelegate.swift
//  PoseTest
//
//  Created by Apple on 2020/10/14.
//

import Foundation


enum DetectStatus:Int {
    case detected=0
    case undetected=1
    case good=2
    case bad=3
}

class DetectResult {
    var seconds:Double
    var motion:Motion
    var status:DetectStatus?
    var msg:String
    
    init(seconds:Double,motion:Motion,status:DetectStatus,msg:String) {
        self.seconds=seconds
        self.motion=motion
        self.status=status
        self.msg=msg
    }
}
