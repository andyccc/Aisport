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

- (instancetype)initWithFrame:(CGRect)frame AndModel:(TrainReportModel *)model WithImage:(UIImage *)coverImage
{
    if (self = [super initWithFrame:frame]) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-136+20)];
        [self addSubview:scrollView];
        scrollView.bounces = NO;
        
        UIImageView *backBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, (371+163)*2*Screen_Scale+StatusHeight+17+15+16*2*Screen_Scale+62*2*Screen_Scale+15+10+30+20)];
        [scrollView addSubview:backBgImageView];
        backBgImageView.contentMode = UIViewContentModeScaleAspectFill;
        backBgImageView.userInteractionEnabled = YES;
        backBgImageView.clipsToBounds = YES;
        
        [backBgImageView setImageToBlur:coverImage blurRadius:5 completionBlock:nil];
        
        _backBgImageView = backBgImageView;
        
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(22, StatusHeight + 7, 18, 32);
        [backButton setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        _backButton = backButton;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-100, StatusHeight+17, 200, 15)];
        [_backBgImageView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = fontBold(16);
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"训练报告";
        _titleLabel = titleLabel;
        
        
        ////////////////////////////
        
        
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, titleLabel.bottom+16*2*Screen_Scale, SCR_WIDTH-13*2*2*Screen_Scale, (371+163)*2*Screen_Scale)];
        [_backBgImageView addSubview:backImageView];
        backImageView.contentMode = UIViewContentModeScaleAspectFill;
        backImageView.layer.cornerRadius = 17;
        backImageView.clipsToBounds = YES;
        
        // 20 左右 R  模糊图片
        [backImageView setImageToBlur:[UIImage imageNamed:@"home_sportBanner"] blurRadius:5 completionBlock:nil];
    //    [backImageView sd_setImageWithURL:[NSURL URLWithString:_userInfoModel.headImg] placeholderImage:[UIImage imageNamed:@"placeHolderImg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    //
    //    }];
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backImageView.width, backImageView.height)];
        [backImageView addSubview:topView];
        topView.layer.cornerRadius = 17;
        topView.clipsToBounds = YES;
        topView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.42];
        
        
        
        SDRotationLoopProgressView *progressView = [[SDRotationLoopProgressView alloc] initWithFrame:CGRectMake(95*2*Screen_Scale, 16*2*Screen_Scale, backImageView.width-95*2*2*Screen_Scale, SCR_WIDTH-95*2*2*Screen_Scale)];
        [topView addSubview:progressView];
        progressView.backgroundColor = [UIColor clearColor];
        
    //    [progressView addScoreAnimation];
        
        
        UILabel *scoreNumLab = [[UILabel alloc] initWithFrame:CGRectMake(105*2*Screen_Scale, progressView.top+38*2*Screen_Scale, backImageView.width-105*2*2*Screen_Scale, 25)];
        [topView addSubview:scoreNumLab];
        scoreNumLab.textColor = [UIColor whiteColor];
        scoreNumLab.font = fontBold(33);
        scoreNumLab.textAlignment = NSTextAlignmentCenter;
        scoreNumLab.text = StringForId(model.score);
        
        UILabel *scoreTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(105*2*Screen_Scale, scoreNumLab.bottom+11*2*Screen_Scale, backImageView.width-105*2*2*Screen_Scale, 11)];
        [topView addSubview:scoreTitleLab];
        scoreTitleLab.textColor = [UIColor whiteColor];
        scoreTitleLab.font = fontBold(11);
        scoreTitleLab.textAlignment = NSTextAlignmentCenter;
        scoreTitleLab.text = @"训练得分";
        
        
        UILabel *failTitleLab = [[UILabel alloc] initWithFrame:CGRectMake(10*2*Screen_Scale, 163*2*Screen_Scale-21*2*Screen_Scale-16, backImageView.width-10*2*2*Screen_Scale, 21)];
        [topView addSubview:failTitleLab];
        failTitleLab.textColor = [UIColor whiteColor];
        failTitleLab.font = fontBold(15);
        failTitleLab.textAlignment = NSTextAlignmentCenter;
        failTitleLab.text = [NSString stringWithFormat:@"击败了全国%@%%的用户，再接再厉",StringForId(model.beatRate)];
        
        
        
        /////////////////////////////
        
        
