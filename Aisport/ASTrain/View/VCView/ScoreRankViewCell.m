//
//  ScoreRankViewCell.m
//  Aisport
//
//  Created by Apple on 2020/12/14.
//

#import "ScoreRankViewCell.h"

@implementation ScoreRankViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *rankImageView = [[UIImageView alloc] init];
        [self addSubview:rankImageView];
        [rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(14);
            make.height.mas_equalTo(19);
            make.height.mas_equalTo(22);
        }];
        rankImageView.image = [UIImage imageNamed:@"home_hejipic"];
        rankImageView.contentMode = UIViewContentModeScaleAspectFill;
        rankImageView.clipsToBounds = YES;
        rankImageView.hidden = YES;
        _rankImageView = rankImageView;
        
        UILabel *rankLabel = [[UILabel alloc] init];
        [self addSubview:rankLabel];
        [rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(47);
            make.height.mas_equalTo(17);
        }];
        rankLabel.textColor = [UIColor colorWithHex:@"#333333"];
        rankLabel.font = fontBold(16);
        rankLabel.textAlignment = NSTextAlignmentCenter;
        rankLabel.text = @"4";
        _rankLabel = rankLabel;
        
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self.mas_left).offset(47);
            make.height.mas_equalTo(30);
            make.height.mas_equalTo(30);
        }];
        iconImageView.image = [UIImage imageNamed:@"home_hejipic"];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.layer.cornerRadius = 15;
        iconImageView.clipsToBounds = YES;
        _iconImageView = iconImageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImageView.mas_left).offset(12);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(17);
        }];
        nameLabel.textColor = [UIColor colorWithHex:@"#333333"];
        nameLabel.font = fontApp(13);
        nameLabel.text = @"天涯";
        _nameLabel = nameLabel;
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        [self addSubview:scoreLabel];
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-12);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(17);
        }];
        scoreLabel.textColor = [UIColor colorWithHex:@"#333333"];
        scoreLabel.font = fontApp(13);
        scoreLabel.textAlignment = NSTextAlignmentRight;
        scoreLabel.text = @"8888";
        _scoreLabel = scoreLabel;
    }
    return self;
}

- (void)setIsMySelf:(BOOL)isMySelf
{
    _isMySelf = isMySelf;
    if (isMySelf) {
        [_rankLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(23);
        }];
        [_iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(47+23);
        }];
    }
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
