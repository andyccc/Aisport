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
- (instancetype)init
{
    if (self = [super init]) {
        [self setMainView];
    }
    return self;
}

- (void)setMainView
{
    UIButton *backButton = [[UIButton alloc] init];
    [self addSubview:backButton];
    backButton.frame = CGRectMake(22, StatusHeight + 7, 32, 32);
//    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(22);
//        make.top.equalTo(self.mas_top).offset(StatusHeight + 7);
//        make.width.mas_equalTo(18);
//        make.height.mas_equalTo(32);
//
//    }];
    [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //WithFrame:CGRectMake(SCR_WIDTH/2-250/2, StatusHeight+19, 250, 24)
    UILabel *titleLabel = [[UILabel alloc] init];
    [self addSubview:titleLabel];
    titleLabel.frame = CGRectMake(SCR_WIDTH/2-250/2, StatusHeight+19, 250, 24);
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(22);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(20);
//    }];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = fontBold(20);
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"投屏后进入训练";
    
    //WithFrame:CGRectMake(SCR_WIDTH/2-250/2, titleLabel.bottom+11, 250, 12)
    UILabel *subTiLabel = [[UILabel alloc] init];
    [self addSubview:subTiLabel];
    subTiLabel.frame = CGRectMake(SCR_WIDTH/2-250/2, titleLabel.bottom+11, 250, 12);
//    [subTiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLabel.mas_bottom).offset(8);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(12);
//    }];
    subTiLabel.textAlignment = NSTextAlignmentCenter;
    subTiLabel.font = fontApp(12);
    subTiLabel.textColor = [UIColor whiteColor];
    subTiLabel.text = @"请按照引导步骤进行投屏";

    //第一步
    //WithFrame:CGRectMake(SCR_WIDTH/2-141.0/2, oneLab.bottom+6, 141, 141)
    UIImageView *wifiBtn = [[UIImageView alloc] init];
    [self addSubview:wifiBtn];
//    [wifiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(53*2*Screen_Scale);
//        make.top.equalTo(self.mas_top).offset(90);
//        make.width.mas_equalTo(143);
//        make.height.mas_equalTo(143);
//    }];
    wifiBtn.image = [UIImage imageNamed:@"train_selWifi"];
//    [wifiBtn setImage:[UIImage imageNamed:@"train_selWifi"] forState:UIControlStateNormal];
//    wifiBtn.userInteractionEnabled = NO;
    
    //WithFrame:CGRectMake(29, subTiLabel.bottom+28, 56, 22)
    UILabel *oneLab = [[UILabel alloc] init];
    [self addSubview:oneLab];
    oneLab.frame = CGRectMake(29, subTiLabel.bottom+28, 56, 22);
//    [oneLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(wifiBtn.mas_centerX);
//        make.top.equalTo(wifiBtn.mas_bottom).offset(10);
//        make.width.mas_equalTo(56);
//        make.height.mas_equalTo(22);
//    }];
    oneLab.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    oneLab.font = fontBold(12);
    oneLab.textAlignment = NSTextAlignmentCenter;
    oneLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    oneLab.text = @"第一步";
    oneLab.layer.cornerRadius = 11;
    oneLab.clipsToBounds = YES;
    
    wifiBtn.frame = CGRectMake(SCR_WIDTH/2-141.0/2, oneLab.bottom+6, 141, 141);
    
    //WithFrame:CGRectMake(oneLab.right+7, oneLab.top, SCR_WIDTH-oneLab.left-7, 22)
    UILabel *wifiTiLab = [[UILabel alloc] init];
    [self addSubview:wifiTiLab];
    wifiTiLab.frame = CGRectMake(oneLab.right+7, oneLab.top, SCR_WIDTH-oneLab.left-7, 22);
//    [wifiTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(wifiBtn.mas_centerX);
//        make.top.equalTo(oneLab.mas_bottom).offset(10);
//        make.width.mas_equalTo(149);
//        make.height.mas_equalTo(29);
//    }];
    wifiTiLab.font = fontBold(12);
    wifiTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    wifiTiLab.numberOfLines = 0;
//    wifiTiLab.textAlignment = NSTextAlignmentCenter;
    wifiTiLab.text = @"打开智能电视/盒子，并和手机连接同一WIFI";
    


    
    //第二步
    //WithFrame:CGRectMake(SCR_WIDTH/2-141.0/2, twoLab.bottom+6, 141, 141
    UIImageView *mirrorBtn = [[UIImageView alloc] init];
    [self addSubview:mirrorBtn];
//    [mirrorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.top.equalTo(self.mas_top).offset(90);
//        make.width.mas_equalTo(143);
//        make.height.mas_equalTo(143);
//    }];
    mirrorBtn.image = [UIImage imageNamed:@"train_mirrorImage"];
//    [mirrorBtn setImage:[UIImage imageNamed:@"train_mirrorImage"] forState:UIControlStateNormal];
//    mirrorBtn.userInteractionEnabled = NO;
    
    //WithFrame:CGRectMake(29, wifiBtn.bottom+9, 56, 22)
    UILabel *twoLab = [[UILabel alloc] init];
    [self addSubview:twoLab];
    twoLab.frame = CGRectMake(29, wifiBtn.bottom+9, 56, 22);
//    [twoLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(mirrorBtn.mas_centerX);
//        make.top.equalTo(mirrorBtn.mas_bottom).offset(10);
//        make.width.mas_equalTo(56);
//        make.height.mas_equalTo(22);
//    }];
    twoLab.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    twoLab.font = fontBold(12);
    twoLab.textAlignment = NSTextAlignmentCenter;
    twoLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    twoLab.text = @"第二步";
    twoLab.layer.cornerRadius = 11;
    twoLab.clipsToBounds = YES;
    
    mirrorBtn.frame = CGRectMake(SCR_WIDTH/2-141.0/2, twoLab.bottom+6, 141, 141);
    
    //WithFrame:CGRectMake(twoLab.right+7, twoLab.top, SCR_WIDTH-twoLab.left-7, 22)
    UILabel *mirrorTiLab = [[UILabel alloc] init];
    [self addSubview:mirrorTiLab];
    mirrorTiLab.frame = CGRectMake(twoLab.right+7, twoLab.top, SCR_WIDTH-twoLab.left-7, 22);
//    [mirrorTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(mirrorBtn.mas_centerX);
//        make.top.equalTo(twoLab.mas_bottom).offset(10);
//        make.width.mas_equalTo(149);
//        make.height.mas_equalTo(29);
//    }];
    mirrorTiLab.font = fontBold(12);
    mirrorTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    mirrorTiLab.numberOfLines = 0;
//    mirrorTiLab.textAlignment = NSTextAlignmentCenter;
    mirrorTiLab.text = @"选择要投屏的电视/盒子，完成投屏";
    
    
    
    //第三步
    //WithFrame:CGRectMake(SCR_WIDTH/2-141.0/2, threeLab.bottom+6, 141, 141)
    UIImageView *selecedTVBtn = [[UIImageView alloc] init];
    [self addSubview:selecedTVBtn];
//    [selecedTVBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-53*2*Screen_Scale);
//        make.top.equalTo(self.mas_top).offset(90);
//        make.width.mas_equalTo(143);
//        make.height.mas_equalTo(143);
//    }];
    selecedTVBtn.image = [UIImage imageNamed:@"train_selecedTV"];
//    [selecedTVBtn setImage:[UIImage imageNamed:@"train_selecedTV"] forState:UIControlStateNormal];
//    selecedTVBtn.userInteractionEnabled = NO;
    
    //WithFrame:CGRectMake(29, mirrorBtn.bottom+28, 56, 22)
    UILabel *threeLab = [[UILabel alloc] init];
    [self addSubview:threeLab];
    threeLab.frame = CGRectMake(29, mirrorBtn.bottom+28, 56, 22);
//    [threeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(selecedTVBtn.mas_centerX);
//        make.top.equalTo(selecedTVBtn.mas_bottom).offset(10);
//        make.width.mas_equalTo(56);
//        make.height.mas_equalTo(22);
//    }];
    threeLab.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    threeLab.font = fontBold(12);
    threeLab.textAlignment = NSTextAlignmentCenter;
    threeLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    threeLab.text = @"第三步";
    threeLab.layer.cornerRadius = 11;
    threeLab.clipsToBounds = YES;
    
    selecedTVBtn.frame = CGRectMake(SCR_WIDTH/2-141.0/2, threeLab.bottom+6, 141, 141);
    
    //WithFrame:CGRectMake(threeLab.right+7, threeLab.top, SCR_WIDTH-threeLab.left-7, 22)
    UILabel *selecedTVTiLab = [[UILabel alloc] init];
    [self addSubview:selecedTVTiLab];
    selecedTVTiLab.frame = CGRectMake(threeLab.right+7, threeLab.top, SCR_WIDTH-threeLab.left-7, 22);
//    [selecedTVTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(selecedTVBtn.mas_centerX);
//        make.top.equalTo(threeLab.mas_bottom).offset(10);
//        make.width.mas_equalTo(149);
//        make.height.mas_equalTo(29);
//    }];
    selecedTVTiLab.font = fontBold(12);
    selecedTVTiLab.numberOfLines = 0;
    selecedTVTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
//    selecedTVTiLab.textAlignment = NSTextAlignmentCenter;
    selecedTVTiLab.text = @"打开智能电视/盒子，并和手机连接同一WIFI";
    
    
    UIButton *okButton = [[UIButton alloc] init];
    [self addSubview:okButton];
    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-35);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(263);
        make.height.mas_equalTo(45);
    }];
    [okButton setTitle:@"下一步" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
    okButton.titleLabel.font = fontBold(17);
    okButton.layer.cornerRadius = 45.0/2;
    okButton.clipsToBounds = YES;
    [okButton addTarget:self action:@selector(clickOKButton:) forControlEvents:UIControlEventTouchUpInside];
    okButton.hidden = YES;

}


#pragma mark - Button
- (void)backButtonClick
{
    if (self.backGuideTVBlock) {
        self.backGuideTVBlock();
    }
}

- (void)clickOKButton:(UIButton *)sender
{
    if (self.nextGuideTVBlock) {
        self.nextGuideTVBlock();
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
