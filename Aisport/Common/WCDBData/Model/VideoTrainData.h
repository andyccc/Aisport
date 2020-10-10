//
//  VideoTrainData.h
//  Aisport
//
//  Created by Apple on 2020/11/30.
//

#import "WCDBTableBase.h"
@class ActionTrainData;

NS_ASSUME_NONNULL_BEGIN

@interface VideoTrainData : WCDBTableBase

//这个是主键id
@property int wcdbid;

@property NSString *videoCode;
@property NSString *name;
@property NSArray<ActionTrainData *> *actionScoreLogs;
@property long long startTime;
@property long long endTime;
@property long long isUpload;

@end

NS_ASSUME_NONNULL_END
