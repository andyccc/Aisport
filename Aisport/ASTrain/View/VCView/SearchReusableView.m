//
//  SearchReusableView.m
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import "SearchReusableView.h"

#define VIEW_HEIGHT UIValue(44)

@implementation SearchReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.titleLabel];
        [self addSubview:self.clearButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.centerY = VIEW_HEIGHT / 2.0;
    self.clearButton.centerY = VIEW_HEIGHT / 2.0;
}

- (void)fillData:(NSString *)content isClear:(BOOL)isClear
{
    self.titleLabel.text = content;
    self.clearButton.hidden = !isClear;
}

- (void)clearButtonClick:(UIButton *)button
{
    if (self.clearSearchHistory)
    {
        self.clearSearchHistory();
    }
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIValue(16), 0, UIValue(150), UIValue(30))];
        _titleLabel.textColor = [UIColor colorWithHex:@"#666666"];
        _titleLabel.font = FontBoldR(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIButton *)clearButton
{
    if (!_clearButton)
    {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _clearButton.frame = CGRectMake(0, 0, UIValue(43), UIValue(30));
        _clearButton.right = UIScreenWidth - UIValue(16);
        [_clearButton setTitle:@"清空" forState:UIControlStateNormal];
        _clearButton.titleLabel.font = FontBoldR(16);
        [_clearButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

+ (CGFloat)viewHeight
{
    return VIEW_HEIGHT;
}


@end
