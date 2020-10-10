//
//  TitleSwitchView.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "TitleSwitchView.h"

@implementation TitleSwitchView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.switcher = [[UISwitch alloc] init];
        self.switcher.width = UIValue(200);
        self.switcher.height = UIValue(64);
        self.switcher.right = self.width - uiv(10);
        self.switcher.centerY = self.height / 2.0;
        [self addSubview:self.switcher];
        
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    self.titleLabel.width = uiv(100);
}
@end
