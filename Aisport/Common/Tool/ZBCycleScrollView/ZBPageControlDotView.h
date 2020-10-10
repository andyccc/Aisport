//
//  ZBPageControlDotView.h
//  无线循环
//
//  Created by ZDB on 2017/4/8.
//  Copyright © 2017年 zhuangbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBPageControlDotView : UIView

+ (instancetype)DotViewWithFrmame:(CGRect)frame;

@property (nonatomic) UIColor *dotColor;
@property (assign ,nonatomic) CGFloat dotWidth;
@end
