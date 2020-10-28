//
//  AddPicView.h
//  Turenstore
//
//  Created by 田桔 on 2019/4/16.
//  Copyright © 2019 田桔. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CT_AddPicBlock)(NSArray *picUrlArr);
@interface AddPicView : NSObject


+ (instancetype)shareAddPicView;

@property (nonatomic, assign) CGRect cropRect;  ///< 裁剪框的尺寸

- (void)addPicViewWithPicCount:(int)picCount ViewController:(UIViewController *)vc IsCrop:(BOOL)isCrop AddPicBlock:(CT_AddPicBlock)addPicBlock;


@end

NS_ASSUME_NONNULL_END
