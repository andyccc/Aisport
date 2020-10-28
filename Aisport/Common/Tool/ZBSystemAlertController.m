//
//  ZBSystemAlertController.m
//  ZhuangDianBi
//
//  Created by ZDB on 2017/4/27.
//  Copyright © 2017年 caoting. All rights reserved.
//

#import "ZBSystemAlertController.h"
@interface ZBSystemAlertController()<UIActionSheetDelegate,UIAlertViewDelegate>
@end

@implementation ZBSystemAlertController

+ (instancetype)systemAlertController
{
    return [[self alloc] init];
}
- (void)showAlertControllerWithTitle:(NSString *)title Destructive:(BOOL)destructive Buttons:(NSArray *)buttons Cancle:(NSString *)cancle Controller:(UIViewController *)controller CallBack:(SystemAlertCallBack)callBack
{
    _callBack = callBack;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    NSMutableArray *array = [NSMutableArray arrayWithArray:buttons];
    if (destructive) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:array[0] style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            callBack(0);
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:action];
        [array removeObjectAtIndex:0];
        for (int i = 0; i<array.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                callBack(i+1);
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
        }
    }else{
        for (int i = 0; i<array.count; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                callBack(i);
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:action];
        }
    }
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancleAction];
    [controller presentViewController:alertController animated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        self.callBack(0);
    }else if (buttonIndex == 1){
        
    }else{
        self.callBack(buttonIndex - 1);
    }
}

- (void)showAlertStyleAlertControllerWithMessage:(NSString *)message ViewController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)showAlertStyleAlertControllerWithTitle:(NSString *)title Message:(NSString *)message Buttons:(NSArray *)buttons ViewController:(UIViewController *)viewController CallBack:(SystemAlertCallBack)callBack
{
    _callBack = callBack;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    NSMutableArray *array = [NSMutableArray arrayWithArray:buttons];
    for (int i = 0; i<array.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:array[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            callBack(i);
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:action];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.callBack(buttonIndex);
}


@end
