//
//  ZBCycleScrollViewCell.h
//  无线循环
//
//  Created by ZDB on 2017/4/7.
//  Copyright © 2017年 zhuangbi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBCycleScrollViewCell : UICollectionViewCell
@property (weak ,nonatomic) UIImageView *imageView;
@property (copy ,nonatomic) NSString *imageString;
@property (strong ,nonatomic) UIImage *placeholder;
@end
