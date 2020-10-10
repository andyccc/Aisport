//
//  EditAddressViewController.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditAddressViewController : BaseViewController

@property (nonatomic, copy)void (^editFinishBlock) (void);
@property (nonatomic, strong) id data;


@end

NS_ASSUME_NONNULL_END
