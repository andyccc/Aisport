//
//  ActionType.swift
//  PoseTest
//
//  Created by Apple on 2020/10/15.
//

import Foundation

enum ActionEnum{
    case PunchUpDown
}

enum MotionEnum {
    static let PunchUp=Motion(action: ActionEnum.PunchUpDown, name: "手臂向上举起")
    static let PunchDown=Motion(action: ActionEnum.PunchUpDown, name: "手臂放下")
}

class Motion{
    var action:ActionEnum
    var name:String
    
    init(action:ActionEnum,name:String) {
        self.action=action
        self.name=name
    }
}
