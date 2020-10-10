//
//  ZBCycleScrollViewCell.m
//  无线循环
//
//  Created by ZDB on 2017/4/7.
//  Copyright © 2017年 zhuangbi. All rights reserved.
//

#import "ZBCycleScrollViewCell.h"
#import <UIImageView+WebCache.h>
@implementation ZBCycleScrollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:imageView];
        _imageView = imageView;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = self.contentView.bounds;
}

- (void)setImageString:(NSString *)imageString
{
    [self setNeedsDisplay];
    _imageString = imageString;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:_placeholder];
}
@end
