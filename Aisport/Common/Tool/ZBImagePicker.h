//
//  ZBImagePicker.h
//  ZhuangDianBi
//
//  Created by ZDB on 2017/4/26.
//  Copyright © 2017年 caoting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^ImagePickerResult) (BOOL result, UIImage *image);

@interface ZBImagePicker : NSObject
+ (instancetype)imagePicker;

@property (copy, nonatomic) ImagePickerResult resultBlock;

- (void)showImagePickerDataSourceOptionsTitle:(NSString *)title InController:(UIViewController *)viewController ImageCanEdit:(BOOL)imageCanEdit Result:(ImagePickerResult)resultBlock;

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType InController:(UIViewController *)viewController ImageCanEdit:(BOOL)imageCanEdit Result:(ImagePickerResult)resultBlock;

@end
