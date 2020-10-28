//
//  UIButton+Background.m
//  NeoOA
//
//  Created by Jesus on 2017/4/27.
//  Copyright © 2017年 Jesus. All rights reserved.
//

#import "UIButton+Background.h"

@implementation UIButton (Background)
-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    [self setBackgroundImage:[self createImageWithColor:color] forState:state];
}

- (UIImage*)createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
