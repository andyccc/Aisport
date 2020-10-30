//
//  AddPicView.m
//  Turenstore
//
//  Created by 田桔 on 2019/4/16.
//  Copyright © 2019 田桔. All rights reserved.
//

#import "AddPicView.h"

#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"
#import "AlertViewController.h"
#import "TZImagePickerController.h"

#import "CommonNetworkManager.h"

@interface AddPicView ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (strong, nonatomic) CLLocation *location;

@property (nonatomic, strong) UIViewController *currentVC;
@property (nonatomic, copy) CT_AddPicBlock addPicBlock;
@property (nonatomic,strong) NSMutableArray *picUrlArr;
@property (nonatomic, assign) BOOL isCrop;

@property (nonatomic, assign) int picCount;


@end

@implementation AddPicView

- (NSMutableArray *)picUrlArr
{
    if (!_picUrlArr) {
        _picUrlArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _picUrlArr;
}

+ (instancetype)shareAddPicView
{
    static AddPicView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[AddPicView alloc] init];
        view.cropRect = CGRectMake(0, SCR_HIGHT/2-SCR_WIDTH/2, SCR_WIDTH, SCR_WIDTH);
    });
    
    
    return view;
}

- (void)addPicViewWithPicCount:(int)picCount ViewController:(UIViewController *)vc IsCrop:(BOOL)isCrop AddPicBlock:(CT_AddPicBlock)addPicBlock
{
    [self.picUrlArr removeAllObjects];
    _addPicBlock = addPicBlock;
    _currentVC = vc;
    _picCount = picCount;
    _isCrop = isCrop;

    
    [self clickUpdatePic];
}

#pragma mark - 相册，相机
- (void)clickUpdatePic
{
    [AlertViewController showSheet:nil message:nil cancelTitle:nil titleArray:@[@"拍照",@"去相册选择"] viewController:_currentVC confirm:^(NSInteger buttonTag) {
        if (buttonTag == 0) {
            [self takePhoto];//拍照
        } else if (buttonTag == 1) {
            [self pushTZImagePickerController];//相册
        }
    }];
}


- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
            [self showPhotoTips];
        } else {
            [self showPhotoTips];
        }
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        if (iOS8Later) {
            [self showPhotoTips];
        } else {
            [self showPhotoTips];
        }
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}
/**
 TZimage调用相机
 */
- (void)pushImagePickerController {
    
    __weak typeof(self) weakSelf = self;
    
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(CLLocation *location, CLLocation *oldLocation) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = location;
    } failureBlock:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.location = nil;
    }];
    
    //    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
    //        __strong typeof(weakSelf) strongSelf = weakSelf;
    //        strongSelf.location = [locations firstObject];
    //    } failureBlock:^(NSError *error) {
    //        __strong typeof(weakSelf) strongSelf = weakSelf;
    //        strongSelf.location = nil;
    //    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        
        if (_isCrop) {
//            tzImagePickerVc.allowCrop = YES;
//            tzImagePickerVc.cropRect = _cropRect;
            self.imagePickerVc.allowsEditing = YES;
        }else{
            //        imagePickerVc.allowCrop = NO;
        }
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [_currentVC presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}



/**
 TZimage调用相册
 */
- (void)pushTZImagePickerController {
    
    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:_picCount delegate:self];
    
    //    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    //    imagePickerVc.iconThemeColor = [UIColor colorWithRed:31 / 255.0 green:185 / 255.0 blue:34 / 255.0 alpha:1.0];
    //    imagePickerVc.showPhotoCannotSelectLayer = YES;
    //    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    //    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
    //        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    }];
    // 设置是否可以选择视频/图片/原图
    if (_isCrop) {
        imagePickerVc.allowCrop = YES;
        imagePickerVc.cropRect = _cropRect;
    }else{
//        imagePickerVc.allowCrop = NO;
    }
    
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    //    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSMutableArray* allPics = [NSMutableArray array];

