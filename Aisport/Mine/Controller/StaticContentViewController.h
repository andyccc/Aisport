//
//  StaticContentViewController.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    StaticContentTypeIntro,// 企业介绍
    StaticContentTypeUser,// 用户协议
    StaticContentTypePrivate,// 隐私政策
} StaticContentType;

NS_ASSUME_NONNULL_BEGIN

@interface StaticContentViewController : BaseViewController

@property (nonatomic, assign) StaticContentType contentType;

@end

NS_ASSUME_NONNULL_END
