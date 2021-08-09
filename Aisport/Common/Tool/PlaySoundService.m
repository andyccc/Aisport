//
//  PlaySoundService.m
//  STC
//
//  Created by andyccc on 2018/8/17.
//  Copyright © 2018年 andyccc. All rights reserved.
//

#import "PlaySoundService.h"

#ifdef NeedRefreshAudio

static NSMutableDictionary *_creatureIds;


@implementation PlaySoundService

#if DEBUG

+ (void)load
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
////        [PlaySoundService playSoundName:@"test.mp3"];
//        
//        static AVPlayer *_player= nil;
//        // 1.获取URL(远程/本地)
//        NSURL *url = [[NSBundle mainBundle] URLForResource:@"test.mp3" withExtension:nil];
//        //                NSURL *url = [NSURL URLWithString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
//        
//        // 2.创建AVPlayerItem
//        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
//        
//        // 3.创建AVPlayer
//        _player = [AVPlayer playerWithPlayerItem:item];
//        
//        [_player play];
//        
//    });
}

#endif

#pragma 声效交互
+ (void)playSoundName:(NSString *)filename
{
    SystemSoundID soundID = [self loadSoundName:filename];
    
    [self playSoundId:soundID];
}

+ (void)playSoundId:(SystemSoundID)soundID
{
    [self playSoundId:soundID withVibrate:NO];
}

+ (void)playSoundId:(SystemSoundID)soundID withVibrate:(BOOL)vibrate
{
    if (soundID <= 0) {
        return;
    }
    AudioServicesPlaySystemSound(soundID);//播放声音
    if (vibrate) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//让手机震动
    }
}

+ (SystemSoundID)loadSoundName:(NSString *)filename
{
    if (!_creatureIds) {
        _creatureIds = [NSMutableDictionary dictionary];
    }
    
    NSNumber *sound = _creatureIds[filename];
    if (sound) {
        return [sound unsignedIntValue];
    }
    
    SystemSoundID soundID;
    NSBundle *bundle = [NSBundle mainBundle];
    NSURL *url = [bundle URLForResource:filename withExtension:nil];
    //注册声音到系统
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
    
    _creatureIds[filename] = @(soundID);
    return soundID;
}

@end

#endif
