//
//  ASTrainReportController.m
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import "ASTrainReportController.h"
//#import "UIImage+blurred.h"
#import "UIImageView+LBBlurredImage.h"
#import "SDRotationLoopProgressView.h"
#import "ReportprogressView.h"
#import "TrainEndView.h"
#import "ASTrainNetwork.h"

@interface ASTrainReportController ()

@property (nonatomic, strong) TrainEndView *trainEndView;

@end

@implementation ASTrainReportController

- (TrainEndView *)trainEndView
{
    if (!_trainEndView) {
        _trainEndView = [[TrainEndView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _trainEndView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.6];
        WS(weakSelf);
        _trainEndView.clicSureBtnBlock = ^{
            [weakSelf removeTrainEndView];
        };
    }
    
    return _trainEndView;;
}

- (void)removeTrainEndView
{
    for (UIView *view in self.trainEndView.subviews) {
        [view removeFromSuperview];
    }
    
    [_trainEndView removeFromSuperview];
    _trainEndView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMainView];
    
    [self.view addSubview:self.trainEndView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setMainView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -StatusHeight, SCR_WIDTH, SCR_HIGHT+StatusHeight)];
    [self.view addSubview:scrollView];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 291+17)];
    [scrollView addSubview:backImageView];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    backImageView.clipsToBounds = YES;
    
    // 20 左右 R  模糊图片
    [backImageView setImageToBlur:[UIImage imageNamed:@"home_sportBanner"] blurRadius:5 completionBlock:nil];
//    [backImageView sd_setImageWithURL:[NSURL URLWithString:_userInfoModel.headImg] placeholderImage:[UIImage imageNamed:@"placeHolderImg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//
//    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 291+17)];
    [scrollView addSubview:topView];
    topView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.42];
    
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(22, StatusHeight + 7, 18, 32);
    [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backButton];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-150/2, StatusHeight + 7, 150, 30)];
    [topView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = fontBold(16);
    titleLabel.text = @"训练报告";
    
    
    SDRotationLoopProgressView *progressView = [[SDRotationLoopProgressView alloc] initWithFrame:CGRectMake(78*2*Screen_Scale, SafeAreaTopHeight+18*2*Screen_Scale, SCR_WIDTH-78*2*2*Screen_Scale, SCR_WIDTH-78*2*2*Screen_Scale)];
    [topView addSubview:progressView];
    progressView.backgroundColor = [UIColor clearColor];
    
//    [progressView addScoreAnimation];
    
    
    UILabel *scoreNumLab = [[UILabel alloc] initWithFrame:CGRectMake(88*2*Screen_Scale, progressView.top+52*2*Screen_Scale, SCR_WIDTH-88*2*2*Screen_Scale, 33)];
    [topView addSubview:scoreNumLab];
    scoreNumLab.textColor = [UIColor whiteColor];
    scoreNumLab.font = fontBold(43);
    scoreNumLab.textAlignment = NSTextAlignmentCenter;
    scoreNumLab.text = @"8047";
    
    UILabel *scoreTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(88*2*Screen_Scale, scoreNumLab.bottom+15*2*Screen_Scale, SCR_WIDTH-88*2*2*Screen_Scale, 14)];
    [topView addSubview:scoreTitleLab];
    scoreTitleLab.textColor = [UIColor whiteColor];
    scoreTitleLab.font = fontBold(14);
    scoreTitleLab.textAlignment = NSTextAlignmentCenter;
    scoreTitleLab.text = @"训练得分";
    
    
    UILabel *failTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(10*2*Screen_Scale, topView.bottom-24*2*Screen_Scale-21, SCR_WIDTH-10*2*2*Screen_Scale, 21)];
    [topView addSubview:failTitleLab];
    failTitleLab.textColor = [UIColor whiteColor];
    failTitleLab.font = fontBold(20);
    failTitleLab.textAlignment = NSTextAlignmentCenter;
    failTitleLab.text = @"击败了全国78%的用户，再接再厉";
    
    
    
    UIView *bottomBgView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.bottom-17, SCR_WIDTH, 51+115+13+88+(44+10)*3)];
    bottomBgView.backgroundColor = [UIColor clearColor];
    [scrollView addSubview:bottomBgView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, bottomBgView.height)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomBgView addSubview:bottomView];
    
    CAShapeLayer *mask=[CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bottomView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft  cornerRadii:CGSizeMake(17,17)];
    mask.path = path.CGPath;
    mask.frame = bottomView.bounds;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = path.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    //        borderLayer.strokeColor = [UIColor colorWithHex:@"#FDAB00"].CGColor;
    //        borderLayer.lineWidth = 1;
    borderLayer.frame = bottomView.bounds;
    bottomView.layer.mask = mask;
    [bottomView.layer addSublayer:borderLayer];
    
    
    
    
    UILabel *fileTiLab = [[UILabel alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, 22, SCR_WIDTH-13*2*Screen_Scale, 16)];
    [bottomView addSubview:fileTiLab];
    fileTiLab.textColor = [UIColor colorWithHex:@"#333333"];
    fileTiLab.font = fontBold(16);
    fileTiLab.textAlignment = NSTextAlignmentLeft;
    fileTiLab.text = @"运动档案";
    
    UIView *challengeView = [[UIView alloc] initWithFrame:CGRectMake(15, 51, SCR_WIDTH-30, 115)];
    [bottomView addSubview:challengeView];
    challengeView.backgroundColor = [UIColor whiteColor];
    challengeView.layer.cornerRadius = 5;
    challengeView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.14].CGColor;
    challengeView.layer.shadowOffset = CGSizeMake(0,0);
    challengeView.layer.shadowOpacity = 1;
    challengeView.layer.shadowRadius = 12;
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 24, 81, 71)];
    [challengeView addSubview:iconView];
    iconView.backgroundColor = [UIColor colorWithHex:@"#5C4E6B"];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    iconView.clipsToBounds = YES;
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(81.0/2-48/2, 71.0/2-55.0/2, 48, 55)];
    [iconView addSubview:iconImageView];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds = YES;
    iconImageView.image = [UIImage imageNamed:@"train_rank"];
