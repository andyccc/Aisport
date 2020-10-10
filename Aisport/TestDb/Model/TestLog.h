//
//  TestLog.h
//  Aisport
//
//  Created by andyccc on 2020/10/29.
//

#import "WCDBTableBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestLog : WCDBTableBase

//这个是主键id
@property int wcdbid;

@property double createDate;

@property NSString *content;

@end

NS_ASSUME_NONNULL_END
