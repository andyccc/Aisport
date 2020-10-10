//
//  ZBPageControl.m
//  无线循环
//
//  Created by ZDB on 2017/4/7.
//  Copyright © 2017年 zhuangbi. All rights reserved.
//

#import "ZBPageControl.h"
#import "ZBPageControlDotView.h"
@implementation ZBPageControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)pageControlWithCenter:(CGPoint)point Count:(NSInteger)count DotDiameter:(CGFloat)diameter
{
    CGFloat controlW = (2*count+1)*diameter;
    CGFloat controlH = diameter;
    CGFloat controlX = point.x-controlW/2;
    CGFloat controlY = point.y-controlH/2;
    
    ZBPageControl *pageControl = [[ZBPageControl alloc] initWithFrame:CGRectMake(controlX, controlY, controlW, controlH)];
    pageControl.seletcPage = 0;
    pageControl.nextPage = 1;
    pageControl.percent = 0;
    pageControl.diameter = diameter;
    pageControl.totalPage = count;
    
    return pageControl;
}

- (void)pageControlDidSelectDot:(NSInteger)index
{
    _seletcPage = index;
//    if (index == self.totalPage - 1) {
//        _nextPage = 0;
//    }else{
//        _nextPage = index + 1;
//    }
//    _percent = 0;
    [self setNeedsLayout];
}

//- (void)pageControlWillSelectNextDot:(NSInteger)nextIndex Percent:(CGFloat)percent
//{
//    _nextPage = nextIndex;
//    _percent = percent;
//    [self setNeedsLayout];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    __block CGFloat currentLength = 0;
    [self.subviews enumerateObjectsUsingBlock:^(ZBPageControlDotView * dotView, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat y = dotView.frame.origin.y;
        CGFloat x = currentLength;
        CGFloat H = _diameter;
        CGFloat SW = _diameter*3;
        CGFloat W = _diameter;
        
        if (idx == _seletcPage) {
            dotView.dotColor = _currentPageIndicatorTintColor;
            dotView.frame = CGRectMake(x, y, SW, H);
            currentLength = currentLength + SW + H;
        }else{
            dotView.dotColor = _pageIndicatorTintColor;
            dotView.frame = CGRectMake(x, y, W, H);
            currentLength = currentLength + W + H;
        }
    }];
}

- (void)setTotalPage:(NSInteger)totalPage
{
    if (self.subviews.count!=0) {
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    for (int i = 0; i<totalPage; i ++) {
        if (i == 0) {
            ZBPageControlDotView *dotView = [ZBPageControlDotView DotViewWithFrmame:CGRectMake(0, 0, _diameter*3, _diameter)];
            dotView.dotColor = _currentPageIndicatorTintColor;
            [self addSubview:dotView];
        }else{
            ZBPageControlDotView *dotView = [ZBPageControlDotView DotViewWithFrmame:CGRectMake( _diameter *(2*i +2), 0, _diameter, _diameter)];
            dotView.dotColor = _pageIndicatorTintColor;
            [self addSubview:dotView];
        }
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self setNeedsLayout];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
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
