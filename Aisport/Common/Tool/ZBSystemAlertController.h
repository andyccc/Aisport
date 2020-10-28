//
//  ZBSystemAlertController.h
//  ZhuangDianBi
//
//  Created by ZDB on 2017/4/27.
//  Copyright © 2017年 caoting. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SystemAlertCallBack) (NSInteger buttonIndex);
@interface ZBSystemAlertController : NSObject
@property (copy ,nonatomic) SystemAlertCallBack callBack;
@property (copy ,nonatomic) NSArray *titlesArray;
+ (instancetype)systemAlertController;

- (void)showAlertControllerWithTitle:(NSString *)title Destructive:(BOOL)destructive Buttons:(NSArray *)buttons Cancle:(NSString *)cancle Controller:(UIViewController *)controller CallBack:(SystemAlertCallBack)callBack;
- (void)showAlertStyleAlertControllerWithTitle:(NSString *)title Message:(NSString *)message Buttons:(NSArray *)buttons ViewController:(UIViewController *)viewController CallBack:(SystemAlertCallBack)callBack;
- (void)showAlertStyleAlertControllerWithMessage:(NSString *)message ViewController:(UIViewController *)viewController;

@end
