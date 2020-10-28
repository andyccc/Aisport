//
//  AlertViewController.h
//  RTTXClient
//
//  Created by ZZZdeMac on 2017/8/2.
//  Copyright © 2017年 ZZZ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define cancelIndex    (-1)

typedef void(^AlertViewBlock)(NSInteger buttonTag);

@interface AlertViewController : UIView


+ (void)showAlert:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm;

+ (void)showSheet:(NSString *)title
          message:(NSString *)message
      cancelTitle:(NSString *)cancelTitle
       titleArray:(NSArray *)titleArray
   viewController:(UIViewController *)vc
          confirm:(AlertViewBlock)confirm;
@end
