//
//  PlaceMobileView.m
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import "PlaceMobileView.h"

@implementation PlaceMobileView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setMainView];
    }
    return self;
}

- (void)setMainView
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(22, StatusHeight + 7, 18, 32);
    [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-100, StatusHeight+50, 200, 18)];
    [self addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = fontBold(18);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"放置手机";
    
    UIButton *placeBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-305.0/2, titleLabel.bottom+127*2*Screen_Scale, 305, 197)];
    [self addSubview:placeBtn];
    [placeBtn setImage:[UIImage imageNamed:@"train_placeMobile"] forState:UIControlStateNormal];
    placeBtn.userInteractionEnabled = NO;
    
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-263.0/2, SCR_HIGHT-63-37, 263, 37)];
    [self addSubview:okButton];
    [okButton setTitle:@"我放好了手机" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
    okButton.titleLabel.font = fontBold(18);
    okButton.layer.cornerRadius = 37.0/2;
    okButton.clipsToBounds = YES;
    [okButton addTarget:self action:@selector(clickPlaceOKButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark - Button
- (void)backButtonClick
{
    if (self.backPlaceMobileBlock) {
        self.backPlaceMobileBlock();
    }
}


- (void)clickPlaceOKButton:(UIButton *)sender
{
    if (self.clickPlaceOKlBlock) {
        self.clickPlaceOKlBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
