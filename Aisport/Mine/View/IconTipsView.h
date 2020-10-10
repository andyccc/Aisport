//
//  MyBagUseView.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IconTipsView : UIView

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIView *bgView;


@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *desLabel;

@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, copy) void (^okBlock) (void);
 

- (void)show;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
