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
@property (nonatomic, strong) NSString *status;  //0无账号无用户信息,1有账号无用户信息,2有账号并且有用户信息 10 已注册未绑定  11 未注册未绑定

@property (nonatomic, strong) NSString *unionId;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *headimgurl;
@property (nonatomic, strong) NSString *sex;

@end

NS_ASSUME_NONNULL_END