//        UIView *middleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 163*2*Screen_Scale, backImageView.width, 371*2*Screen_Scale)];
//        [backImageView addSubview:middleBgView];
//        middleBgView.backgroundColor = [UIColor colorWithHex:@"#46342A"];
//        middleBgView.layer.cornerRadius = 7;
//        middleBgView.clipsToBounds = YES;
        
        
        //运动档案
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
        
        UIView *challengeView = [[UIView alloc] initWithFrame:CGRectMake(15, 50, bottomView.width-30, 104)];
        [bottomView addSubview:challengeView];
        challengeView.backgroundColor = [UIColor whiteColor];
        challengeView.layer.cornerRadius = 5;
        challengeView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.14].CGColor;
        challengeView.layer.shadowOffset = CGSizeMake(0,0);
        challengeView.layer.shadowOpacity = 1;
        challengeView.layer.shadowRadius = 12;
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(26, 22, 74, 65)];
        [challengeView addSubview:iconView];
        iconView.backgroundColor = [UIColor colorWithHex:@"#5C4E6B"];
        iconView.contentMode = UIViewContentModeScaleAspectFill;
        iconView.layer.cornerRadius = 5;
        iconView.clipsToBounds = YES;
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(74.0/2-48/2, 65.0/2-55.0/2, 48, 55)];
        [iconView addSubview:iconImageView];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
//        iconImageView.layer.cornerRadius =5;
        iconImageView.clipsToBounds = YES;
