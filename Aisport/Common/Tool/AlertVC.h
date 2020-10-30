//
//  AlertVC.h
//  NeoPay
//
//  Created by adminn on 2017/7/7.
//  Copyright © 2017年 Jesus. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^cancelBlock)(UIAlertAction* action);
typedef void (^otherBlock)(UIAlertAction* action);

@interface AlertVC : UIAlertController
-(instancetype)initWithType:(int)type andTitle:(NSString*)title andMessage:(NSString*)msg and:(NSArray*)otherBtn and:(otherBlock)otherBlock;

-(instancetype)initWithType:(int)type andTitle:(NSString*)title andMessage:(NSString*)msg and:(NSString*)cancelTitle and:(NSArray*)otherBtn and:(otherBlock)otherBlock;
@end
