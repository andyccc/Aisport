//
//  GuideTVView.m
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import "GuideTVView.h"

@implementation GuideTVView

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
    backButton.frame = CGRectMake(22, StatusHeight + 7, 32, 32);
    [backButton setImage:[UIImage imageNamed:@"train_cancle"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-250/2, StatusHeight+19, 250, 24)];
    [self addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = fontBold(24);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"投屏后进入训练";
    
    UILabel *subTiLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-250/2, titleLabel.bottom+11, 250, 12)];
    [self addSubview:subTiLabel];
    subTiLabel.textAlignment = NSTextAlignmentCenter;
    subTiLabel.font = fontBold(12);
    subTiLabel.textColor = [UIColor whiteColor];
    subTiLabel.text = @"请按照引导步骤进行投屏";

    //第一步
    UILabel *oneLab = [[UILabel alloc] initWithFrame:CGRectMake(29, subTiLabel.bottom+28, 56, 22)];
    [self addSubview:oneLab];
    oneLab.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    oneLab.font = fontBold(12);
    oneLab.textAlignment = NSTextAlignmentCenter;
    oneLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    oneLab.text = @"第一步";
    oneLab.layer.cornerRadius = 11;
    oneLab.clipsToBounds = YES;
    
    UILabel *wifiTiLab = [[UILabel alloc] initWithFrame:CGRectMake(oneLab.right+7, oneLab.top, SCR_WIDTH-oneLab.left-7, 22)];
    [self addSubview:wifiTiLab];
    wifiTiLab.font = fontBold(12);
    wifiTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    wifiTiLab.text = @"打开智能电视/盒子，并和手机连接同一WIFI";
    
    UIButton *wifiBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-141.0/2, oneLab.bottom+6, 141, 141)];
    [self addSubview:wifiBtn];
    [wifiBtn setImage:[UIImage imageNamed:@"train_selWifi"] forState:UIControlStateNormal];
    wifiBtn.userInteractionEnabled = NO;


    
    //第二步
    UILabel *twoLab = [[UILabel alloc] initWithFrame:CGRectMake(29, wifiBtn.bottom+9, 56, 22)];
    [self addSubview:twoLab];
    twoLab.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    twoLab.font = fontBold(12);
    twoLab.textAlignment = NSTextAlignmentCenter;
    twoLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    twoLab.text = @"第二步";
    twoLab.layer.cornerRadius = 11;
    twoLab.clipsToBounds = YES;
    
    UILabel *mirrorTiLab = [[UILabel alloc] initWithFrame:CGRectMake(twoLab.right+7, twoLab.top, SCR_WIDTH-twoLab.left-7, 22)];
    [self addSubview:mirrorTiLab];
    mirrorTiLab.font = fontBold(12);
    mirrorTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    mirrorTiLab.text = @"选择要投屏的电视/盒子，完成投屏";
    
    UIButton *mirrorBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-141.0/2, twoLab.bottom+6, 141, 141)];
    [self addSubview:mirrorBtn];
    [mirrorBtn setImage:[UIImage imageNamed:@"train_mirrorImage"] forState:UIControlStateNormal];
    mirrorBtn.userInteractionEnabled = NO;
    
    //第三步
    UILabel *threeLab = [[UILabel alloc] initWithFrame:CGRectMake(29, mirrorBtn.bottom+28, 56, 22)];
    [self addSubview:threeLab];
    threeLab.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    threeLab.font = fontBold(12);
    threeLab.textAlignment = NSTextAlignmentCenter;
    threeLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    threeLab.text = @"第三步";
    threeLab.layer.cornerRadius = 11;
    threeLab.clipsToBounds = YES;
    
    UILabel *selecedTVTiLab = [[UILabel alloc] initWithFrame:CGRectMake(threeLab.right+7, threeLab.top, SCR_WIDTH-threeLab.left-7, 22)];
    [self addSubview:selecedTVTiLab];
    selecedTVTiLab.font = fontBold(12);
    selecedTVTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    selecedTVTiLab.text = @"打开智能电视/盒子，并和手机连接同一WIFI";
    
    UIButton *selecedTVBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-141.0/2, threeLab.bottom+6, 141, 141)];
    [self addSubview:selecedTVBtn];
    [selecedTVBtn setImage:[UIImage imageNamed:@"train_selecedTV"] forState:UIControlStateNormal];
    selecedTVBtn.userInteractionEnabled = NO;
    
    
}


#pragma mark - Button
- (void)backButtonClick
{
    if (self.backGuideTVBlock) {
        self.backGuideTVBlock();
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