//        iconImageView.image = [UIImage imageNamed:@"train_rank"];
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(model.image)] placeholderImage:nil];
    //    [iconView sd_setImageWithURL:[NSURL URLWithString:[GVUserDefaults standardUserDefaults].headImgPath] placeholderImage:placeHolderImg];
    //    _iconView = iconView;
        
        UIImageView *rankIgView = [[UIImageView alloc] initWithFrame:CGRectMake(19, 18, 21, 20)];
        [challengeView addSubview:rankIgView];
        rankIgView.contentMode = UIViewContentModeScaleAspectFill;
        rankIgView.hidden = YES;
        rankIgView.image = [UIImage imageNamed:@"train_jaingpai"];
        
        UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+12, 34, challengeView.width-iconView.right-12-12, 14)];
        [challengeView addSubview:nickLabel];
        nickLabel.textColor = [UIColor colorWithHex:@"#333333"];
        nickLabel.font = fontBold(15);
        nickLabel.text = [NSString stringWithFormat:@"%@%@",StringForId(model.courseName), StringForId(model.name)];
    //    _nickLabel = nickLabel;
        
        UILabel *idLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconView.right+12, challengeView.height-28-10, challengeView.width-iconView.right-14-25, 10)];
        [challengeView addSubview:idLabel];
        idLabel.textColor = [UIColor colorWithHex:@"#333333"];
        idLabel.font = fontApp(10);
        idLabel.text = [NSString stringWithFormat:@"完成时间：%@",StringForId(model.endTime)];
    //    _idLabel = idLabel;
        
        
        
        
        
        UIView *perfectView = [[UIView alloc] initWithFrame:CGRectMake(15, challengeView.bottom+11, (bottomView.width-30-6)/2, 80)];
        [bottomView addSubview:perfectView];
        perfectView.backgroundColor = [UIColor whiteColor];
        perfectView.layer.cornerRadius = 5;
        perfectView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.14].CGColor;
        perfectView.layer.shadowOffset = CGSizeMake(0,0);
        perfectView.layer.shadowOpacity = 1;
        perfectView.layer.shadowRadius = 12;
        
        UILabel *preNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, perfectView.width, 17)];
        [perfectView addSubview:preNumLabel];
        preNumLabel.textColor = [UIColor colorWithHex:@"#333333"];
        preNumLabel.font = fontBold(22);
        preNumLabel.textAlignment = NSTextAlignmentCenter;
        preNumLabel.text = StringForId(model.perfectNumber);
        //    _nickLabel = nickLabel;
            
        UILabel *preNumTiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, perfectView.height-22-11, perfectView.width, 11)];
        [perfectView addSubview:preNumTiLabel];
        preNumTiLabel.textColor = [UIColor colorWithHex:@"#333333"];
        preNumTiLabel.font = fontApp(11);
        preNumTiLabel.textAlignment = NSTextAlignmentCenter;
        preNumTiLabel.text = @"完美动作（次）";
        
        UIView *noPerfectView = [[UIView alloc] initWithFrame:CGRectMake(bottomView.width-15-(bottomView.width-30-6)/2, challengeView.bottom+11, (bottomView.width-30-6)/2, 80)];
        [bottomView addSubview:noPerfectView];
        noPerfectView.backgroundColor = [UIColor whiteColor];
        noPerfectView.layer.cornerRadius = 5;
        noPerfectView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.14].CGColor;
        noPerfectView.layer.shadowOffset = CGSizeMake(0,0);
        noPerfectView.layer.shadowOpacity = 1;
        noPerfectView.layer.shadowRadius = 12;
        
        UILabel *nopreNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, noPerfectView.width, 17)];
        [noPerfectView addSubview:nopreNumLabel];
        nopreNumLabel.textColor = [UIColor colorWithHex:@"#333333"];
        nopreNumLabel.font = fontBold(22);
        nopreNumLabel.textAlignment = NSTextAlignmentCenter;
        nopreNumLabel.text = StringForId(model.effortNumber);
        //    _nickLabel = nickLabel;
            
        UILabel *nopreNumTiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, noPerfectView.height-22-11, perfectView.width, 11)];
        [noPerfectView addSubview:nopreNumTiLabel];
        nopreNumTiLabel.textColor = [UIColor colorWithHex:@"#333333"];
        nopreNumTiLabel.font = fontApp(11);
        nopreNumTiLabel.textAlignment = NSTextAlignmentCenter;
        nopreNumTiLabel.text = @"再接再厉（次）";
        
        
        ReportprogressView *expendView = [[ReportprogressView alloc] initWithFrame:CGRectMake(0, perfectView.bottom, bottomView.width, 40+10)];
        [bottomView addSubview:expendView];
        expendView.upTitleLabel.text = @"热量消耗/kcal";
        expendView.stateTitleLabel.text = [NSString stringWithFormat:@"%@",model.calorie];
        expendView.picImageView.image = [UIImage imageNamed:@"train_reliang"];
        expendView.value = [StringForId(model.calorie) floatValue]/[StringForId(model.calorieTotal) floatValue];

        
        ReportprogressView *expendView2 = [[ReportprogressView alloc] initWithFrame:CGRectMake(0, expendView.bottom, bottomView.width, 40+10)];
        [bottomView addSubview:expendView2];
        expendView2.upTitleLabel.text = @"动作完成度";
        expendView2.stateTitleLabel.text = StringForId(model.completenessStr);
        expendView2.picImageView.image = [UIImage imageNamed:@"train_jianshen"];
        expendView2.value = ([StringForId(model.completeness) intValue]+1)/4.0;
        
        
        //二维码
        UIView *erweimaBgView = [[UIView alloc] initWithFrame:CGRectMake(_backBgImageView.width/2-170*Screen_Scale, backImageView.bottom+15, 170*2*Screen_Scale, 62*2*Screen_Scale)];
        [_backBgImageView addSubview:erweimaBgView];
        erweimaBgView.backgroundColor = [UIColor colorWithHex:@"#FFFFFF" alpha:0.25];
        erweimaBgView.layer.cornerRadius = 5;
        erweimaBgView.clipsToBounds = YES;
        
        
        UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4*2*Screen_Scale, erweimaBgView.height/2-51*Screen_Scale, 51*2*Screen_Scale, 51*2*Screen_Scale)];
        [erweimaBgView addSubview:codeImageView];
        codeImageView.contentMode = UIViewContentModeScaleAspectFill;
        codeImageView.clipsToBounds = YES;
        //Host_Url
        NSString *urlStr = [NSString stringWithFormat:@"%@/ai/qrCode/generateQrCode?code=%@",Host_Url,model.courseCode];
        [codeImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
        
        UILabel *codeUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(codeImageView.right+5, 14, erweimaBgView.width-codeImageView.right-5, 13)];
        [erweimaBgView addSubview:codeUpLabel];
        codeUpLabel.font = fontBold(13);
        codeUpLabel.textColor = [UIColor whiteColor];
        codeUpLabel.text = @"嗨动AI健身课程";
        
        UILabel *codeDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(codeImageView.right+5, codeUpLabel.bottom+10, erweimaBgView.width-codeImageView.right-5, 12)];
        [erweimaBgView addSubview:codeDownLabel];
        codeDownLabel.font = fontApp(12);
        codeDownLabel.textColor = [UIColor whiteColor];
        codeDownLabel.text = @"长按扫码.一起运动";
        
        scrollView.contentSize = CGSizeMake(SCR_WIDTH, erweimaBgView.bottom+10+20+20);
    }
    return self;
}


- (void)backButtonClick
{
    if (self.cancleReportBtnClickBlock) {
        self.cancleReportBtnClickBlock();
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
