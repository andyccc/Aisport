//
//  ZBCycleScrollView.h
//  ZhuangDianBi
//
//  Created by ZDB on 2017/4/7.
//  Copyright © 2017年 ZDB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZBCycleScrollViewDelegate <NSObject>

- (void)cycleScrollViewDidSelectIndex:(NSInteger)index;


@end

@interface ZBCycleScrollView : UIView

/**
 *  图片数组
 */
@property (strong ,nonatomic) NSArray *imagesArray;

/**
 *  滚动间隔
 */
@property (assign ,nonatomic) NSTimeInterval scrollTimeInterval;
@property (strong ,nonatomic) UIImage *placeholderImage;
@property (assign ,nonatomic ,getter=shouldAutomatic) BOOL automatic;//自动循环
@property (assign ,nonatomic) CGFloat dotWidth;
@property (strong ,nonatomic) UIColor *pageIndicatorTintColor;//未选中
@property (strong ,nonatomic) UIColor *currentPageIndicatorTintColor;//选中
@property (weak ,nonatomic) id<ZBCycleScrollViewDelegate> delegate;

- (instancetype)cycleScrollViewWithFrame:(CGRect)frame ScrollDelegate:(id<ZBCycleScrollViewDelegate>)delegate;

@end
