//
//  TitleItemlView.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "TitleItemlView.h"

@implementation TitleItemlView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.width = UIValue(78);
        self.titleLabel.height = self.height;
        self.titleLabel.font = FontR(15);
        self.titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        self.titleLabel.left = uiv(18);
        [self addSubview:self.titleLabel];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.width = self.width - UIValue(39 + 28);
        self.lineView.height = 0.5;
        self.lineView.left = uiv(39);
        self.lineView.bottom = self.height;
        self.lineView.backgroundColor = [UIColor colorWithHex:@"#F0F0F0"];
        [self addSubview:self.lineView];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
