//
//  UIView+NoDataEmptyView.m
//  STC
//
//  Created by andyccc on 2019/7/25.
//  Copyright © 2019 hzty. All rights reserved.
//

#import "UIView+NoDataEmptyView.h"


@implementation NoDataEmptyView
{
    BOOL _inited;
}

- (id)init
{
    if (self = [super init]) {
        [self initSelf];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSelf];
    }
    
    return self;
}

- (void)initSelf
{
    if (!_inited) {
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        
        _inited = YES;
    }
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end

@implementation UIView (NoDataEmptyView)

- (void)setEmptyView:(NoDataEmptyView *)emptyView
{
    objc_setAssociatedObject(self, @selector(emptyView), emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NoDataEmptyView *)emptyView
{
    return objc_getAssociatedObject(self, _cmd);
}

- (NoDataEmptyView *)anyView
{
    CGRect frame = CGRectMake(0, 0, self.width, self.height);
    NoDataEmptyView *_emptyView = [[NoDataEmptyView alloc] initWithFrame:frame];
    
    UIImageView *iconImageView = _emptyView.iconImageView;
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.width = UIValue(268);
    iconImageView.height = UIValue(192);
    iconImageView.left = (_emptyView.width - iconImageView.width) / 2;
    iconImageView.image = [UIImage imageNamed:@"icon_empty"];
    
    if ([self isKindOfClass:UITableView.class]) {
        UITableView *_tableView = (UITableView *)self;
        iconImageView.centerY = _emptyView.height / 2.0 - _tableView.contentInset.top - _tableView.contentInset.bottom;
    } else {
        iconImageView.centerY = _emptyView.height / 2.0 ;
    }
    
    UILabel *titleLabel = _emptyView.titleLabel;
    titleLabel.frame = CGRectMake(0, iconImageView.bottom - UIValue(20), _emptyView.width, uiv(20));
    
    titleLabel.textColor = [UIColor colorWithHex:@"#999999"];
    titleLabel.font = FontR(20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"空空如也";
    
    _emptyView.userInteractionEnabled = NO;
    _emptyView.iconImageView.userInteractionEnabled = NO;
    _emptyView.titleLabel.userInteractionEnabled = NO;
    
    return _emptyView;
}

- (void)showEmptyView
{
    if (!self.emptyView) {
        self.emptyView = [self anyView];
        
    }
    [self addSubview:self.emptyView];
}

- (void)hideEmptyView
{
    [self.emptyView removeFromSuperview];
}


@end
