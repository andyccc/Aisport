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

- (void)playAudioSoundWithResource:(NSString *)resource Extention:(NSString *)extention  WithVolume:(float)volume
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
    [self.audioPlayer setVolume:volume];//15
//    [self.auplayer setDelegate:self];
    // 分配播放所需的资源，并将其加入内部播放队列
    [self.audioPlayer prepareToPlay];
    // 开始播放录音
    [self.audioPlayer play];
}

- (void)playAudioSoundWithSoundTypeStr:(NSString *)typeStr  CourseId:(NSString *)courseId
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
//    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setCategory:AVAudioSessionCategorySoloAmbient mode:AVAudioSessionModeVoicePrompt options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setActive:YES error:nil];
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    NSError *playerError;
    NSURL *url = [self getSoundUrlWithSoundTypeStr:typeStr CourseId:courseId];
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

- (NSURL *)getSoundUrlWithSoundTypeStr:(NSString *)typeStr CourseId:(NSString *)courseId
{
    NSString *resource = nil;
//    NSString *extention = nil;
    if ([StringForId(typeStr) isEqual:@"手臂向上举起"]) {
        resource = @"手抬高，不要偷懒哦！";
    }else if ([StringForId(typeStr) isEqual:@"深蹲"]){
        resource = @"臀向后，再蹲低一点！";
    }else if ([StringForId(typeStr) containsString:@"脚收回"]){
        resource = @"双脚动起来，别停";
    }else if ([StringForId(typeStr) isEqual:@"身体摇"]){
        resource = @"跳起来！跳起来！燃烧脂肪！";
    }else if ([StringForId(typeStr) containsString:@"手拍臀"]){
        resource = @"臀部扭起来！别害羞啊！";
    }else if ([StringForId(typeStr) containsString:@"走三步"]){
        resource = @"双脚动起来，别停！";
    }else if ([StringForId(typeStr) containsString:@"高抬腿"]){
        resource = @"腿抬高！腿抬高！腿抬高！";
    }else if ([StringForId(typeStr) isEqual:@"脚迈出"]){
        resource = @"双腿再开一点，感觉更好！";
    }else if ([StringForId(typeStr) isEqual:@"good_good"]){
        NSSet *soundSet = [NSSet setWithObjects:@"亲爱的，你是不是偸偸练过呀？做得太好了！",
                           @"太棒了！结束后奖励你一套拉伸！",
                           @"哇哦！动作非常完美！",
                           @"优秀！请继续你的表演！",
                           @"有点小性感哦！我都看醉了！",
                           @"状态不错，继续保持！", nil];
        resource = [soundSet anyObject];
    }else if ([StringForId(typeStr) isEqual:@"detected_detected"]){
        NSSet *soundSet = [NSSet setWithObjects:@"宝贝你状态不佳，我等你调整好再开始吧！",
                           @"亲爱的，你怎么了？要不我们先休息一下再继续？", nil];
        resource = [soundSet anyObject];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *mediaUrl = [NSString stringWithFormat:@"%@.mp3",resource];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, courseId, mediaUrl];
    NSLog(@"-------%@",fullPath);
    NSURL *url = [NSURL fileURLWithPath:fullPath];
    
//    extention = @"mp3";
//    NSURL *url = [[NSBundle mainBundle] URLForResource:resource withExtension:extention];
    return url;
}


- (void)playAudioSoundWithSecond:(NSString *)second CourseId:(NSString *)courseId
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *mediaUrl = [NSString stringWithFormat:@"%@.mp3",second];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, courseId, mediaUrl];
    
    NSString *mediaUrPath = [NSString stringWithFormat:@"%@/%@",courseId,mediaUrl];
    if (![self isFileExist:mediaUrPath]) {
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:fullPath];
    
    NSLog(@"音频地址：%@",mediaUrl);
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
//    [audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setCategory:AVAudioSessionCategorySoloAmbient mode:AVAudioSessionModeVoicePrompt options:AVAudioSessionCategoryOptionDuckOthers error:nil];
    [audioSession setActive:YES error:nil];
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    
    NSError *playerError;
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



-(BOOL)isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    NSLog(@"这个文件已经存在：%@",result?@"是的":@"不存在");
    return result;
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
