//
//  TitleFieldView.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "TitleFieldView.h"

@interface TitleFieldView () <UITextFieldDelegate>

@end

@implementation TitleFieldView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.textField = [[UITextField alloc] init];
        self.textField.width = self.width - self.titleLabel.right - self.titleLabel.left * 2;
        self.textField.height = self.height;
        self.textField.left = self.titleLabel.right;
        self.textField.font = FontR(14);
        self.textField.textColor = [UIColor colorWithHex:@"#333333"];
        
        self.textField.clearButtonMode = UITextFieldViewModeAlways;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.delegate = self;
        
        [self addSubview:self.textField];
        
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    if (!placeholder) {
        self.textField.attributedPlaceholder = nil;
        return;
    }
    
    id attributes = @{
                      NSFontAttributeName: FontR(14),
                      NSForegroundColorAttributeName: [UIColor colorWithHex:@"#C7C7C7"],
                      };
    NSMutableAttributedString *attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:attributes];
    self.textField.attributedPlaceholder = attributedPlaceholder;
}

- (void)setText:(NSString *)Text
{
    self.textField.text = Text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

@end
