//
//  WechatShareManager.m
//  Aisport
//
//  Created by Apple on 2020/10/29.
//

#import "WechatShareManager.h"

@implementation WechatShareManager

+ (id)shareInstance {
    static WechatShareManager *weChatShareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weChatShareInstance = [[WechatShareManager alloc] init];
    });
    return weChatShareInstance;
}

+ (BOOL)handleOpenUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WechatShareManager shareInstance]];
}

#pragma mark - 微信分享回调

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        /*
         enum  WXErrCode {
         WXSuccess           = 0,    < 成功
         WXErrCodeCommon     = -1,  < 普通错误类型
         WXErrCodeUserCancel = -2,   < 用户点击取消并返回
         WXErrCodeSentFail   = -3,   < 发送失败
         WXErrCodeAuthDeny   = -4,   < 授权失败
         WXErrCodeUnsupport  = -5,   < 微信不支持
         };
         */
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        switch (response.errCode) {
            case WXSuccess: {
                NSLog(@"微信分享成功");
//                [[NSNotificationCenter defaultCenter] postNotificationName:UserNotificationWechatShareSuccess object:nil userInfo:nil];
                break;
            }
            case WXErrCodeCommon: {
                NSLog(@"微信分享异常");
                break;
            }
            case WXErrCodeUserCancel: {
                NSLog(@"微信分享取消");
                break;
            }
            case WXErrCodeSentFail: {
                NSLog(@"微信分享失败");
//                [[NSNotificationCenter defaultCenter] postNotificationName:UserNotificationWechatShareFail object:nil userInfo:nil];
                break;
            }
            case WXErrCodeAuthDeny: {
                NSLog(@"微信分享授权失败");
                break;
            }
            case WXErrCodeUnsupport: {
                NSLog(@"微信分享版本暂不支持");
                break;
            }
            default: {
                break;
            }
        }
    }
}

- (void)shareImageToWechatWithImage:(UIImage *)image AndShareType:(WechatShareType)type
{
    
//    WXMediaMessage *message = [WXMediaMessage message];
//    // 设置消息缩略图的方法
//    [message setThumbImage:[UIImage imageNamed:@"appLogo"]];
//    // 多媒体消息中包含的图片数据对象
//    WXImageObject *imageObject = [WXImageObject object];
//
////    UIImage *image = [UIImage imageNamed:@"要分享的图片名"];
//
//    // 图片真实数据内容
//    NSData *data = [self imageWithImage:image scaledToSize:CGSizeMake(300, 300)];
//
//
//
////    [self calulateImageFileSize:newImage];
////
////    NSData *data = UIImagePNGRepresentation(newImage);
//    imageObject.imageData = data;
//    // 多媒体数据对象，可以为WXImageObject，WXMusicObject，WXVideoObject，WXWebpageObject等。
//    message.mediaObject = imageObject;
//
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = NO;
//    req.message = message;
////    req.scene = type == 0 ? WechatShareTypeFriends : WXSceneTimeline;
//    req.scene = WXSceneSession;
//
//    [WXApi sendReq:req completion:^(BOOL success) {
//        NSLog(@"%@",success);
//    }];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;

    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;

    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req completion:^(BOOL success) {
            
    }];


}


// ------这种方法对图片既进行压缩，又进行裁剪
- (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

- (void)calulateImageFileSize:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1.0);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}


@end
