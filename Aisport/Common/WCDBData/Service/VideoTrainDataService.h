//
//  VideoTrainDataService.h
//  Aisport
//
//  Created by Apple on 2020/11/30.
//

#import <Foundation/Foundation.h>
@class VideoTrainData;
@class ActionTrainData;

NS_ASSUME_NONNULL_BEGIN

@interface VideoTrainDataService : NSObject

+ (void)setDBName:(NSString *)name;
+ (void)insertObjectWithVideoData:(VideoTrainData *)videoData;
+ (void)insertObjectWithTrainData:(ActionTrainData *)trainData;
+ (NSArray *)queryWithVideoCode:(NSString *)videoCode;

+ (void)deleteWithVideoCode:(NSString *)videoCode;
+ (void)updateUploadStateWithVideoCode:(NSString *)videoCode;

@end

NS_ASSUME_NONNULL_END
