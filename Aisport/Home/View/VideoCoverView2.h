//
//  VideoCoverView2.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoCoverView2 : UIView
@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *lveLabel;
@property (nonatomic, strong) UIButton *tapBtn;
@property (nonatomic, strong) UILabel *titleLabel;

- (void)layout;

- (void)setLev:(int)type;

@end

NS_ASSUME_NONNULL_END
