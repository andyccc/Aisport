//
//  UILabel+getWidth.m
//  EliteHeadlines
//
//  Created by 田桔 on 2018/5/31.
//  Copyright © 2018年 GJesus. All rights reserved.
//

#import "UILabel+getWidth.h"

@implementation UILabel (getWidth)

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width;
}


@end
