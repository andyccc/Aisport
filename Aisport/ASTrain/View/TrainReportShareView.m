//
//  TrainReportShareView.m
//  Aisport
//
//  Created by Apple on 2020/10/29.
//

#import "TrainReportShareView.h"
#import "ReportprogressView.h"
#import "UIImageView+LBBlurredImage.h"
#import "SDRotationLoopProgressView.h"

@implementation TrainReportShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(22, StatusHeight + 17, 18, 32);
        [backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-100, StatusHeight+17, 200, 15)];
        [self addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = fontBold(16);
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"训练报告";
        
        
        ////////////////////////////
        
        
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, titleLabel.bottom+16*2*Screen_Scale, SCR_WIDTH-13*2*2*Screen_Scale, (371+163)*2*Screen_Scale)];
        [self addSubview:backImageView];
        backImageView.contentMode = UIViewContentModeScaleAspectFill;
        backImageView.clipsToBounds = YES;
        
        // 20 左右 R  模糊图片
        [backImageView setImageToBlur:[UIImage imageNamed:@"home_sportBanner"] blurRadius:5 completionBlock:nil];
    //    [backImageView sd_setImageWithURL:[NSURL URLWithString:_userInfoModel.headImg] placeholderImage:[UIImage imageNamed:@"placeHolderImg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //
    //    }];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backImageView.width, backImageView.height)];
        [backImageView addSubview:topView];
        topView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.42];
        
        
        
        SDRotationLoopProgressView *progressView = [[SDRotationLoopProgressView alloc] initWithFrame:CGRectMake(78*2*Screen_Scale, 16*2*Screen_Scale, backImageView.width-78*2*2*Screen_Scale, SCR_WIDTH-78*2*2*Screen_Scale)];
        [topView addSubview:progressView];
        progressView.backgroundColor = [UIColor clearColor];
        
    //    [progressView addScoreAnimation];
        
        
        UILabel *scoreNumLab = [[UILabel alloc] initWithFrame:CGRectMake(88*2*Screen_Scale, progressView.top+52*2*Screen_Scale, backImageView.width-88*2*2*Screen_Scale, 33)];
        [topView addSubview:scoreNumLab];
        scoreNumLab.textColor = [UIColor whiteColor];
        scoreNumLab.font = fontBold(43);
        scoreNumLab.textAlignment = NSTextAlignmentCenter;
        scoreNumLab.text = @"8047";
        
        UILabel *scoreTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(88*2*Screen_Scale, scoreNumLab.bottom+15*2*Screen_Scale, backImageView.width-88*2*2*Screen_Scale, 14)];
        [topView addSubview:scoreTitleLab];
        scoreTitleLab.textColor = [UIColor whiteColor];
        scoreTitleLab.font = fontBold(14);
        scoreTitleLab.textAlignment = NSTextAlignmentCenter;
        scoreTitleLab.text = @"训练得分";
        
        
        UILabel *failTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(10*2*Screen_Scale, topView.bottom-24*2*Screen_Scale-21, backImageView.width-10*2*2*Screen_Scale, 21)];
        [topView addSubview:failTitleLab];
        failTitleLab.textColor = [UIColor whiteColor];
        failTitleLab.font = fontBold(20);
        failTitleLab.textAlignment = NSTextAlignmentCenter;
        failTitleLab.text = @"击败了全国78%的用户，再接再厉";
        
        
        
        /////////////////////////////
        
        
