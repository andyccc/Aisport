//
//  SoundPlayCenter.m
//  Aisport
//
//  Created by Apple on 2020/10/22.
//

#import "SoundPlayCenter.h"

@interface SoundPlayCenter ()

@property (strong ,nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation SoundPlayCenter

+ (instancetype)defaultCenter
{
    static SoundPlayCenter * defaultCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[self alloc] init];
    });
    return defaultCenter;
}

- (void)playAudioSoundWithResource:(NSString *)resource Extention:(NSString *)extention
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
//    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setCategory:AVAudioSessionCategorySoloAmbient mode:AVAudioSessionModeVoicePrompt options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setActive:YES error:nil];
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    NSError *playerError;
    NSURL *url = [[NSBundle mainBundle] URLForResource:resource withExtension:extention];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%@.%@",@"gameOpenReward1",@"mp3"] withExtension:nil];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&playerError];
    // 设置播放循环次数
    [self.audioPlayer setNumberOfLoops:0];
    // 音量，0-1之间
    [self.audioPlayer setVolume:15];
//    [self.auplayer setDelegate:self];
    // 分配播放所需的资源，并将其加入内部播放队列
    [self.audioPlayer prepareToPlay];
    // 开始播放录音
    [self.audioPlayer play];
}

@end
