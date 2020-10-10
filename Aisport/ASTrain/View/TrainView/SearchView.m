//
//  SearchView.m
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import "SearchView.h"
#define VIEW_HEIGHT UIValue(50)

@interface SearchView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.cancelBtn];

        [self addSubview:self.bgView];
        [self.bgView addSubview:self.searchIcon];
        [self.bgView addSubview:self.textField];
        
        self.cancelBtn.centerY = self.bgView.centerY;
        
    }
    return self;
}

- (void)fillData:(NSString *)text
{
    self.textField.text = text;
    [self.textField resignFirstResponder];
}

- (void)becomeFirstResponder
{
    [self.textField becomeFirstResponder];
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(UIValue(16), 0, UIValue(300), UIValue(36))];
        _bgView.frame = CGRectMake(15*2*Screen_Scale, 25*2*Screen_Scale-20+StatusHeight, UIValue(300), 33*Screen_Scale*2);
        _bgView.layer.backgroundColor = [UIColor colorWithHex:@"#F8F8F8"].CGColor;
        _bgView.layer.cornerRadius = 33.0*Screen_Scale;
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.borderWidth = 1.0f;
        _bgView.layer.borderColor = [UIColor colorWithHex:@"#f5f5f5"].CGColor;
        _bgView.centerY = VIEW_HEIGHT / 2.0;
        _bgView.left = self.cancelBtn.right;
    }
    return _bgView;
}

- (UIImageView *)searchIcon
{
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(UIValue(10), UIValue(10), UIValue(16), UIValue(16))];
        _searchIcon.image = [UIImage imageNamed:@"icon_search"];
        _searchIcon.centerY = self.bgView.height / 2.0;

    }
    return _searchIcon;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.searchIcon.right + UIValue(10), self.searchIcon.top, UIValue(260), UIValue(16))];
        _textField.placeholder = @"搜索视频、作者...";
        _textField.centerY = self.bgView.height / 2.0;
        _textField.textColor = [UIColor blackColor];
        _textField.tintColor = [UIColor colorWithHex:@"#ffd300"];
        _textField.font = FontR(15);
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索视频、作者..." attributes:
                                          @{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#999999"],
                                            NSFontAttributeName:_textField.font
                                            }];

        _textField.attributedPlaceholder = attrString;
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
    }
    return _textField;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.bgView.top, UIValue(53), UIValue(42))];
//        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
//        _cancelBtn.titleLabel.font = FontR(17);
//        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.textFieldStartBlcok) {
        self.textFieldStartBlcok(SEARCHER_START_STATE);
    }
}

- (void)textDidChange:(UITextField *)textField
{
    NSString *textStr = self.textField.text;
    if (self.textFieldChangeBlock)
    {
        self.textFieldChangeBlock(textStr,SEARCHER_CONTENT_CHANGE_STATE);
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.textFieldClearBlock) {
        self.textFieldClearBlock(SEARCHER_CLEAR_STATE);
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    NSString *textStr = self.textField.text;
    if (self.textFieldSearchBlock) {
        self.textFieldSearchBlock(textStr,SEARCHER_RETURN_STATE);
    }
    return YES;
}

- (void)cancelBtnAction:(UIButton *)button
{
    [self.textField resignFirstResponder];
    if (self.cancelActionBlock) {
        self.cancelActionBlock(SEARCHER_CANCEL_STATE);
    }
}

+ (CGFloat)viewHeight
{
    return VIEW_HEIGHT;
}

@end
