//
//  ScoreInfoTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import "ScoreInfoTableViewCell.h"

@interface ScoreInfoTableViewCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *totalCountLabel;
@property (nonatomic, strong) UILabel *winCountLabel;
@property (nonatomic, strong) UILabel *highCountLabel;


@end


@implementation ScoreInfoTableViewCell

+ (CGFloat)cellHeight
{
    return UIV(68 + 16);
}

- (void)initSelf
{
    self.bgView = [[UIView alloc] init];
    self.bgView.width = UIScreenWidth - UIV(16 *2);
    self.bgView.height = UIV(68);
    self.bgView.left = UIV(16);
    self.bgView.top = UIV(8);
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = UIV(10);
    self.bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    
    self.scoreLabel = [self createLabel];
    self.scoreLabel.centerY = self.bgView.height / 2.0;
    self.scoreLabel.text = @"我的\n战绩";
    self.scoreLabel.font = fontApp(14);
    [self.bgView addSubview:self.scoreLabel];
    
    
    
    
    self.lineView = [[UIView alloc] init];
    self.lineView.width = 0.5;
    self.lineView.height = UIV(40);
    self.lineView.left = self.scoreLabel.right;
    self.lineView.backgroundColor = [UIColor colorWithHex:@"#D8D8D8"];
    self.lineView.centerY = self.bgView.height / 2.0;

    [self.bgView addSubview:self.lineView];

    
    self.totalCountLabel = [self createLabel];
    self.totalCountLabel.left = self.scoreLabel.right;
    self.totalCountLabel.centerY = self.bgView.height / 2.0;

    [self.bgView addSubview:self.totalCountLabel];

    
    self.winCountLabel = [self createLabel];
    self.winCountLabel.left = self.totalCountLabel.right;
    self.winCountLabel.centerY = self.bgView.height / 2.0;

    [self.bgView addSubview:self.winCountLabel];

    
    self.highCountLabel = [self createLabel];
    self.highCountLabel.left = self.winCountLabel.right;
    self.highCountLabel.centerY = self.bgView.height / 2.0;

    [self.bgView addSubview:self.highCountLabel];

    
}

- (void)fillData:(id)data
{
    NSString *winTotal = [data[@"winTotal"] description];
    NSString *winRate = [data[@"winRate"] description];
    if (winRate) {
        winRate = [NSString stringWithFormat:@"%@%%", winRate];
    } else {
        winRate = @"-";
    }
    
    NSString *maxScore = [data[@"maxScore"] description];

    [self setLabelTitle:@"总胜场" count:winTotal label:self.totalCountLabel];
    [self setLabelTitle:@"胜率" count:winRate label:self.winCountLabel];
    [self setLabelTitle:@"单场最高" count:maxScore label:self.highCountLabel];
}

- (void)setLabelTitle:(NSString *)title count:(NSString *)count label:(UILabel *)label
{
    if (!count) {
        count = @"-";
    }
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:@""];
    
    {
        NSMutableAttributedString *string = [
          [NSMutableAttributedString alloc] initWithString:title
          attributes: @{
            NSFontAttributeName: fontApp(13),
            NSForegroundColorAttributeName: [UIColor colorWithHex:@"#999999"]
        }];

        [attstring appendAttributedString:string];
    }
    
    [attstring appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];

    {
        NSMutableAttributedString *string = [
          [NSMutableAttributedString alloc] initWithString:count
          attributes: @{
            NSFontAttributeName: fontApp(16),
            NSForegroundColorAttributeName: [UIColor colorWithHex:@"#333333"]
        }];

        [attstring appendAttributedString:string];
    }
    
    
    label.attributedText = attstring;
    
    
}


- (UILabel *)createLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.width = (UIScreenWidth - UIV(16 *2)) / 4;
    label.height = UIV(40);
    label.numberOfLines = 2;
    return label;
}



@end
