//
//  WechatShareManager.m
//  Aisport
//
//  Created by Apple on 2020/10/29.
//

#import "WechatShareManager.h"
#import "LoginNetWork.h"

@interface WechatShareManager ()

@property (nonatomic, copy) CT_LoginSuccessfulBlock loginSuccessfulBlock;

@end

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
    if (![StringForId(url) isEqual:@""]) {
        return [WXApi handleOpenURL:url delegate:[WechatShareManager shareInstance]];
    }
    return NO;
    
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
    }else if ([resp isKindOfClass:[SendAuthResp class]]){
        [self hanleWechatLoginWithResp:resp];
    }
}

- (void)wechatLoginAppWithSuccessFul:(CT_LoginSuccessfulBlock)successFul
{
    self.loginSuccessfulBlock = successFul;
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"123";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

- (void)shareImageToWechatWithImage:(UIImage *)image AndShareType:(WechatShareType)type
{
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
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

    if (type == WechatShareTypeFriends) {
        req.scene = WXSceneSession;
    }else{
        req.scene = WXSceneTimeline;
    }
    [WXApi sendReq:req completion:^(BOOL success) {
            
    }];


}

- (void)shareUrlToWechatWithUrl:(NSString *)url Code:(NSString *)code Title:(NSString *)title Description:(NSString *)description CoverImage:(UIImage *)coverImage AndShareType:(WechatShareType)type
{

    if (type == WechatShareTypeFriends) {
        WXMiniProgramObject *object = [WXMiniProgramObject object];
        object.webpageUrl = url;
        object.userName = @"gh_6fa15f8b65ce";
        object.path = [NSString stringWithFormat:@"%@?code=%@",@"pages/detail/index",code];
//        object.path = url;
        object.hdImageData = UIImageJPEGRepresentation([self cutImageFromCurrentImage:coverImage Rect:CGRectMake(0, 0, 0, 0)], .3);;
        object.withShareTicket = true;
        object.miniProgramType = WXMiniProgramTypeRelease;
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
        message.thumbData = nil;  //兼容旧版本节点的图片，小于32KB，新版本优先
                                  //使用WXMiniProgramObject的hdImageData属性
        message.mediaObject = object;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;  //目前只支持会话
        [WXApi sendReq:req completion:^(BOOL success) {
            
        }];
    }else{
        [self shareWebUrlToWechatWithUrl:url Title:title Description:description CoverImage:coverImage AndShareType:type];
    }
    



}

- (void)shareWebUrlToWechatWithUrl:(NSString *)url Title:(NSString *)title Description:(NSString *)description CoverImage:(UIImage *)coverImage AndShareType:(WechatShareType)type
{
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = url;
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
//    [message setThumbImage:[UIImage imageNamed:@"缩略图.jpg"]];
    [message setThumbImage:coverImage];
    message.mediaObject = webpageObject;
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;

    if (type == WechatShareTypeFriends) {
        req.scene = WXSceneSession;
    }else{
        req.scene = WXSceneTimeline;
    }
    [WXApi sendReq:req completion:^(BOOL success) {

    }];
}

- (UIImage *)cutImageFromCurrentImage:(UIImage *)image Rect:(CGRect)rect
{
    CGFloat height = image.size.height;
    CGFloat width = image.size.width;
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(width/2-height*5.0/8.0, 0,height*5.0/4.0, height));
    UIImage *returnImage = [UIImage imageWithCGImage:cutImageRef];
    return returnImage;
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

- (void)hanleWechatLoginWithResp:(BaseResp *)resp
{
    SendAuthResp* r = (SendAuthResp*)resp;
    NSMutableDictionary* body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:@"wx2846e9f646cea330" forKey:@"appid"];
    [body setObject:r.code forKey:@"code"];
    [body setObject:@"a81e641196edec3aaeaefcbaaab17a8a" forKey:@"secret"];
    [body setObject:@"authorization_code" forKey:@"grant_type"];
    
    [LoginNetWork getWXTokenWith:body AndSuccessFn:^(id responseAfter, id responseBefore) {
        
        NSMutableDictionary* wxbody = [NSMutableDictionary dictionaryWithCapacity:0];
        [wxbody setObject:[responseBefore objectForKey:@"access_token"] forKey:@"access_token"];
        [wxbody setObject:[responseBefore objectForKey:@"openid"] forKey:@"openid"];
        [wxbody setObject:[responseBefore objectForKey:@"unionid"] forKey:@"unionid"];
        
        NSString* openId = [responseBefore objectForKey:@"openid"];
        NSString* unionId = [responseBefore objectForKey:@"unionid"];
        
        [LoginNetWork getWXUserInfoWith:wxbody AndSuccessFn:^(id responseAfter, id responseBefore) {
            /*
             {
                 city = Shangrao;
                 country = CN;
                 headimgurl = "https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKuBQaDLQKxR4kVEbFQvicywQtoOlrDg7g2eduWHCEice8cB5c8PADWfqX98nibUNzY4yw6kiayTHDVaw/132";
                 language = "zh_CN";
                 nickname = "\U575a\U6301";
                 openid = oUoaz5vid3ECHQIR99ycIcGOxtQo;
                 privilege =     (
                 );
                 province = Jiangxi;
                 sex = 1;
                 unionid = owoZs6JIc7qvJCYCqktg8r585TDI;
             }
             */
            
            NSMutableDictionary* thBody = [NSMutableDictionary dictionaryWithCapacity:0];
//                [thBody setObject:[responseBefore objectForKey:@"nickname"] forKey:@"nickname"];
//                [thBody setObject:[responseBefore objectForKey:@"headimgurl"] forKey:@"headImage"];
            [thBody setObject:openId forKey:@"weixinOpenid"];
            [thBody setObject:unionId forKey:@"unionid"];
            [thBody setObject:[responseBefore objectForKey:@"headimgurl"] forKey:@"headimgurl"];
            [thBody setObject:[responseBefore objectForKey:@"nickname"] forKey:@"nickname"];
            if (self.loginSuccessfulBlock) {
                self.loginSuccessfulBlock(unionId,StringForId(responseBefore[@"nickname"]),StringForId(responseBefore[@"headimgurl"]),StringForId(responseBefore[@"sex"]));
            }
//                [NPNetworkAPIList getHasUserInfoWith:thBody AndSuccessFn:^(id responseAfter, id responseBefore) {
//
//                    if([[responseBefore objectForKey:@"msg"] intValue] == 1)
//                    {
//                        [GVUserDefaults standardUserDefaults].userId = [responseAfter objectForKey:@"id"];
//                        [GVUserDefaults standardUserDefaults].statusType = StringForId(responseAfter[@"statusType"]);
//                        [self updataUserInfo];
////                        if ([StringForId(responseAfter[@"academyId"]) isEqualToString:@""]) {
////
////                        }
//                        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//
//                        if([[responseAfter objectForKey:@"statusType"] isKindOfClass:[NSNull class]] || [[responseAfter objectForKey:@"statusType"] isEqualToString:@""] || [responseAfter objectForKey:@"statusType"] == nil || [[responseAfter objectForKey:@"statusType"] isEqualToString:@"1"])
//                        {
//                            ChoseStatus* vc = [[ChoseStatus alloc]init];
//                            MSNavigationController *nav = appDelegate.baseTabbar.childViewControllers[0];
//                            vc.type = 1;
//                            [nav pushViewController:vc animated:YES];
////                            [appDelegate.baseTabbar presentViewController:vc animated:YES completion:nil];
//                        }
//                    }else
//                    {
//                        RegisterVC* vc = [[RegisterVC alloc]init];
//                        vc.wxInfo = thBody;
//                        [self.navigationController pushViewController:vc animated:YES];
//                    }
//
//                } andFailerFn:^(NSError *error) {
//
//                }];
            
        } andFailerFn:^(NSError *error) {
            
        }];
    } andFailerFn:^(NSError *error) {
        
    }];
}

@end
