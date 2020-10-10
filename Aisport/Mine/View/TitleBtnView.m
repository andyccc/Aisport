//
//  TitleBtnView.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "TitleBtnView.h"

@implementation TitleBtnView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textField = [[UILabel alloc] init];
        self.textField.width = self.width - self.titleLabel.right - self.titleLabel.left;
        self.textField.height = self.height;
        self.textField.left = self.titleLabel.right;
        self.textField.font = FontR(14);
        self.textField.textColor = [UIColor colorWithHex:@"#333333"];
        [self addSubview:self.textField];
        
        self.placeholderLabel = [[UILabel alloc] init];
        self.placeholderLabel.width = UIValue(60);
        self.placeholderLabel.height = self.height;
        self.placeholderLabel.left = self.titleLabel.right;
        self.placeholderLabel.textColor = [UIColor colorWithHex:@"#C7C7C7"];
        self.placeholderLabel.font = FontR(14);
        [self addSubview:self.placeholderLabel];
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.width = uiv(6);
        self.iconView.height = uiv(11);
        self.iconView.image = [UIImage imageNamed:@"icon_arrow_gray"];
        self.iconView.left = self.placeholderLabel.right + UIValue(10);
        self.iconView.centerY = self.height / 2.0;
        [self addSubview:self.iconView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnAction)];
        [self addGestureRecognizer:tap];
        
        self.placeholderLabel.hidden = YES;
        self.iconView.hidden = YES;

    }
    return self;
}

- (void)btnAction
{
    !self.btnBlock ?: self.btnBlock();
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (!placeholder) {
        self.placeholderLabel.hidden = YES;
        self.iconView.hidden = YES;
        return;
    }
    self.iconView.hidden = NO;
    self.placeholderLabel.hidden = NO;
    self.placeholderLabel.text = placeholder;
    
}

- (void)setText:(NSString *)text
{
    self.textField.text = text;
    
    BOOL hidePlaceholder = [text length] > 0;
    self.placeholderLabel.hidden = hidePlaceholder;
    self.iconView.hidden = hidePlaceholder;
}

- (void)setSelected:(BOOL)flag
{
    self.markView.hidden = !flag;
}

- (UIImageView *)markView
{
    if (!_markView) {
        _markView = [[UIImageView alloc] init];
        _markView.width = uiv(20);
        _markView.height = uiv(14);
        _markView.image = [UIImage imageNamed:@"icon_selected_yes"];
        [self addSubview:_markView];
        _markView.right = self.width - UIValue(27);
        _markView.centerY = self.height / 2.0;
        _markView.hidden = YES;
    }
    return _markView;
}

@end
