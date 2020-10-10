//
//  SoundPlayCenter.h
//  Aisport
//
//  Created by Apple on 2020/10/22.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SoundPlayCenter : NSObject

+ (instancetype)defaultCenter;

- (void)playAudioSoundWithResource:(NSString *)resource Extention:(NSString *)extention  WithVolume:(float)volume;

- (void)playAudioSoundWithSoundTypeStr:(NSString *)typeStr  CourseId:(NSString *)courseId;

- (void)playAudioSoundWithSecond:(NSString *)second CourseId:(NSString *)courseId;

- (void)playAudioSoundWithResource:(NSString *)resource Extention:(NSString *)extention;

@end

NS_ASSUME_NONNULL_END
