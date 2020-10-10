//
//  SelectedModelView.m
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import "SelectedModelView.h"

@interface SelectedModelView ()

@property (nonatomic, strong) UIButton *mobileBtn;
@property (nonatomic, strong) UILabel *selmobileTiLab;

@property (nonatomic, strong) UIButton *tvBtn;
@property (nonatomic, strong) UILabel *selTVTiLab;

@end

@implementation SelectedModelView

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
    backButton.frame = CGRectMake(22, StatusHeight + 7, 18, 32);
//    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(22);
//        make.top.equalTo(self.mas_top).offset(StatusHeight + 7);
//        make.width.mas_equalTo(18);
//        make.height.mas_equalTo(32);
//
//    }];
    [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    //WithFrame:CGRectMake(SCR_WIDTH/2-100, StatusHeight+43, 200, 18)
    UILabel *selModelTiLab = [[UILabel alloc] init];
    [self addSubview:selModelTiLab];
    selModelTiLab.frame = CGRectMake(SCR_WIDTH/2-100, StatusHeight+43, 200, 18);
//    [selModelTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(22);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(18);
//    }];
    selModelTiLab.textAlignment = NSTextAlignmentCenter;
    selModelTiLab.font = fontBold(18);
    selModelTiLab.textColor = [UIColor whiteColor];
    selModelTiLab.text = @"选择模式";
    
    //WithFrame:CGRectMake(SCR_WIDTH/2-251.0/2, selModelTiLab.bottom+38*2*Screen_Scale_height, 251, 151)
    UIButton *mobileBtn = [[UIButton alloc] init];
    [self addSubview:mobileBtn];
    mobileBtn.frame = CGRectMake(SCR_WIDTH/2-251.0/2, selModelTiLab.bottom+38*2*Screen_Scale_height, 251, 151);
//    [mobileBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-(SCR_max-251*2-26*2*Screen_Scale)/2 );
//        make.top.equalTo(self.mas_top).offset(92);
//        make.width.mas_equalTo(251);
//        make.height.mas_equalTo(151);
//    }];
    [mobileBtn setImage:[UIImage imageNamed:@"train_mobile"] forState:UIControlStateNormal];
    [mobileBtn addTarget:self action:@selector(selectedMobileModel:) forControlEvents:UIControlEventTouchUpInside];
//    mobileBtn.layer.borderWidth = 2;
//    mobileBtn.layer.borderColor = [[UIColor colorWithHex:@"#1BC2B1"] CGColor];
    mobileBtn.layer.cornerRadius = 8;
    _mobileBtn = mobileBtn;
    
    //WithFrame:CGRectMake(mobileBtn.left, mobileBtn.bottom+14, 200, 12)
    UILabel *selmobileTiLab = [[UILabel alloc] init];
    [self addSubview:selmobileTiLab];
    selmobileTiLab.frame = CGRectMake(mobileBtn.left, mobileBtn.bottom+14, 200, 12);
    [selmobileTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mobileBtn.mas_left).offset(0);
        make.bottom.equalTo(mobileBtn.mas_bottom).offset(14);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(12);
    }];
    selmobileTiLab.font = fontBold(12);
    selmobileTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    selmobileTiLab.text = @"对着手机玩";
    _selmobileTiLab = selmobileTiLab;
    
    //WithFrame:CGRectMake(SCR_WIDTH/2-251.0/2, mobileBtn.bottom+70*2*Screen_Scale_height, 251, 151)
    UIButton *tvBtn = [[UIButton alloc] init];
    [self addSubview:tvBtn];
    tvBtn.frame = CGRectMake(SCR_WIDTH/2-251.0/2, mobileBtn.bottom+70*2*Screen_Scale_height, 251, 151);
//    [tvBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset((SCR_max-251*2-26*2*Screen_Scale)/2);
//        make.top.equalTo(self.mas_top).offset(92);
//        make.width.mas_equalTo(251);
//        make.height.mas_equalTo(151);
//    }];
    [tvBtn setImage:[UIImage imageNamed:@"train_TV"] forState:UIControlStateNormal];
    [tvBtn addTarget:self action:@selector(selectedTVModel:) forControlEvents:UIControlEventTouchUpInside];
    tvBtn.layer.borderWidth = 2;
    tvBtn.layer.borderColor = [[UIColor colorWithHex:@"#1BC2B1"] CGColor];
    tvBtn.layer.cornerRadius = 8;
    tvBtn.selected = YES;
    _tvBtn = tvBtn;
    
    //WithFrame:CGRectMake(tvBtn.left, tvBtn.bottom+14, 200, 12)
    UILabel *selTVTiLab = [[UILabel alloc] init];
    [self addSubview:selTVTiLab];
    selTVTiLab.frame = CGRectMake(tvBtn.left, tvBtn.bottom+14, 200, 12);
//    [selTVTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(tvBtn.mas_left).offset(0);
//        make.bottom.equalTo(tvBtn.mas_bottom).offset(14);
//        make.width.mas_equalTo(200);
//        make.height.mas_equalTo(12);
//    }];
    selTVTiLab.font = fontBold(12);
    selTVTiLab.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    selTVTiLab.text = @"投屏到电视上玩";
    _selTVTiLab = selTVTiLab;
    
    
    //WithFrame:CGRectMake(SCR_WIDTH/2-263.0/2, SCR_HIGHT-60-37, 263, 37)
    UIButton *okButton = [[UIButton alloc] init];
    [self addSubview:okButton];
    okButton.frame = CGRectMake(SCR_WIDTH/2-263.0/2, SCR_HIGHT-60-37, 263, 37);
//    [okButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottom).offset(-35);
//        make.centerX.mas_equalTo(self.mas_centerX);
//        make.width.mas_equalTo(263);
//        make.height.mas_equalTo(45);
//    }];
    [okButton setTitle:@"下一步" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
    okButton.titleLabel.font = fontBold(17);
    okButton.layer.cornerRadius = 45.0/2;
    okButton.clipsToBounds = YES;
    [okButton addTarget:self action:@selector(clickOKButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


#pragma mark - Button
- (void)backButtonClick
{
    if (self.backSelectedBlock) {
        self.backSelectedBlock();
    }
}


- (void)selectedMobileModel:(UIButton *)sender
{
    _mobileBtn.selected = YES;
    _tvBtn.selected = NO;

    _selmobileTiLab.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    _selTVTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];

    _mobileBtn.layer.borderWidth = 2;
    _mobileBtn.layer.borderColor = [[UIColor colorWithHex:@"#1BC2B1"] CGColor];

    _tvBtn.layer.borderWidth = 0;
    _tvBtn.layer.borderColor = [[UIColor clearColor] CGColor];
}

- (void)selectedTVModel:(UIButton *)sender
{
    _mobileBtn.selected = NO;
    _tvBtn.selected = YES;
    
    _selmobileTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    _selTVTiLab.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    
    _mobileBtn.layer.borderWidth = 0;
    _mobileBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    
    _tvBtn.layer.borderWidth = 2;
    _tvBtn.layer.borderColor = [[UIColor colorWithHex:@"#1BC2B1"] CGColor];
}

- (void)clickOKButton:(UIButton *)sender
{
    if (self.clickOKModelBlock) {
        self.clickOKModelBlock(_tvBtn.selected);
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
