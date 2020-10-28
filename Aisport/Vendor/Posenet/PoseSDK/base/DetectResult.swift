//
//  ActionDelegate.swift
//  PoseTest
//
//  Created by Apple on 2020/10/14.
//

import Foundation
import CoreImage

@objc
class DetectResult:NSObject {
    //视频桢的秒数
    @objc
    var seconds:Double
    //人像的方框范围
    @objc
    var rect:CGRect
    //动作检测结果
    @objc
    var motionMsgs:[MotionMsg]
    @objc
    var score: Float

    @objc
    var dots: [Point]
    @objc
    var lines: [LineData]
    
    init(seconds:Double,rect:CGRect,motionMsgs:[MotionMsg], score:Float, dots: [String:Point], lines: [LineData]) {
        self.seconds=seconds
        self.motionMsgs=motionMsgs
        self.rect=rect
        self.score = score
        
        self.dots = KP.allCases.enumerated().map{ index,key->Point in
            return dots[key.rawValue]!
        }
        self.lines = lines
    }
    
    
}