//        if (_isCrop) {
//            for (UIImage *image in photos) {
//                NSData *imageData = [UIImage lubanCompressImage:image];
////                NSData *imageData = [UIImage lubanCompressImage:[self cropSquareImage:image]];
////                [allPics addObject:[UIImage imageWithData:imageData]];
//                [allPics addObject:imageData];
////                [allPics addObject:[self cropSquareImage:image]];
//            }
//
//        }else{
//            for (UIImage *image in photos) {
//                NSData *imageData = [UIImage lubanCompressImage:image];
////                [allPics addObject:[UIImage imageWithData:imageData]];
//                [allPics addObject:imageData];
//            }
////            NSData *imageData = [UIImage zipNSDataWithImage:image];
////            [allPics addObject:[UIImage imageWithData:imageData]];
////            [allPics addObjectsFromArray:photos];
//        }
        
        //        _updateImageView.image = photos[0];
        [allPics addObjectsFromArray:photos];
        [SVProgressHUD show];
        [self upLoadImg:allPics and:0];
        
    }];
    [_currentVC presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 使用TZimamge在这里拿到相机数据
 */
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
//        if (_isCrop) {
//            tzImagePickerVc.allowCrop = NO;
//            tzImagePickerVc.cropRect = _cropRect;
//        }else{
//            //        imagePickerVc.allowCrop = NO;
//        }
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        if (_isCrop) {
//            UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//        }else{
//            //        imagePickerVc.allowCrop = NO;
//        }
//        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                
                
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
//                        TZAssetModel *assetModel = [models firstObject];
//                        if (tzImagePickerVc.sortAscendingByModificationDate) {
//                            assetModel = [models lastObject];
//                        }
                        NSMutableArray* allPics = [NSMutableArray array];
//                        if (_isCrop) {
////                            NSData *imageData = [UIImage zipNSDataWithImage:image];
//                            NSData *imageData = [UIImage lubanCompressImage:image];
////                            [allPics addObject:[UIImage imageWithData:imageData]];
//                            [allPics addObject:imageData];
//
//                        }else{
////                            NSData *imageData = [UIImage zipNSDataWithImage:image];
//                            NSData *imageData = [UIImage lubanCompressImage:image];
//                            [allPics addObject:imageData];//[UIImage imageWithData:imageData];
//                        }
                        
                        //                        _updateImageView.image = image;
                        [allPics addObject:image];
                        [self upLoadImg:allPics and:0];
                        
                        
                    }];
                }];
                
                
            }
        }];
    }
}


//- (UIImage *)scaleImage:(UIImage *)anImage withEditingInfo:(NSDictionary*)editInfo{
//
//    UIImage*newImage;
//
//    UIImage *originalImage = [editInfo valueForKey:@"UIImagePickerControllerOriginalImage"];
//    CGSize originalSize = CGSizeMake(originalImage.size.width,originalImage.size.height);
//    CGRect originalFrame;
//    originalFrame.origin= CGPointMake(0,0);
//    originalFrame.size= originalSize;
//
//    CGRect croppingRect = [[editInfo valueForKey:@"UIImagePickerControllerCropRect"] CGRectValue];
//    CGSize croppingRectSize = CGSizeMake(croppingRect.size.width,croppingRect.size.height);
//
//    CGSize croppedScaledImageSize = anImage.size;
//
//    float scaledBarClipHeight = 80;
//
//    CGSize scaledImageSize;
//    float scale;
//
//    if(!CGSizeEqualToSize(croppedScaledImageSize,originalSize)){
//
//        scale= croppedScaledImageSize.width/croppingRectSize.width;
//        float barClipHeight = scaledBarClipHeight/scale;
//
//        croppingRect.origin.y-= barClipHeight;
//        croppingRect.size.height+= (2*barClipHeight);
//
//        if(croppingRect.origin.y<=0){
//            croppingRect.size.height+= croppingRect.origin.y;
//            croppingRect.origin.y=0;
//        }
//
//        if(croppingRect.size.height> (originalSize.height -croppingRect.origin.y)){
//            croppingRect.size.height= (originalSize.height - croppingRect.origin.y);
//        }
//
//
//        scaledImageSize= croppingRect.size;
//        scaledImageSize.width*= scale;
//        scaledImageSize.height*= scale;
//
//        newImage=  [self cropImage:originalImage to:croppingRect andScaleTo:scaledImageSize];
//
//    }else{
//
//        newImage= originalImage;
//
//    }
//
//    return newImage;
//}



