//
//  SexViewController.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SexViewController : BaseViewController

@property (nonatomic, copy) void (^finishBlock) (NSInteger sex);
@property (nonatomic, assign) NSInteger sex;


@end

NS_ASSUME_NONNULL_END
