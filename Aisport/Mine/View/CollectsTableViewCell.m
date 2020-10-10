//
//  CollectsTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import "CollectsTableViewCell.h"

@interface CollectsTableViewCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *countLabel;



@end

@implementation CollectsTableViewCell


+ (CGFloat)cellHeight
{
    return UIV(78 + 16);
}

- (void)initSelf
{
    
    self.bgView = [[UIView alloc] init];
    self.bgView.width = UIScreenWidth - UIV(16 *2);
    self.bgView.height = UIV(78);
    self.bgView.left = UIV(16);
    self.bgView.top = UIV(8);
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = UIV(10);
    
    [self.contentView addSubview:self.bgView];
    
    self.coverView = [[UIImageView alloc] init];
    self.coverView.width = uiv(50);
    self.coverView.height = uiv(50);
    self.coverView.left = uiv(17);
    self.coverView.centerY = self.bgView.height / 2.0;
    self.coverView.layer.cornerRadius = 4;
    self.coverView.layer.masksToBounds = YES;
    self.coverView.backgroundColor = [UIColor colorWithHex:@"#cccccc"];
    
    [self.bgView addSubview:self.coverView];

    self.countLabel = [[UILabel alloc] init];
    self.countLabel.width = self.bgView.width / 2.0;
    self.countLabel.height = self.bgView.height;
    self.countLabel.left = self.coverView.right + uiv(13);
    self.countLabel.numberOfLines =2;
    [self.bgView addSubview:self.countLabel];

}

- (void)fillData:(id)data
{
    NSString *cover = data[@"cover"];
    NSString *videoTotal = [data[@"videoTotal"] description];
    if (!videoTotal) {
        videoTotal = @"0";
    }
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:StringForId(cover)] placeholderImage:nil];

    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:@""];
    {
        NSMutableAttributedString *string = [
          [NSMutableAttributedString alloc] initWithString:@"我收藏的舞曲\n"
          attributes: @{
            NSFontAttributeName: fontApp(16),
            NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]
        }];
        [attstring appendAttributedString:string];
    }
    
    {
        NSMutableAttributedString *string = [
          [NSMutableAttributedString alloc] initWithString:videoTotal
          attributes: @{
            NSFontAttributeName: fontApp(12),
            NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]
        }];
        [attstring appendAttributedString:string];
    }
    
    self.countLabel.attributedText = attstring;
}

@end
