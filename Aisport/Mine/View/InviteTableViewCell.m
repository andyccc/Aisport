//
//  InviteTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import "InviteTableViewCell.h"

@interface InviteTableViewCell ()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation InviteTableViewCell


+ (CGFloat)cellHeight
{
    return UIV(74 + 16);
}

- (void)initSelf
{
    
    self.bgView = [[UIImageView alloc] init];
    self.bgView.width = UIScreenWidth - UIV(16 *2);
    self.bgView.height = UIV(74);
    self.bgView.left = UIV(16);
    self.bgView.top = UIV(8);
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = UIV(10);
    [self.contentView addSubview:self.bgView];
    self.bgView.image = [UIImage imageNamed:@"icon_invite_bg"];

    self.iconView = [[UIImageView alloc] init];
    self.iconView.size = self.bgView.size;
    self.iconView.image = [UIImage imageNamed:@"icon_invite"];

    [self.bgView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.width = self.bgView.width;
    self.titleLabel.height = self.bgView.height;
    self.titleLabel.left = uiv(17);
    self.titleLabel.numberOfLines =2;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@""];
    {
        NSMutableAttributedString *string = [
          [NSMutableAttributedString alloc] initWithString:@"邀请好礼送\n"
          attributes: @{
            NSFontAttributeName: fontApp(16),
            NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]
        }];
        [attString appendAttributedString:string];
    }
    {
        NSMutableAttributedString *string = [
          [NSMutableAttributedString alloc] initWithString:@"填写邀请码，即可获好礼"
          attributes: @{
            NSFontAttributeName: fontApp(12),
            NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.43]
        }];
        [attString appendAttributedString:string];
    }
    self.titleLabel.attributedText = attString;
    [self.bgView addSubview:self.titleLabel];

}



@end
