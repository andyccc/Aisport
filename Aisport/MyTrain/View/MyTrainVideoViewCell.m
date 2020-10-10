//
//  MyTrainVideoViewCell.m
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import "MyTrainVideoViewCell.h"
#import "UILabel+getWidth.h"

@implementation MyTrainVideoViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(self.mas_centerY);
            make.top.equalTo(self.mas_top).offset(1);
            make.left.equalTo(self.contentView.mas_left).offset(15*2*Screen_Scale);
            make.width.mas_equalTo(171*2*Screen_Scale);
            make.height.mas_equalTo(100*2*Screen_Scale);
        }];
        iconImageView.userInteractionEnabled = YES;
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.layer.cornerRadius = 5;
        iconImageView.clipsToBounds = YES;
        iconImageView.image = [UIImage imageNamed:@"home_hejipic"];
        _iconImageView = iconImageView;
        
        UIView *coverView = [[UIView alloc] init];
        [iconImageView addSubview:coverView];
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_top).offset(0);
            make.left.equalTo(iconImageView.mas_left);
            make.right.equalTo(iconImageView.mas_right);
            make.bottom.equalTo(iconImageView.mas_bottom);
        }];
        coverView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.1];
        coverView.layer.cornerRadius = 5;
        coverView.clipsToBounds = YES;
        
        UILabel *difficultLabel = [[UILabel alloc] init];
        [coverView addSubview:difficultLabel];
        [difficultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverView.mas_top).offset(8);
            make.width.mas_equalTo(50);
            make.right.equalTo(coverView.mas_right).offset(-10);
            make.height.mas_equalTo(11);
        }];
        difficultLabel.font = fontApp(11);
        difficultLabel.textColor = [UIColor colorWithHex:@"#FFFFFF"];
        difficultLabel.textAlignment = NSTextAlignmentRight;
        difficultLabel.text = @"入门";
        _difficultLabel = difficultLabel;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_top).offset(0);
            make.left.equalTo(iconImageView.mas_right).offset(15);
            make.right.equalTo(self.mas_right).offset(-26);
            make.height.mas_equalTo(15);
        }];
        nameLabel.font = fontBold(14);
        nameLabel.textColor = [UIColor colorWithHex:@"#333333"];
//        nameLabel.numberOfLines = 0;
        nameLabel.text = @"帕梅拉-20min臀部+大腿负重训练丨全称讲解...";
        _nameLabel = nameLabel;
        
        UILabel *autherLabel = [[UILabel alloc] init];
        [self addSubview:autherLabel];
        [autherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(nameLabel.mas_bottom).offset(15);
            make.left.equalTo(iconImageView.mas_right).offset(15);
            make.right.equalTo(self.mas_right).offset(-26);
            make.height.mas_equalTo(11);
        }];
        autherLabel.font = fontApp(11);
        autherLabel.textColor = [UIColor colorWithHex:@"#333333"];
//        autherLabel.numberOfLines = 0;
        autherLabel.text = @"王建国";
        _autherLabel = autherLabel;
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        [self addSubview:scoreLabel];
        [scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(autherLabel.mas_bottom).offset(15);
            make.left.equalTo(iconImageView.mas_right).offset(15);
            make.right.equalTo(self.mas_right).offset(-26);
            make.height.mas_equalTo(11);
        }];
        scoreLabel.font = fontApp(11);
        scoreLabel.textColor = [UIColor colorWithHex:@"#333333"];
//        autherLabel.numberOfLines = 0;
        scoreLabel.text = @"上次得分：6322";
        _scoreLabel = scoreLabel;
        
        NSString *timeStr = @"练过22次";
        CGFloat timeW = [UILabel getWidthWithTitle:timeStr font:fontApp(11)];
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(iconImageView.mas_bottom).offset(0);
            make.left.equalTo(iconImageView.mas_right).offset(15);
            make.width.mas_equalTo(timeW+18);
            make.height.mas_equalTo(21);
        }];
        timeLabel.font = fontApp(11);
        timeLabel.textColor = [UIColor colorWithHex:@"#1BC2B1"];
