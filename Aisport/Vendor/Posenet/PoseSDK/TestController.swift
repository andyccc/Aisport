//
//  TestController.swift
//  PoseNet
//
//  Created by Apple on 2020/10/15.
//  Copyright © 2020 tensorflow. All rights reserved.
//

import Foundation
import UIKit
import CoreImage
import AVFoundation
import Accelerate
import TensorFlowLite

@objc
class TestController:UIViewController{
    
    private var actionDetectorSelector: ActionDetectorSelector=ActionDetectorSelector()
    private var imageView:UIImageView?
    private var drawView:UIView?
    private var label:UILabel?
    var assetGen:AVAssetImageGenerator?
    var curSeconds:Double=0
    var showSeconds:Double=0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flgmtList=[
            ActionFlagment(startSeconds: 40, endSeconds: 44, action: ActionEnum.PunchUpDown),
            ActionFlagment(startSeconds: 44, endSeconds: 74, action: ActionEnum.BodyTornAdoSideStep),
            ActionFlagment(startSeconds: 74, endSeconds: 102, action: ActionEnum.SquatAndSideStep),
            ActionFlagment(startSeconds: 102, endSeconds: 127, action: ActionEnum.BodyRollAndSideStep),
            ActionFlagment(startSeconds: 127, endSeconds: 151, action: ActionEnum.SideShuffle),
            ActionFlagment(startSeconds: 151, endSeconds: 180, action: ActionEnum.BodyTornAdoSideStep),
            ActionFlagment(startSeconds: 180, endSeconds: 204, action: ActionEnum.SquatButtSlap),
            ActionFlagment(startSeconds: 204, endSeconds: 234, action: ActionEnum.StepWalk),
            ActionFlagment(startSeconds: 234, endSeconds: 254, action: ActionEnum.LegStretch),
            ActionFlagment(startSeconds: 254, endSeconds: 292, action: ActionEnum.Hip4Squat1),
            ActionFlagment(startSeconds: 292, endSeconds: 313, action: ActionEnum.StepBackSqueeze),
            ActionFlagment(startSeconds: 313, endSeconds: 332, action: ActionEnum.SideStepWave),
            ActionFlagment(startSeconds: 332, endSeconds: 373, action: ActionEnum.SquatHoldTouches),
            ActionFlagment(startSeconds: 373, endSeconds: 393, action: ActionEnum.SumoSquat),
            ActionFlagment(startSeconds: 393, endSeconds: 434, action: ActionEnum.Hip4Squat1),
            ActionFlagment(startSeconds: 434, endSeconds: 467, action: ActionEnum.StepArmCircles),
            ActionFlagment(startSeconds: 467, endSeconds: 498, action: ActionEnum.SideStepSkyPush),
            ActionFlagment(startSeconds: 498, endSeconds: 530, action: ActionEnum.SlideBox),
            ActionFlagment(startSeconds: 530, endSeconds: 562, action: ActionEnum.StepArmCombo),
            ActionFlagment(startSeconds: 562, endSeconds: 577, action: ActionEnum.PunchUpDown),
            ActionFlagment(startSeconds: 577, endSeconds: 609, action: ActionEnum.SlideBoxFrontReach),
            ActionFlagment(startSeconds: 609, endSeconds: 625, action: ActionEnum.SquatHold),
            ActionFlagment(startSeconds: 625, endSeconds: 658, action: ActionEnum.SlideOverheadClap),
            ActionFlagment(startSeconds: 658, endSeconds: 692, action: ActionEnum.HighKnees),
            ActionFlagment(startSeconds: 692, endSeconds: 703, action: ActionEnum.SquatHoldSidePunch),
            ActionFlagment(startSeconds: 703, endSeconds: 725, action: ActionEnum.HighKnees),
            ActionFlagment(startSeconds: 725, endSeconds: 736, action: ActionEnum.SquatSlap),
            ActionFlagment(startSeconds: 736, endSeconds: 748, action: ActionEnum.HighKnees),
            ActionFlagment(startSeconds: 748, endSeconds: 759, action: ActionEnum.SquatHoldSidePunch),
            ActionFlagment(startSeconds: 759, endSeconds: 781, action: ActionEnum.HighKnees),
            ActionFlagment(startSeconds: 781, endSeconds: 803, action: ActionEnum.HalfSquatStepArms),
            ActionFlagment(startSeconds: 803, endSeconds: 826, action: ActionEnum.Squat),
            ActionFlagment(startSeconds: 826, endSeconds: 847, action: ActionEnum.HighKnees)
        ]
        
        actionDetectorSelector=ActionDetectorSelector(actionFlagments:flgmtList)
        
        self.title = "动作"
        self.view.backgroundColor = UIColor.white
        
        imageView = UIImageView.init(frame: UIScreen.main.bounds)
        self.view.addSubview(imageView!)
        imageView!.contentMode = .scaleAspectFit
        imageView!.clipsToBounds = true;
        

        label = UILabel.init(frame: CGRect(x: 15, y: UIScreen.main.bounds.size.height/2-30, width: UIScreen.main.bounds.size.width-20, height: 60))
        self.view.addSubview(label!)
        label!.textAlignment = NSTextAlignment.center
        label!.textColor = UIColor .white
        label!.font = UIFont.systemFont(ofSize: 25)
        label!.numberOfLines = 0
        
        
        

        guard let path = Bundle.main.path(forResource: "full", ofType:"mp4") else {
            debugPrint("mp4 not found")
            return
        }

        let asset=AVURLAsset(url: URL(fileURLWithPath: path))
        assetGen=AVAssetImageGenerator(asset: asset)
        assetGen!.requestedTimeToleranceAfter = CMTime.zero;
        assetGen!.requestedTimeToleranceBefore = CMTime.zero;

        let queue = DispatchQueue(label: "text.queue", attributes:    .concurrent)
        queue.async {
            for i in 1000..<100000{
                let seconds=Double(i)/25.0
                self.getImage(seconds: seconds)
            }
        }

    }
    
    
    func getImage(seconds:Double){
        
        var actualTime=CMTime()
        let options: NSDictionary = [:]

        let atTime=CMTimeMakeWithSeconds(seconds,preferredTimescale: 600)
        guard let image=try? assetGen!.copyCGImage(at: atTime, actualTime: &actualTime) else { return }
        //image=image.cropping(to: CGRect(origin: CGPoint(x:116,y:0), size: CGSize(width: 368, height: 368)))!
            
        let dataFromImageDataProvider = CFDataCreateMutableCopy(kCFAllocatorDefault, 0, image.dataProvider!.data)
            
        var pxbuffer: CVPixelBuffer? = nil
        CVPixelBufferCreateWithBytes(
                kCFAllocatorDefault,
                image.width,
                image.height,
                kCVPixelFormatType_32ARGB,
                CFDataGetMutableBytePtr(dataFromImageDataProvider),
                image.bytesPerRow,
                nil,
                nil,
                options,
                &pxbuffer
        )
            
        //let kpRes = actionDetectorSelector.modelDataHandler?.runPoseNet(on: pxbuffer!)
        guard let kpRes=actionDetectorSelector.detect(pixelbuffer: pxbuffer!, seconds: seconds) else {
            return
        }
        DispatchQueue.main.async(execute: {
            if kpRes.motionMsgs.count>0{
                let mm=kpRes.motionMsgs[0]
                
                self.label?.text=mm.motion.name+"  "+mm.msg
                self.showSeconds=kpRes.seconds
            }
            
            if kpRes.seconds-self.showSeconds>0.5{
                self.label?.text=""
            }
            
            self.imageView!.image = UIImage(cgImage: image)
        })
    }
}
