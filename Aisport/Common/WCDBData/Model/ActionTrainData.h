//
//  ActionTrainData.h
//  Aisport
//
//  Created by Apple on 2020/11/30.
//

#import "WCDBTableBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActionTrainData : WCDBTableBase

//这个是主键id
@property int wcdbid;

@property long uid;
@property float time;
@property NSString *createTime;
@property long modelScore;
@property NSString *keyFrameId;
@property NSString *videoCode;
@property NSString *json;


@end

NS_ASSUME_NONNULL_END
