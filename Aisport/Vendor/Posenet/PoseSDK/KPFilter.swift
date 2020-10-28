//
//  KPFilter.swift
//  PoseNet
//
//  Created by Apple on 2020/10/20.
//  Copyright © 2020 tensorflow. All rights reserved.
//

import Foundation
import CoreImage

class KPFilter{
    var threshold:[String:Float]
    var lastPoints:[String:Point]?
    var proposalPoints:[String:Point]?
    
    init() {
        threshold=[String:Float]()
        threshold[KP.NOSE.rawValue]=20
        threshold[KP.LEFT_EYE.rawValue]=20
        threshold[KP.RIGHT_EYE.rawValue]=20
        threshold[KP.LEFT_EAR.rawValue]=20
        threshold[KP.RIGHT_EAR.rawValue]=20
        threshold[KP.LEFT_SHOULDER.rawValue]=20
        threshold[KP.RIGHT_SHOULDER.rawValue]=20
        threshold[KP.LEFT_ELBOW.rawValue]=20
        threshold[KP.RIGHT_ELBOW.rawValue]=20
        threshold[KP.LEFT_WRIST.rawValue]=20
        threshold[KP.RIGHT_WRIST.rawValue]=20
        threshold[KP.LEFT_HIP.rawValue]=20
        threshold[KP.RIGHT_HIP.rawValue]=20
        threshold[KP.LEFT_KNEE.rawValue]=20
        threshold[KP.RIGHT_KNEE.rawValue]=20
        threshold[KP.LEFT_ANKLE.rawValue]=20
        threshold[KP.RIGHT_ANKLE.rawValue]=20
    }
    
    func filter(curPoints:[String:Point])->[String:Point]{
        guard let points=proposalPoints
        else{
            proposalPoints=predict(points:curPoints)
            lastPoints=curPoints
            return curPoints
        }
        
        var newPoints=[String:Point]()
        curPoints.map{ key , curPoint  in
            let proposalPoint=points[key]!
            
            let minX=proposalPoint.x-threshold[key]!
            let minY=proposalPoint.y-threshold[key]!
            let maxX=proposalPoint.x+threshold[key]!
            let maxY=proposalPoint.y+threshold[key]!
            
            let x=curPoint.x>maxX ? maxX : (curPoint.x<minX ? minX : curPoint.x)
            let y=curPoint.y>maxY ? maxY : (curPoint.y<minY ? minY : curPoint.y)

            newPoints[key]=Point(x:x,y:y)
        }
        proposalPoints=predict(points:curPoints)
        lastPoints=newPoints
        return newPoints
    }
    
    func predict(points:[String:Point])->[String:Point]{
        guard let lps=lastPoints
        else{
            return points
        }
        
        var res=[String:Point]()
        points.map{ key , point  in
            let distX=point.x-lps[key]!.x
            let distY=point.y-lps[key]!.y
            res[key] = Point(x: point.x+distX, y: point.y+distY)
        }
        
        return res
    }
    
    
}