//    [iconView sd_setImageWithURL:[NSURL URLWithString:[GVUserDefaults standardUserDefaults].headImgPath] placeholderImage:placeHolderImg];
//    _iconView = iconView;
    
    UIImageView *rankIgView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 18, 21, 20)];
    [challengeView addSubview:rankIgView];
    rankIgView.contentMode = UIViewContentModeScaleAspectFill;
    rankIgView.image = [UIImage imageNamed:@"train_jaingpai"];
    
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+12, 38, topView.width-iconView.right-12-12, 16)];
    [challengeView addSubview:nickLabel];
    nickLabel.textColor = [UIColor colorWithHex:@"#333333"];
    nickLabel.font = fontBold(16);
    nickLabel.text = @"帕梅拉初级挑战者";
//    _nickLabel = nickLabel;
    
    UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+12, challengeView.height-31-11, topView.width-iconView.right-14-25, 11)];
    [challengeView addSubview:idLabel];
    idLabel.textColor = [UIColor colorWithHex:@"#333333"];
    idLabel.font = fontApp(11);
    idLabel.text = @"完成时间：12/09-12:12";
//    _idLabel = idLabel;
    
    
    
    
    
    UIView *perfectView = [[UIView alloc] initWithFrame:CGRectMake(15, challengeView.bottom+13, (SCR_WIDTH-30-6)/2, 88)];
    [bottomView addSubview:perfectView];
    perfectView.backgroundColor = [UIColor whiteColor];
    perfectView.layer.cornerRadius = 5;
    perfectView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.14].CGColor;
    perfectView.layer.shadowOffset = CGSizeMake(0,0);
    perfectView.layer.shadowOpacity = 1;
    perfectView.layer.shadowRadius = 12;
    
    UILabel *preNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, perfectView.width, 19)];
    [perfectView addSubview:preNumLabel];
    preNumLabel.textColor = [UIColor colorWithHex:@"#333333"];
    preNumLabel.font = fontBold(24);
    preNumLabel.textAlignment = NSTextAlignmentCenter;
    preNumLabel.text = @"10";
    //    _nickLabel = nickLabel;
        
    UILabel *preNumTiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, perfectView.height-24-12, perfectView.width, 12)];
    [perfectView addSubview:preNumTiLabel];
    preNumTiLabel.textColor = [UIColor colorWithHex:@"#333333"];
    preNumTiLabel.font = fontApp(12);
    preNumTiLabel.textAlignment = NSTextAlignmentCenter;
    preNumTiLabel.text = @"完美动作（次）";
    
    UIView *noPerfectView = [[UIView alloc] initWithFrame:CGRectMake(SCR_WIDTH-15-(SCR_WIDTH-30-6)/2, challengeView.bottom+13, (SCR_WIDTH-30-6)/2, 88)];
    [bottomView addSubview:noPerfectView];
    noPerfectView.backgroundColor = [UIColor whiteColor];
    noPerfectView.layer.cornerRadius = 5;
    noPerfectView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.14].CGColor;
    noPerfectView.layer.shadowOffset = CGSizeMake(0,0);
    noPerfectView.layer.shadowOpacity = 1;
    noPerfectView.layer.shadowRadius = 12;
    
    UILabel *nopreNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, noPerfectView.width, 19)];
    [noPerfectView addSubview:nopreNumLabel];
    nopreNumLabel.textColor = [UIColor colorWithHex:@"#333333"];
    nopreNumLabel.font = fontBold(24);
    nopreNumLabel.textAlignment = NSTextAlignmentCenter;
    nopreNumLabel.text = @"7";
    //    _nickLabel = nickLabel;
        
    UILabel *nopreNumTiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, noPerfectView.height-24-12, perfectView.width, 12)];
    [noPerfectView addSubview:nopreNumTiLabel];
    nopreNumTiLabel.textColor = [UIColor colorWithHex:@"#333333"];
    nopreNumTiLabel.font = fontApp(12);
    nopreNumTiLabel.textAlignment = NSTextAlignmentCenter;
    nopreNumTiLabel.text = @"再接再厉（次）";
    
    
    ReportprogressView *expendView = [[ReportprogressView alloc] initWithFrame:CGRectMake(0, perfectView.bottom, SCR_WIDTH, 44+10)];
    [bottomView addSubview:expendView];
    expendView.upTitleLabel.text = @"热量消耗/kcal";
    expendView.stateTitleLabel.text = @"543";
    expendView.picImageView.image = [UIImage imageNamed:@"train_reliang"];
    
    
    ReportprogressView *expendView1 = [[ReportprogressView alloc] initWithFrame:CGRectMake(0, expendView.bottom, SCR_WIDTH, 44+10)];
    [bottomView addSubview:expendView1];
    expendView1.upTitleLabel.text = @"平均心率/次每分";
    expendView1.stateTitleLabel.text = @"33";
    expendView1.picImageView.image = [UIImage imageNamed:@"train_xinlv"];
    
    ReportprogressView *expendView2 = [[ReportprogressView alloc] initWithFrame:CGRectMake(0, expendView1.bottom, SCR_WIDTH, 44+10)];
    [bottomView addSubview:expendView2];
    expendView2.upTitleLabel.text = @"动作完成度";
    expendView2.stateTitleLabel.text = @"良好";
    expendView2.picImageView.image = [UIImage imageNamed:@"train_jianshen"];
    
    
    scrollView.contentSize = CGSizeMake(SCR_WIDTH, topView.bottom+51+115+13+88+(44+10)*3+10);
    
}


- (void)backButtonClick:(UIButton *)btn
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Network
- (void)addVideoPlayRecord
{
    [ASTrainNetwork addVideoPlayRecordWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
