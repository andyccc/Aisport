//
//  WechatShareManager.h
//  Aisport
//
//  Created by Apple on 2020/10/29.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>

NS_ASSUME_NONNULL_BEGIN

// 分享类型枚举
typedef NS_ENUM(NSInteger, WechatShareType) {
    WechatShareTypeFriends,  // 好友
    WechatShareTypeTimeline,  // 朋友圈
};

// 分享后返回码枚举
typedef NS_ENUM(int, WechatShareStatusCode){
    WechatShareSuccess     = 0, // 分享成功
    WechatShareCancleShare = 1,// 取消分享
    WechatShareFailed      = 2   // 分享失败
};

@interface WechatShareManager : NSObject

+ (id)shareInstance;

+ (BOOL)handleOpenUrl:(NSURL *)url;

- (void)shareImageToWechatWithImage:(UIImage *)image AndShareType:(WechatShareType)type;

@end

NS_ASSUME_NONNULL_END
