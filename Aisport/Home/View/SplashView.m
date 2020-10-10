//
//  SplashView.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "SplashView.h"
#import "HomeBannerView.h"

@interface SplashView ()

@property (nonatomic, strong) HomeBannerView *bannerView;
@property (nonatomic, strong) UIButton *okBtn;

@end


@implementation SplashView

- (id)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)]) {
        
        [self initSelf];
    }
    
    return self;
}

+ (void)show
{
    BOOL isInstall = [[NSUserDefaults standardUserDefaults] boolForKey:@"is_install"];
    if (isInstall) {
        return;
    }
    
    
    SplashView *view = [[SplashView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] addSubview:view];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)initSelf
{
    self.backgroundColor = [UIColor whiteColor];

    _bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT - SafeAreaBottomHeight - UIValue(15))];
    [self addSubview:_bannerView];
    NSArray *images = @[
        @{
            @"image" : @"pic_guide_1"
        },
        @{
            @"image" : @"pic_guide_2"
        },
        @{
            @"image" : @"pic_guide_3"
        },
    ];
    _bannerView.carousel.isAuto = NO;
    _bannerView.carousel.endless = NO;
    _bannerView.carousel.flowLayout.itemSpace_H = 0;
    _bannerView.carousel.pageControl.bottom = _bannerView.height - UIValue(80);
    
    
    _bannerView.carousel.pageControl.pageIndicatorTintColor = [UIColor colorWithHex:@"#D3D3D3"];
    _bannerView.carousel.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHex:@"#ADADAD"];
    [_bannerView fillData:images];

    _okBtn = [[UIButton alloc] init];
    _okBtn.width = uiv(306);
    _okBtn.height = uiv(44);
    _okBtn.centerX = SCR_WIDTH / 2;
    
    _okBtn.bottom = SCR_HIGHT - UIValue(54);
    
    _okBtn.backgroundColor = [UIColor colorWithHex:@"#FBB313"];
    _okBtn.layer.cornerRadius = _okBtn.height/2.0;
    _okBtn.layer.masksToBounds = YES;
    [_okBtn setTitle:@"立即开始" forState:UIControlStateNormal];
    [_okBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_okBtn];

}

- (void)subAction
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"is_install"];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismiss];
    }];
    
}

@end
