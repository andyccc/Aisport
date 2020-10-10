//
//  VideoDetailBankListCell.m
//  Aisport
//
//  Created by 申公安 on 2020/12/26.
//

#import "VideoDetailBankListCell.h"

#define CELL_HEIGHT UIValue(44)

@implementation VideoDetailBankListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        [self.contentView addSubview:self.bgView];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.avtarImageView];
        [self.contentView addSubview:self.indexLabel];
        [self.contentView addSubview:self.countLabel];
    }
    return self;
}

- (void)fillData:(NSDictionary *)data withIndex:(NSInteger)index;
{
    self.iconImageView.hidden = index > 3;
    NSString *iconStr = [NSString stringWithFormat:@"crown_icon_%ld",index + 1];
    self.iconImageView.image = [UIImage imageNamed:iconStr];
    self.indexLabel.hidden = index < 3;
    if (index < 10) {
        self.indexLabel.text = [NSString stringWithFormat:@"0%ld",index + 1];
    } else {
        self.indexLabel.text = [NSString stringWithFormat:@"%ld",(long)index];
    }
    [self.avtarImageView sd_setImageWithURL:[NSURL URLWithString:data[@"userCover"]]];
    self.nameLabel.text = data[@"nickName"];
    self.countLabel.text = [NSString stringWithFormat:@"%@",data[@"score"]];
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
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UIValue(25), UIValue(7), UIValue(27), UIValue(27))];
        _iconImageView.centerY = CELL_HEIGHT/2.0;
    }
    return _iconImageView;
}

- (UIImageView *)avtarImageView
{
    if (!_avtarImageView) {
        _avtarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.iconImageView.right + UIValue(13), self.iconImageView.top, UIValue(30), UIValue(30))];
        _avtarImageView.layer.cornerRadius = UIValue(15);
        _avtarImageView.layer.masksToBounds = YES;
        _avtarImageView.centerY = CELL_HEIGHT/2.0;
    }
    return _avtarImageView;
}

- (UILabel *)indexLabel
{
    if (!_indexLabel) {
        _indexLabel = [[UILabel alloc] initWithFrame:self.iconImageView.frame];
        _indexLabel.textColor = [UIColor colorForHex:@"#A5A1A1"];
        _indexLabel.font = FontBoldR(12);
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.centerY = CELL_HEIGHT/2.0;
    }
    return _indexLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avtarImageView.right + UIValue(12), 0, UIValue(150), UIValue(20))];
        _nameLabel.textColor = [UIColor colorForHex:@"#333333"];
        _nameLabel.font = FontBoldR(12);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.centerY = CELL_HEIGHT/2.0;
    }
    return _nameLabel;
}

- (UILabel *)countLabel
{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIValue(100), UIValue(20))];
        _countLabel.textColor = [UIColor colorForHex:@"#333333"];
        _countLabel.font = FontR(12);
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.right = SCR_WIDTH - UIValue(21);
        _countLabel.centerY = CELL_HEIGHT/2.0;
    }
    return _countLabel;
}

+ (CGFloat)cellHeihgt
{
    return CELL_HEIGHT;
}

@end
