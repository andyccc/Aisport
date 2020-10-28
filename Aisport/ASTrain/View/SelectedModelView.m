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

- (void)setMainView
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(22, StatusHeight + 7, 18, 32);
    [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backButton];
    
    UILabel *selModelTiLab = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-100, StatusHeight+43, 200, 18)];
    [self addSubview:selModelTiLab];
    selModelTiLab.textAlignment = NSTextAlignmentCenter;
    selModelTiLab.font = fontBold(18);
    selModelTiLab.textColor = [UIColor whiteColor];
    selModelTiLab.text = @"选择模式";
    
    UIButton *mobileBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-251.0/2, selModelTiLab.bottom+38*2*Screen_Scale_height, 251, 151)];
    [self addSubview:mobileBtn];
    [mobileBtn setImage:[UIImage imageNamed:@"train_mobile"] forState:UIControlStateNormal];
    [mobileBtn addTarget:self action:@selector(selectedMobileModel:) forControlEvents:UIControlEventTouchUpInside];
    mobileBtn.layer.borderWidth = 2;
    mobileBtn.layer.borderColor = [[UIColor colorWithHex:@"#1BC2B1"] CGColor];
    mobileBtn.layer.cornerRadius = 8;
    _mobileBtn = mobileBtn;
    
    UILabel *selmobileTiLab = [[UILabel alloc] initWithFrame:CGRectMake(mobileBtn.left, mobileBtn.bottom+14, 200, 12)];
    [self addSubview:selmobileTiLab];
    selmobileTiLab.font = fontBold(12);
    selmobileTiLab.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    selmobileTiLab.text = @"对着手机玩";
    _selmobileTiLab = selmobileTiLab;
    
    
    UIButton *tvBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-251.0/2, mobileBtn.bottom+70*2*Screen_Scale_height, 251, 151)];
    [self addSubview:tvBtn];
    [tvBtn setImage:[UIImage imageNamed:@"train_TV"] forState:UIControlStateNormal];
    [tvBtn addTarget:self action:@selector(selectedTVModel:) forControlEvents:UIControlEventTouchUpInside];
    tvBtn.layer.cornerRadius = 8;
    _tvBtn = tvBtn;
    
    UILabel *selTVTiLab = [[UILabel alloc] initWithFrame:CGRectMake(tvBtn.left, tvBtn.bottom+14, 200, 12)];
    [self addSubview:selTVTiLab];
    selTVTiLab.font = fontBold(12);
    selTVTiLab.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    selTVTiLab.text = @"投屏到电视上玩";
    _selTVTiLab = selTVTiLab;
    
    
    UIButton *okButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-263.0/2, SCR_HIGHT-60-37, 263, 37)];
    [self addSubview:okButton];
    [okButton setTitle:@"我选好了" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
    okButton.titleLabel.font = fontBold(18);
    okButton.layer.cornerRadius = 37.0/2;
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