//        timeLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.text = timeStr;
        timeLabel.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.07];//0.07
        timeLabel.layer.cornerRadius = 3;
//        timeLabel.layer.borderColor = [[UIColor colorWithHex:@"#1BC2B1"] CGColor];
//        timeLabel.layer.borderWidth = 1;
        timeLabel.clipsToBounds = YES;
        _timeLabel = timeLabel;
        
        UIButton *jumpButton = [[UIButton alloc] init];
        [self addSubview:jumpButton];
        [jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(coverView.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.mas_equalTo(61);
            make.height.mas_equalTo(26);
        }];
        [jumpButton setTitle:@"跳舞吧！" forState:UIControlStateNormal];
        [jumpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jumpButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
        jumpButton.titleLabel.font = fontBold(11);
        jumpButton.layer.cornerRadius = 5;
        jumpButton.clipsToBounds = YES;
        jumpButton.userInteractionEnabled = NO;
        jumpButton.hidden = YES;
//        [jumpButton addTarget:self action:@selector(clickjumpButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void)setHomeModel:(HomeListModel *)homeModel
{
    _homeModel = homeModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(homeModel.cover)] placeholderImage:nil];
    _difficultLabel.text = StringForId(homeModel.leverVStr);
    _nameLabel.text = StringForId(homeModel.name);
    _autherLabel.text = StringForId(homeModel.author);
//    _autherLabel.text = StringForId(homeModel.description);
    _scoreLabel.text = [NSString stringWithFormat:@"当前记录:%@",StringNumForId(homeModel.curHighScore, @"0")];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@人跳过",StringNumForId(homeModel.playTotal, @"0")];
    if ([StringNumForId(homeModel.playTotal, @"0") longLongValue] >= 10000) {
        timeStr = [NSString stringWithFormat:@"%.1f万人跳过",[StringNumForId(homeModel.playTotal, @"0") floatValue]/10000.0];
    }
    CGFloat timeW = [UILabel getWidthWithTitle:timeStr font:fontApp(10)];
    _timeLabel.frame = CGRectMake((SCR_WIDTH - 37*2*Screen_Scale)/2-timeW-8-4, _autherLabel.bottom+3, timeW+4, 17);
//    timeLabel.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.07];//0.07
//    timeLabel.layer.cornerRadius = 3;
//    timeLabel.clipsToBounds = YES;
    _timeLabel.text = timeStr;
}

- (void)setVideoModel:(TrainVideoModel *)videoModel
{
    _videoModel = videoModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(videoModel.cover)] placeholderImage:nil];
    _difficultLabel.text = StringForId(videoModel.leverVStr);
    _nameLabel.text = StringForId(videoModel.name);
    _autherLabel.text = StringForId(videoModel.author);
//    _autherLabel.text = StringForId(videoModel.description);
    _scoreLabel.text = [NSString stringWithFormat:@"上次得分：%@",StringNumForId(videoModel.lastScore, @"0")];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@人跳过",StringNumForId(videoModel.playTotal, @"0")];
    if ([StringNumForId(videoModel.playTotal, @"0") longLongValue] >= 10000) {
        timeStr = [NSString stringWithFormat:@"%.1f万人跳过",[StringNumForId(videoModel.playTotal, @"0") floatValue]/10000.0];
    }
    CGFloat timeW = [UILabel getWidthWithTitle:timeStr font:fontApp(10)];
    _timeLabel.frame = CGRectMake((SCR_WIDTH - 37*2*Screen_Scale)/2-timeW-8-4, _autherLabel.bottom+3, timeW+4, 17);
//    timeLabel.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.07];//0.07
//    timeLabel.layer.cornerRadius = 3;
//    timeLabel.clipsToBounds = YES;
    _timeLabel.text = timeStr;
    
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
