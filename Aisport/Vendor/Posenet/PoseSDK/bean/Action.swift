//
//  Action.swift
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

import Foundation

enum ActionEnum{
    static let Unknown=Action(name:"",motions: [])
    static let PunchUpDown=Action(name:"PunchUpDown",motions: [MotionEnum.PunchUp,
                                                               MotionEnum.PunchDown])
    
    static let BodyTornAdoSideStep=Action(name:"Body TornAdo + Side Step",motions:  [MotionEnum.StepRightOut,
                                                          MotionEnum.StepRightIn,
                                                          MotionEnum.StepLeftOut,
                                                          MotionEnum.StepLeftIn])
    
    static let SquatAndSideStep=Action(name:"Squat + Side Step",motions:  [MotionEnum.SquatDown,
                                                    MotionEnum.SquatUp,
                                                    MotionEnum.StepRightOut,
                                                    MotionEnum.StepRightIn,
                                                    MotionEnum.StepLeftOut,
                                                    MotionEnum.StepLeftIn])
    
    static let BodyRollAndSideStep=Action(name:"Body Roll + Side Step",motions:  [MotionEnum.BodyRoll,
                                                    MotionEnum.StepRightOut,
                                                    MotionEnum.StepRightIn,
                                                    MotionEnum.StepLeftOut,
                                                    MotionEnum.StepLeftIn])
        
    static let SideShuffle=Action(name:"Side Shuffle",motions:  [MotionEnum.SideShuffleToLeft,
                                                                MotionEnum.SideShuffleToRight])
    
    static let BodyTornadoSideStep=Action(name:"Body Tornado + Side Step",motions:  [MotionEnum.StepRightOut,
                                                                                     MotionEnum.StepRightIn,
                                                                                     MotionEnum.StepLeftOut,
                                                                                     MotionEnum.StepLeftIn])
    static let SquatButtSlap=Action(name:"Squat + Butt Slap",motions:  [MotionEnum.SquatDown,
                                                                        MotionEnum.SquatUp,
                                                                        MotionEnum.TouchLeftHip,
                                                                        MotionEnum.TouchRightHip])
    static let StepWalk=Action(name:"Step Walk",motions:  [MotionEnum.StepWalkLeft,
                                                           MotionEnum.StepWalkRight])
    static let LegStretch=Action(name:"LEG STRETCH",motions:  [MotionEnum.SideShuffleToLeft,
                                                               MotionEnum.SideShuffleToRight])
    static let Hip4Squat1=Action(name:"4X HIP 1X SQUAT",motions:  [MotionEnum.SideShuffleToLeft,
                                                                   MotionEnum.SideShuffleToRight])
    static let StepBackSqueeze=Action(name:"STEP+BACK SQUEEZE",motions:  [MotionEnum.StepRightOut,
                                                                          MotionEnum.StepRightIn,
                                                                          MotionEnum.StepLeftOut,
                                                                          MotionEnum.StepLeftIn])
    static let SideStepWave=Action(name:"SIDE STEP+WAVE",motions:  [MotionEnum.StepRightOut,
                                                                    MotionEnum.StepRightIn,
                                                                    MotionEnum.StepLeftOut,
                                                                    MotionEnum.StepLeftIn])
    static let SquatHoldTouches=Action(name:"SQUAT HOLD+TOUCHES",motions:  [MotionEnum.TouchLeftShoulder,
                                                                            MotionEnum.TouchLeftHip,
                                                                            MotionEnum.TouchLeftHead,
                                                                            MotionEnum.TouchRightShoulder,
                                                                            MotionEnum.TouchRightHip,
                                                                            MotionEnum.TouchRightHead])
    static let SumoSquat=Action(name:"SUMO SQUAT",motions:  [MotionEnum.SquatDown,
                                                             MotionEnum.SquatUp])
    static let StepArmCircles=Action(name:"STEP+ARM CIRCLES",motions:  [MotionEnum.ArmsOpen,
                                                                        MotionEnum.ArmsBack])
    static let SideStepSkyPush=Action(name:"SIDE STEP+SKY PUSH",motions:  [MotionEnum.StepRightOut,
                                                                           MotionEnum.StepRightIn,
                                                                           MotionEnum.StepLeftOut,
                                                                           MotionEnum.StepLeftIn])
    static let SlideBox=Action(name:"SLIDE+BOX",motions:  [MotionEnum.StepRightOut,
                                                           MotionEnum.StepRightIn,
                                                           MotionEnum.StepLeftOut,
                                                           MotionEnum.StepLeftIn])
    static let StepArmCombo=Action(name:"STEP+ARM COMBO",motions:  [MotionEnum.ArmsOpen,
                                                                    MotionEnum.ArmsBack])
    static let SlideBoxFrontReach=Action(name:"SLIDE+BOX+FRONT REACH",motions:  [])
    static let SquatHold=Action(name:"SQUAT HOLD",motions:  [MotionEnum.SquatDown,
                                                             MotionEnum.SquatUp])
    static let SlideOverheadClap=Action(name:"SLIDE+OVERHEAD CLAP",motions:  [MotionEnum.StepRightOut,
                                                                              MotionEnum.StepRightIn,
                                                                              MotionEnum.StepLeftOut,
                                                                              MotionEnum.StepLeftIn])
    static let HighKnees=Action(name:"HIGH KNEES",motions:  [])
    static let SquatHoldSidePunch=Action(name:"SQUAT HOLD+SIDE PUNCH",motions:  [MotionEnum.SquatDown,
                                                                                 MotionEnum.SquatUp])
    static let SquatSlap=Action(name:"SQUAT+SLAP",motions:  [MotionEnum.SquatDown,
                                                             MotionEnum.SquatUp])
    static let HalfSquatStepArms=Action(name:"HALF SQUAT STEP+ARMS",motions:  [MotionEnum.StepRightOut,
                                                                               MotionEnum.StepRightIn,
                                                                               MotionEnum.StepLeftOut,
                                                                               MotionEnum.StepLeftIn])
    static let Squat=Action(name:"SQUAT",motions:  [MotionEnum.SquatDown,
                                                    MotionEnum.SquatUp])
}

@objc
class Action:NSObject{
    @objc
    var name:String
    @objc
    var motions:[Motion]
    
    init(name:String,motions:[Motion]) {
        self.name=name
        self.motions=motions
    }
}
