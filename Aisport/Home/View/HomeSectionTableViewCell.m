//
//  HomeSectionTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "HomeSectionTableViewCell.h"

@implementation HomeSectionTableViewCell

+ (CGFloat)cellHeight
{
    return UIValue(44);
}

- (void)initSelf
{
    self.textLabel.width = UIValue(100);
    self.textLabel.left = UIValue(16);
    self.textLabel.height = UIValue(44);
    self.textLabel.font = FontBoldR(17);
    self.textLabel.textColor = [UIColor colorWithHex:@"#333333"];
    
 
    self.iconView = [[UIImageView alloc] init];
    self.iconView.width = uiv(6);
    self.iconView.height = uiv(11);
    self.iconView.image = [UIImage imageNamed:@"icon_arrow_gray"];
    self.iconView.centerY = self.height / 2.0;
    [self addSubview:self.iconView];
 
    self.rightBtn = [[UIButton alloc] init];
    self.rightBtn.width = UIValue(34);
    self.rightBtn.height = UIValue(44);
    self.rightBtn.titleLabel.font = FontR(14);
    [self.rightBtn setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
    [self.rightBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.rightBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.iconView.right = self.contentView.width - UIValue(16);
    self.iconView.centerY = self.contentView.height / 2.0;
    
    self.rightBtn.right = self.iconView.left;
}

- (void)btnAction
{
    !self.btnBlock ?: self.btnBlock();
}

- (void)fillData:(id)data
{
    self.textLabel.text = data[@"title"];
    BOOL more = [data[@"more"] boolValue];
    self.rightBtn.hidden = self.iconView.hidden = !more;
    self.btnBlock = data[@"block"];
    
}


@end
