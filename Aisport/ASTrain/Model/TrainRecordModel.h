//
//  TrainRecordModel.h
//  Aisport
//
//  Created by Apple on 2020/10/30.
//

#import <Foundation/Foundation.h>
#import "TrainSmallActionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainRecordModel : NSObject

//@property (nonatomic, strong) NSMutableArray *actionScoreLogs;
//@property (nonatomic, strong) NSString *courseCode;
//@property (nonatomic, strong) NSString *videoCode;
//@property (nonatomic, strong) NSString *startTime;
//@property (nonatomic, strong) NSString *endTime;
//@property (nonatomic, assign) long effortNumber;
//@property (nonatomic, assign) long perfectNumber;



@property (nonatomic, assign) long score;
@property (nonatomic, assign) long hidoTotal;
@property (nonatomic, assign) long perfectNumber;
@property (nonatomic, assign) long superTotal;
@property (nonatomic, assign) long goodTotal;
@property (nonatomic, assign) long okTotal;
@property (nonatomic, assign) long missTotal;
@property (nonatomic, assign) long batter;
@property (nonatomic, assign) long batterMax;
@property (nonatomic, assign) long batterMin;
@property (nonatomic, assign) long breakTotal;
@property (nonatomic, assign) long breakTime; //秒
@property (nonatomic, strong) NSString *exitWay;
@property (nonatomic, assign) long starNum;

@property (nonatomic, assign) long long startTime;
@property (nonatomic, assign) long long endTime;
@property (nonatomic, strong) NSString *videoCode;
@property (nonatomic, strong) NSString *completed;
@property (nonatomic, assign) long frameTotal;

@property (nonatomic, strong) NSMutableArray *actionScoreLogs;

- (NSDictionary *)getModelDictionary;






@end

NS_ASSUME_NONNULL_END
