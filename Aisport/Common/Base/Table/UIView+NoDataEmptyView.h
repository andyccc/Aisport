//
//  UIView+NoDataEmptyView.h
//  STC
//
//  Created by andyccc on 2019/7/25.
//  Copyright © 2019 hzty. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoDataEmptyView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@interface UIView (NoDataEmptyView)

@property (nonatomic, strong) NoDataEmptyView *emptyView;

- (void)showEmptyView;

- (void)hideEmptyView;

@end

NS_ASSUME_NONNULL_END
