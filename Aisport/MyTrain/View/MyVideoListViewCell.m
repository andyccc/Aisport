//
//  MyVideoListViewCell.m
//  Aisport
//
//  Created by Apple on 2020/11/12.
//

#import "MyVideoListViewCell.h"

@implementation MyVideoListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(15*2*Screen_Scale);
            make.width.mas_equalTo(106*2*Screen_Scale);
            make.height.mas_equalTo(79*2*Screen_Scale);
        }];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.layer.cornerRadius = 5;
        iconImageView.clipsToBounds = YES;
        iconImageView.image = [UIImage imageNamed:@"home_hejipic"];
        _iconImageView = iconImageView;
        
        //CGRectMake(0, 0, frame.size.width, 113*2*Screen_Scale)
        UIButton *playButton = [[UIButton alloc] init];
        [self addSubview:playButton];
        [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.equalTo(self.contentView.mas_left).offset(15*2*Screen_Scale);
            make.width.mas_equalTo(106*2*Screen_Scale);
            make.height.mas_equalTo(79*2*Screen_Scale);
        }];
        [playButton setImage:[UIImage imageNamed:@"home_play"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(clickplayVideoButton) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(iconImageView.mas_top).offset(7);
            make.left.equalTo(iconImageView.mas_right).offset(8);
            make.right.equalTo(self.mas_right).offset(-22);
            make.height.mas_equalTo(35);
        }];
        nameLabel.font = fontApp(14);
        nameLabel.textColor = [UIColor colorWithHex:@"#333333"];
        nameLabel.numberOfLines = 2;
        nameLabel.text = @"帕梅拉-20min臀部+大腿负重训练丨全称讲解...";
        _nameLabel = nameLabel;
        
        
        UILabel *timeLabel = [[UILabel alloc] init];
        [self addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(iconImageView.mas_bottom).offset(-7);
            make.left.equalTo(iconImageView.mas_right).offset(8);
            make.right.equalTo(self.contentView.mas_right).offset(-22);
            make.height.mas_equalTo(12);
        }];
        timeLabel.font = fontApp(12);
        timeLabel.textColor = [UIColor colorWithHex:@"#999999"];
        timeLabel.text = @"13:12";
        _timeLabel = timeLabel;
        
        
    }
    
    return self;
}

- (void)setVideoModel:(TrainVideoModel *)videoModel
{
    _videoModel = videoModel;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(videoModel.cover)] placeholderImage:[UIImage imageNamed:@"placeHolderImg"]];
    _nameLabel.text = StringForId(videoModel.name);
    _timeLabel.text = [DatetimeOpeartion getTimeHoursMinuteSecondHCurrentTimeWith:StringForId(videoModel.time).longLongValue];
    
}

- (void)clickplayVideoButton
{
    if (self.playWholeVideoBlcok) {
        self.playWholeVideoBlcok(StringForId(_videoModel.url));
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
