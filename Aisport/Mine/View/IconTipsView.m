//
//  MyBagUseView.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "IconTipsView.h"
#import "YYKit.h"

@interface IconTipsView ()


@end

@implementation IconTipsView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSelf];
    }
    
    return self;
}

- (void)initSelf
{
    self.backView = [[UIView alloc] init];
    self.backView.size = self.size;
    self.backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.38];
    [self addSubview:self.backView];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.width = self.width - UIValue(44);
    self.bgView.left = UIValue(22);
    self.bgView.layer.cornerRadius = UIValue(15);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    
    self.iconView = [[UIImageView alloc] init];
    self.iconView.width = UIValue(108);
    self.iconView.height = UIValue(108);
    self.iconView.centerX = self.width / 2.0;
    self.iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconView];
    
    self.closeBtn = [[UIButton alloc] init];
    self.closeBtn.width = uiv(44);
    self.closeBtn.height = uiv(44);
    self.closeBtn.right = self.bgView.width;
    [self.closeBtn setImage:[UIImage imageNamed:@"icon_remove"] forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.closeBtn];
    
    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.width = self.bgView.width - UIValue(26 * 2);
    self.infoLabel.font = FontR(20);
    self.infoLabel.left = UIValue(26);
    self.infoLabel.top = self.iconView.height / 2.0 + UIValue(10);
    self.infoLabel.textColor = [UIColor blackColor];
    [self.bgView addSubview:self.infoLabel];

    self.desLabel = [[UILabel alloc] init];
    self.desLabel.width = self.bgView.width - UIValue(26 * 2);
    self.desLabel.font = FontR(18);
    self.desLabel.left = UIValue(26);
    self.desLabel.top = UIValue(10);
    self.desLabel.textColor = [UIColor colorWithHex:@"#333333"];
    self.desLabel.numberOfLines = 9999;
    [self.bgView addSubview:self.desLabel];

    self.okBtn = [[UIButton alloc] init];
    self.okBtn.width = self.bgView.width - UIValue(31 *2);
    self.okBtn.height = UIValue(51);
    self.okBtn.backgroundColor = [UIColor colorWithHex:@"#FBB313"];
    self.okBtn.titleLabel.font = FontR(17);
    self.okBtn.layer.masksToBounds = YES;
    self.okBtn.centerX = self.bgView.width / 2.0;
    self.okBtn.layer.cornerRadius = self.okBtn.height / 2.0;
    [self.okBtn setTitle:@"" forState:UIControlStateNormal];
    [self.okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.okBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:self.okBtn];

}

- (void)layout
{
    self.infoLabel.height = [self.infoLabel.text heightForFont:self.infoLabel.font width:self.infoLabel.width];
    
    self.desLabel.top = self.infoLabel.bottom + UIValue(20);
    self.desLabel.height = [self.desLabel.text heightForFont:self.desLabel.font width:self.desLabel.width];
    
    self.okBtn.top = self.desLabel.bottom + UIValue(21);
    
    self.bgView.height = self.okBtn.bottom + UIValue(18);
    self.bgView.centerY = self.height /2.0;
    
    self.iconView.centerY = self.bgView.top;
}

#pragma mark -

- (void)closeAction
{
    [self dismiss];
}

- (void)okAction
{
    !self.okBlock ?: self.okBlock();
}

- (void)show
{
    [self layout];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

@end