//        UIView *middleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 163*2*Screen_Scale, backImageView.width, 371*2*Screen_Scale)];
//        [backImageView addSubview:middleBgView];
//        middleBgView.backgroundColor = [UIColor colorWithHex:@"#46342A"];
//        middleBgView.layer.cornerRadius = 7;
//        middleBgView.clipsToBounds = YES;
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 163*2*Screen_Scale, backImageView.width, backImageView.height-163*2*Screen_Scale)];
        bottomView.backgroundColor = [UIColor whiteColor];
        [backImageView addSubview:bottomView];
        bottomView.layer.cornerRadius = 17;
        bottomView.clipsToBounds = YES;
        

        UILabel *fileTiLab = [[UILabel alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, 22, bottomView.width-13*2*Screen_Scale, 16)];
        [bottomView addSubview:fileTiLab];
        fileTiLab.textColor = [UIColor colorWithHex:@"#333333"];
        fileTiLab.font = fontBold(16);
        fileTiLab.textAlignment = NSTextAlignmentLeft;
        fileTiLab.text = @"运动档案";
        
        UIView *challengeView = [[UIView alloc] initWithFrame:CGRectMake(15, 51, bottomView.width-30, 115)];
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
        
        UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+12, 38, challengeView.width-iconView.right-12-12, 16)];
        [challengeView addSubview:nickLabel];
        nickLabel.textColor = [UIColor colorWithHex:@"#333333"];
        nickLabel.font = fontBold(16);
        nickLabel.text = @"帕梅拉初级挑战者";
    //    _nickLabel = nickLabel;
        
        UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+12, challengeView.height-31-11, challengeView.width-iconView.right-14-25, 11)];
        [challengeView addSubview:idLabel];
        idLabel.textColor = [UIColor colorWithHex:@"#333333"];
        idLabel.font = fontApp(11);
        idLabel.text = @"完成时间：12/09-12:12";
    //    _idLabel = idLabel;
        
        
        
        
        
        UIView *perfectView = [[UIView alloc] initWithFrame:CGRectMake(15, challengeView.bottom+13, (bottomView.width-30-6)/2, 88)];
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
        
        UIView *noPerfectView = [[UIView alloc] initWithFrame:CGRectMake(bottomView.width-15-(bottomView.width-30-6)/2, challengeView.bottom+13, (bottomView.width-30-6)/2, 88)];
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
        
        
        ReportprogressView *expendView = [[ReportprogressView alloc] initWithFrame:CGRectMake(0, perfectView.bottom, bottomView.width, 44+10)];
        [bottomView addSubview:expendView];
        expendView.upTitleLabel.text = @"热量消耗/kcal";
        expendView.stateTitleLabel.text = @"543";
        expendView.picImageView.image = [UIImage imageNamed:@"train_reliang"];

        
        ReportprogressView *expendView2 = [[ReportprogressView alloc] initWithFrame:CGRectMake(0, expendView.bottom, bottomView.width, 44+10)];
        [bottomView addSubview:expendView2];
        expendView2.upTitleLabel.text = @"动作完成度";
        expendView2.stateTitleLabel.text = @"良好";
        expendView2.picImageView.image = [UIImage imageNamed:@"train_jianshen"];
        
        
        UIView *erweimaBgView = [[UIView alloc] initWithFrame:CGRectMake(bottomView.width/2-170*Screen_Scale, bottomView.bottom+15, 170*2*Screen_Scale, 62*2*Screen_Scale)];
        [self addSubview:erweimaBgView];
        erweimaBgView.backgroundColor = [UIColor colorWithHex:@"#FFFFFF" alpha:0.25];
        erweimaBgView.layer.cornerRadius = 5;
        erweimaBgView.clipsToBounds = YES;
        
        
        UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4*2*Screen_Scale, erweimaBgView.height/2-51*Screen_Scale, 51*2*Screen_Scale, 51*2*Screen_Scale)];
        [erweimaBgView addSubview:codeImageView];
        codeImageView.contentMode = UIViewContentModeScaleAspectFill;
        codeImageView.clipsToBounds = YES;
        
        UILabel *codeUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(codeImageView.right+5, 14, erweimaBgView.width-codeImageView.right-5, 13)];
        [erweimaBgView addSubview:codeUpLabel];
        codeUpLabel.font = fontApp(13);
        codeUpLabel.textColor = [UIColor whiteColor];
        codeUpLabel.text = @"嗨动AI健身课程";
        
        UILabel *codeDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(codeImageView.right+5, codeUpLabel.bottom+10, erweimaBgView.width-codeImageView.right-5, 12)];
        [erweimaBgView addSubview:codeDownLabel];
        codeDownLabel.font = fontApp(12);
        codeDownLabel.textColor = [UIColor whiteColor];
        codeDownLabel.text = @"长按扫码.一起运动";
    }
    return self;
}


- (void)backButtonClick
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
