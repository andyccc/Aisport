//
//  VideoDetailIntroductionCell.m
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import "VideoDetailIntroductionCell.h"

@interface VideoDetailIntroductionCell()

@property (nonatomic, strong) UILabel *authorLabel;
@property (nonatomic, strong) UILabel *introductionLabel;

@end

@implementation VideoDetailIntroductionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        [self.contentView addSubview:self.authorLabel];
        [self.contentView addSubview:self.introductionLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.clipsToBounds = YES;
    self.introductionLabel.height = [VideoDetailIntroductionCell cellHeight:self.introductionLabel.text] - UIValue(26);
}

- (void)fillData:(VideoDetailInfoModel *)data
{
    self.authorLabel.text = [NSString stringWithFormat:@"作者：%@", data.author];
    NSString *temp = data.content;
    self.introductionLabel.text = [NSString stringWithFormat:@"简介：%@", temp];
}

- (UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIValue(16), UIValue(10), SCR_WIDTH - UIValue(32), UIValue(11))];
        _authorLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _authorLabel.font = FontR(10);
        _authorLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _authorLabel;
}

- (UILabel *)introductionLabel
{
    if (!_introductionLabel) {
        _introductionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.authorLabel.left, self.authorLabel.bottom + UIValue(3), SCR_WIDTH - UIValue(32), UIValue(11))];
        _introductionLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _introductionLabel.font = FontR(10);
        _introductionLabel.textAlignment = NSTextAlignmentLeft;
        _introductionLabel.numberOfLines = 0;
    }
    return _introductionLabel;
}

+ (CGFloat)cellHeight:(NSString *)content
{
    CGFloat width = SCR_WIDTH - UIValue(32);
    CGFloat height = UIValue(10) + UIValue(11) + UIValue(5);
    CGFloat introductionLabelH = UIValue(11);
    if (content && ![content isEqualToString:@""]) {
        introductionLabelH = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName : FontR(10)} context:nil].size.height;
    }
    height = height + introductionLabelH + UIValue(5);
    return height;
}

@end
