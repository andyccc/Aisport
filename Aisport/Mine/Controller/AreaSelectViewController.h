//
//  AreaSelectViewController.h
//  Aisport
//
//  Created by andyccc on 2020/12/25.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AreaSelectViewController : BaseViewController

@property (nonatomic, copy) void (^finishBlock) (id data1,id data2, id data3);

@end

NS_ASSUME_NONNULL_END
