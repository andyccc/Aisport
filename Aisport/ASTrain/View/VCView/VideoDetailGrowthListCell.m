//
//  VideoDetailGrowthListCell.m
//  Aisport
//
//  Created by 申公安 on 2020/12/26.
//

#import "VideoDetailGrowthListCell.h"

#define CELL_HEIGHT UIValue(60)


@implementation StartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    for (int i=0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*UIValue(12), 0, UIValue(12), UIValue(12))];
        imageView.image = [UIImage imageNamed:@"star_small_icon"];
        [self addSubview:imageView];
    }
    self.clipsToBounds = YES;
}

@end


@implementation VideoDetailGrowthListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.iconImageView];
        [self.bgView addSubview:self.nameLabel];
        [self.bgView addSubview:self.startView];
        [self.bgView addSubview:self.bankLabel];
        [self.bgView addSubview:self.timeLabel];
        [self.bgView addSubview:self.startView];
    }
    return self;
}

- (void)fillData:(VideoDetailGrowthListModel *)data
{
    self.nameLabel.text = data.score.stringValue;
    self.bankLabel.text = [NSString stringWithFormat:@"排行榜NO.%@",data.rank];
    self.timeLabel.text = data.updateTime;
    self.startView.width = UIValue(12)*data.star.intValue;
    self.startView.centerX = self.nameLabel.centerX;
    self.iconImageView.hidden = !data.isNew.boolValue;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(UIValue(16), 0, SCR_WIDTH-UIValue(32), CELL_HEIGHT)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, UIValue(6), UIValue(43), UIValue(14))];
        _iconImageView.image = [UIImage imageNamed:@"new_record_icon"];
        _iconImageView.right = self.bgView.width - UIValue(15);
    }
    return _iconImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIValue(25), UIValue(13), UIValue(50), UIValue(20))];
        _nameLabel.textColor = [UIColor colorForHex:@"#333333"];
        _nameLabel.font = FontR(14);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UILabel *)bankLabel
{
    if (!_bankLabel) {
        _bankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIValue(90), UIValue(20))];
        _bankLabel.textColor = [UIColor colorForHex:@"#333333"];
        _bankLabel.font = FontR(12);
        _bankLabel.textAlignment = NSTextAlignmentCenter;
        _bankLabel.centerX = self.bgView.width/2.0;
        _bankLabel.centerY = self.bgView.height/2.0;
    }
    return _bankLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIValue(120), UIValue(20))];
        _timeLabel.textColor = [UIColor colorForHex:@"#333333"];
        _timeLabel.font = FontR(11);
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.centerY = self.bgView.height/2.0;
        _timeLabel.right = self.bgView.width - UIValue(15);
    }
    return _timeLabel;
}

- (StartView *)startView
{
    if (!_startView) {
        _startView = [[StartView alloc] initWithFrame:CGRectMake(UIValue(15), self.nameLabel.bottom, UIValue(60), UIValue(13))];
    }
    return _startView;
}

+ (CGFloat)cellHeight
{
    return CELL_HEIGHT;
}

@end
