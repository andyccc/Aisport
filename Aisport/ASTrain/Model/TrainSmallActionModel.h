//
//  TrainSmallActionModel.h
//  Aisport
//
//  Created by Apple on 2020/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrainSmallActionModel : NSObject


//@property (nonatomic, strong) NSString *subAction;
//@property (nonatomic, strong) NSString *voice;
//@property (nonatomic, strong) NSString *actionCode;

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) float time;
@property (nonatomic, assign) long score;
@property (nonatomic, strong) NSString *keyFrameId;
@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *uid;


@end

NS_ASSUME_NONNULL_END
