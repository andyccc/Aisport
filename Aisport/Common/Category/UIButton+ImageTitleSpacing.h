//
//  UIButton+ImageTitleSpacing.h
//  MWTest
//
//  Created by 张兆渊 on 2017/1/14.
//  Copyright © 2017年 siyan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MWButtonEdgeInsetsStyle) {
    MWButtonEdgeInsetsStyleTop, // image在上，label在下
    MWButtonEdgeInsetsStyleLeft, // image在左，label在右
    MWButtonEdgeInsetsStyleBottom, // image在下，label在上
    MWButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (ImageTitleSpacing)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MWButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end
