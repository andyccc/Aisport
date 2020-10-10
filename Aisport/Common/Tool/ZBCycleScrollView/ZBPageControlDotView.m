//
//  ZBPageControlDotView.m
//  无线循环
//
//  Created by ZDB on 2017/4/8.
//  Copyright © 2017年 zhuangbi. All rights reserved.
//

#import "ZBPageControlDotView.h"

@implementation ZBPageControlDotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = _dotColor;
    self.layer.cornerRadius = self.dotWidth/2;
    self.layer.masksToBounds = YES;
}

+ (instancetype)DotViewWithFrmame:(CGRect)frame
{
    ZBPageControlDotView *dot = [[self alloc] initWithFrame:frame];
    dot.dotWidth = CGRectGetHeight(frame);
    return dot;
}

- (void)setDotWidth:(CGFloat)dotWidth
{
    _dotWidth = dotWidth;
    [self setNeedsLayout];
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    [self setNeedsLayout];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
