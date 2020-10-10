//
//  TestData.h
//  Aisport
//
//  Created by andyccc on 2020/10/29.
//

#import "WCDBTableBase.h"
@class TestLog;

NS_ASSUME_NONNULL_BEGIN

@interface TestData : WCDBTableBase

//这个是主键id
@property int wcdbid;

@property int userId;
@property NSString *userName;
@property NSArray<TestLog *> *logs;
@property NSString *mark;


@end

NS_ASSUME_NONNULL_END
