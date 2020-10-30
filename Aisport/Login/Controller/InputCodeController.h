//
//  InputCodeController.h
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputCodeController : UIViewController

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *status;  //0无账号无用户信息,1有账号无用户信息,2有账号并且有用户信息

@end

NS_ASSUME_NONNULL_END
