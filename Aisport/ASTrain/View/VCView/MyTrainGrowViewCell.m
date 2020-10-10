//
//  MyTrainGrowViewCell.m
//  Aisport
//
//  Created by Apple on 2020/12/14.
//

#import "MyTrainGrowViewCell.h"

@implementation MyTrainGrowViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        for (int i = 0; i < 5; i++) {
            UIImageView *rankImageView = [[UIImageView alloc] init];
            [self addSubview:rankImageView];
            [rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).offset(17+(11+3)*i);
                make.bottom.equalTo(self.mas_bottom).offset(-11);
                make.height.mas_equalTo(11);
                make.width.mas_equalTo(11);
                
            }];
            rankImageView.image = [UIImage imageNamed:@"train_rank"];
            rankImageView.contentMode = UIViewContentModeScaleAspectFill;
            rankImageView.clipsToBounds = YES;
        }
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        [self addSubview:scoreLabel];
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-12);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(27+35+27);
            make.height.mas_equalTo(17);
        }];
        scoreLabel.textColor = [UIColor colorWithHex:@"#333333"];
        scoreLabel.font = fontBold(15);
        scoreLabel.textAlignment = NSTextAlignmentCenter;
        scoreLabel.text = @"8888";
//        _scoreLabel = scoreLabel;
        
        
        
        UILabel *rankLabel = [[UILabel alloc] init];
        [self addSubview:rankLabel];
        [rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(17);
        }];
        rankLabel.textColor = [UIColor colorWithHex:@"#333333"];
        rankLabel.font = fontBold(11);
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.text = @"排行榜NO.1";
        
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-13);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(17);
        }];
        timeLabel.textColor = [UIColor colorWithHex:@"#999999"];
        timeLabel.font = fontApp(10);
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.text = @"2020/02/22  15:32";
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
