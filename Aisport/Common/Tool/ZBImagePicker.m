//
//  ZBImagePicker.m
//  ZhuangDianBi
//
//  Created by ZDB on 2017/4/26.
//  Copyright © 2017年 caoting. All rights reserved.
//

#import "ZBImagePicker.h"
//#import "ImageCutTool.h"
#import "ZBSystemAlertController.h"
@interface ZBImagePicker()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *_imagePicker;
    
}
@property (strong ,nonatomic) ZBSystemAlertController *alterController;
@property (weak ,nonatomic) UIViewController *controller;
@end
@implementation ZBImagePicker

- (ZBSystemAlertController *)alterController
{
    if (!_alterController) {
        _alterController = [ZBSystemAlertController systemAlertController];
    }
    return _alterController;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imagePicker = [[UIImagePickerController alloc] init];
        
        _imagePicker.delegate = self;
//        _imagePicker.navigationBar.barTintColor = NewSystemColor;
        _imagePicker.navigationBar.tintColor = [UIColor blackColor];
    }
    return self;
}
+ (instancetype)imagePicker
{
    return [[ZBImagePicker alloc] init];
}

- (void)showImagePickerDataSourceOptionsTitle:(NSString *)title InController:(UIViewController *)viewController ImageCanEdit:(BOOL)imageCanEdit Result:(ImagePickerResult)resultBlock
{
    
    _resultBlock = resultBlock;
    _controller = viewController;
    _imagePicker.allowsEditing = imageCanEdit;
    NSArray *pickerSourceArray = [self sourceArray];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
        [actionSheet showInView:_controller.view];
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
        [actionSheet showInView:_controller.view];
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ){
        switch (buttonIndex) {
            case 0:
            {//相册
                
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    [self.alterController showAlertStyleAlertControllerWithTitle:@"无法访问相册" Message:@"请在手机设置中允许访问照片" Buttons:@[@"确定",@"去设置"] ViewController:self.controller CallBack:^(NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                    return;
                }
                _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [_controller presentViewController:_imagePicker animated:YES completion:nil];
            }
                break;
            case 1:
            {//拍照
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    [self.alterController showAlertStyleAlertControllerWithTitle:@"无法访问相机" Message:@"请在手机设置中允许访问相机" Buttons:@[@"确定",@"去设置"] ViewController:self.controller CallBack:^(NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                    return;
                }
                _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [_controller presentViewController:_imagePicker animated:YES completion:nil];
            }
                break;
            case 2:
            {
                self.resultBlock(NO, nil);
            }
                break;
            default:
                break;
        }
    }else{
        switch (buttonIndex) {
            case 0:
            {//相册
                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                    [self.alterController showAlertStyleAlertControllerWithTitle:@"无法访问相册" Message:@"请在手机设置中允许访问照片" Buttons:@[@"确定",@"去设置"] ViewController:self.controller CallBack:^(NSInteger buttonIndex) {
                        if (buttonIndex == 1) {
                            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                            [[UIApplication sharedApplication] openURL:url];
                        }
                    }];
                    return;
                }
                _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [_controller presentViewController:_imagePicker animated:YES completion:nil];
            }
                break;
            case 1:
            {
                self.resultBlock(NO, nil);
            }
                break;
            default:
                break;
        }
    }
}

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType InController:(UIViewController *)viewController ImageCanEdit:(BOOL)imageCanEdit Result:(ImagePickerResult)resultBlock
{
    _resultBlock = resultBlock;
    _controller = viewController;
    _imagePicker.sourceType = sourceType;
    [_controller presentViewController:_imagePicker animated:YES completion:nil];
}

#pragma mark - 获取照片 UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
//    UIImage *image = [[ImageCutTool shareImageCutTool] fixOrientation:[info valueForKey:UIImagePickerControllerOriginalImage]];
    self.resultBlock(YES, [info valueForKey:UIImagePickerControllerOriginalImage]);
}

#pragma mark 取消选取图片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.resultBlock(NO, nil);
}


- (NSArray *)sourceArray
{
    NSArray *sourceArray = nil;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ) {
        sourceArray = @[@"相册",@"拍照"];
    }else {
        sourceArray = @[@"相册"];
    }
    return sourceArray;
}

@end