-(void)upLoadImg:(NSMutableArray*)dArr and:(long)index
{
    
    __block long idx = index;
    
    if(idx < dArr.count)
    {
        NSMutableDictionary* body = [NSMutableDictionary dictionaryWithCapacity:0];
        [body setObject:@"123" forKey:@"file"];
        NSData *data = UIImageJPEGRepresentation(dArr[idx], .3);
        [[CommonNetworkManager share] AFUPIMAGENetworkWithUrl:@"ai/upload/uploadImage" andBody:body andData:data andSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            /*
             code = 0;
             data = "https://pub.hidbb.com/ai-dev/ai/f0147104ccdf4e17bce01eb5875a36bb.jpeg";
             msg = "<null>";
             */
            [self.picUrlArr addObject:StringForId(responseAfter[@"url"])];
            idx = idx+1;
            [self upLoadImg:dArr and:idx];
                    
                } andFailer:^(NSError * _Nonnull error) {
                    
                }];
        
//        NSString * key = [NSString stringWithFormat:@"%@%lld.jpg",[GVUserDefaults standardUserDefaults].storeId,[DatetimeOpeartion getCurrentSeconds]];
//        NSString * filePath = [self getImageDataPath:dArr[idx]];
//
//        [_upManager putFile:filePath key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//            if(info.ok)
//            {
//                NSLog(@"请求成功");
//                [self.picUrlArr addObject:[NSString stringWithFormat:@"https://rs.woniutop.com/%@",key]];
//                idx = idx+1;
//                [self upLoadImg:dArr and:idx Token:token];
//            }
//
//            else{
//                NSLog(@"失败");
//                //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
//            }
//            NSLog(@"info ===== %@", info);
//            NSLog(@"resp ===== %@", resp);
//        } option:nil];
        //        __weak AddPicView *weakSelf = self;
        //        NSMutableDictionary* body = [NSMutableDictionary dictionaryWithCapacity:0];
        //        [body setObject:@"123" forKey:@"file"];
        //        //        [body setObject:[GVUserDefaults standardUserDefaults].userId forKey:@"userId"];
        //        [NPNetworkAPIList uoImageFileWith:body andName:@"223" andData:UIImageJPEGRepresentation(dArr[idx], .3) AndSuccessFn:^(id responseAfter, id responseBefore) {
        //            if (ResponseSuccess) {
        //
        //                [weakSelf.picUrlArr addObject:responseAfter];
        //                idx = idx+1;
        //                [self upLoadImg:dArr and:idx];
        //            }else{
        //                if ([StringForId(responseAfter) isEqualToString:@""]) {
        //                    [SVProgressHUD showInfoWithStatus:@"发生未知错误"];
        //                }else{
        //                    [SVProgressHUD showInfoWithStatus:responseAfter];
        //                }
        //            }
        //
        //        } andFailerFn:^(NSError *error) {
        //            idx = idx+1;
        //            [self upLoadImg:dArr and:idx];
        //        }];
    }else
    {
        DebugLog(@"all over");
        [SVProgressHUD dismiss];
        if (self.addPicBlock) {
            self.addPicBlock(self.picUrlArr);
        }
        //        _productBfiefModel.advertiseImg = _picUrlArr[0];
        
    }
    
    
}


- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = _currentVC.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = _currentVC.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}


-(void)showPhotoTips{
    
    [AlertViewController  showAlert:@"无法使用相机"
                            message:@"请在iPhone的""设置-隐私-相机""中允许访问相机"
                        cancelTitle:nil
                         titleArray:@[@"好的"]
                     viewController:nil
                            confirm:^(NSInteger buttonTag) {
                                
                            }];
}


// 以图片中心为中心，以最小边为边长，裁剪正方形图片
-(UIImage *)cropSquareImage:(UIImage *)image{
    
    CGImageRef sourceImageRef = [image CGImage];//将UIImage转换成CGImageRef
    
    CGFloat _imageWidth = image.size.width * image.scale;
    CGFloat _imageHeight = image.size.height * image.scale;
    CGFloat _width = _imageWidth > _imageHeight ? _imageHeight : _imageWidth;
    CGFloat _offsetX = (_imageWidth - _width) / 2;
    CGFloat _offsetY = (_imageHeight - _width) / 2;
    
    CGRect rect = CGRectMake(_offsetX, _offsetY, _width, _width);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);//按照给定的矩形区域进行剪裁
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
}



//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.jpg"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}
//照片获取本地路径转换
- (NSString *)getImageDataPath:(NSData *)data {
    NSString *filePath = nil;
//    NSData *data = nil;
//    if (UIImagePNGRepresentation(Image) == nil) {
//        data = UIImageJPEGRepresentation(Image, 1.0);
//    } else {
//        data = UIImagePNGRepresentation(Image);
//    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.jpg"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

@end
