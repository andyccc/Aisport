//
//  InquiryAlertView.h
//  Aisport
//
//  Created by Apple on 2020/12/9.
//

#import <Foundation/Foundation.h>

typedef void(^ClickBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface InquiryAlertView : NSObject

+ (instancetype)shareAlertView;

- (void)showUpdateAppAlertViewWithSure:(ClickBlock)clickBlock;

- (void)hide;

@end

NS_ASSUME_NONNULL_END
