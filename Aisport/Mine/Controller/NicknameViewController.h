//
//  NicknameViewController.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NicknameViewController : BaseViewController

@property (nonatomic, copy) void (^finishBlock) (NSString *text);
@property (nonatomic, strong) NSString *text;


@end

NS_ASSUME_NONNULL_END
