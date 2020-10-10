//
//  MyAddressViewController.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyAddressViewController : BaseViewController

@property (nonatomic, copy) void (^selectBlock) (id data);

@end

NS_ASSUME_NONNULL_END
