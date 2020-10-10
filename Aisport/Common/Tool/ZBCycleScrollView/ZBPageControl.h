//
//  ZBPageControl.h
//  无线循环
//
//  Created by ZDB on 2017/4/7.
//  Copyright © 2017年 zhuangbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBPageControl : UIView

- (instancetype)pageControlWithCenter:(CGPoint)point Count:(NSInteger)count DotDiameter:(CGFloat)diameter ;

@property (assign ,nonatomic) CGFloat diameter;
@property (strong ,nonatomic) UIColor *pageIndicatorTintColor;//未选中
@property (strong ,nonatomic) UIColor *currentPageIndicatorTintColor;//选中
@property (assign ,nonatomic) NSInteger totalPage;
@property (assign ,nonatomic) NSInteger seletcPage;
@property (assign ,nonatomic) NSInteger nextPage;//将要移动的页码
@property (assign ,nonatomic) CGFloat percent;//偏移百分比

- (void)pageControlDidSelectDot:(NSInteger)index;
- (void)pageControlWillSelectNextDot:(NSInteger)nextIndex Percent:(CGFloat)percent;

@end
