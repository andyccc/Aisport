//
//  PlaySoundService.h
//  STC
//
//  Created by andyccc on 2018/8/17.
//  Copyright © 2018年 hzty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define NeedRefreshAudio
#ifdef NeedRefreshAudio

#define PLAY_SOUND_ID(_soundId) [PlaySoundService playSoundId:_soundId]
#define PLAY_SOUND_NAME(_soundName) [PlaySoundService playSoundName:_soundName]

#define PLAY_LOGIN_SOUND() PLAY_SOUND_ID(_loginId)
#define PLAY_RESULT_SOUND() PLAY_SOUND_ID(_resultId)

@interface PlaySoundService : NSObject

+ (void)playSoundId:(SystemSoundID)soundID;
+ (void)playSoundName:(NSString *)filename;

@end

#endif

