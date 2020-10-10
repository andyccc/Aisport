//
//  SearchCollectionViewCell.m
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import "SearchCollectionViewCell.h"

@implementation SearchCollectionViewCell
{
    NSDictionary *listData;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = [listData[@"nameWidth"] floatValue] + UIValue(10);
    self.bgView.width = width;
    self.contentLabel.width = width;
}

- (void)fillData:(NSDictionary *)data
{
    listData = data;
    self.contentLabel.text = data[@"content"];
}

- (UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, UIValue(30))];
        _bgView.backgroundColor = [UIColor colorWithHex:@"#f4f5f7"];
        _bgView.layer.cornerRadius = UIValue(15);
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, self.bgView.height)];
        _contentLabel.textColor = [UIColor colorWithHex:@"#666666"];
        _contentLabel.font = FontR(13);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

@end
