//
//  InquiryAlertView.m
//  Aisport
//
//  Created by Apple on 2020/12/9.
//

#import "InquiryAlertView.h"

@interface InquiryAlertView()
{
    UIView *_blackView;
    UIView *_redrechargeView;
    UITextField *_chargeTextField;
}
@property (nonatomic,copy) ClickBlock clickBlock;

@end

@implementation InquiryAlertView

+ (instancetype)shareAlertView
{
    static InquiryAlertView *alertView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertView = [[InquiryAlertView alloc] init];
    });
    return alertView;
}

- (void)showUpdateAppAlertViewWithSure:(ClickBlock)clickBlock
{
    self.clickBlock = clickBlock;
    _blackView = [self getBlackViewAddTap:NO];
    CGFloat alertWidth = 279*2*Screen_Scale;
    CGFloat alertHeight = 298*2*Screen_Scale;
    
    UIImageView *alertBGImgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCR_WIDTH/2-alertWidth/2, SCR_HIGHT/2-alertHeight/2, alertWidth, alertHeight)];
    alertBGImgView.image = [UIImage imageNamed:@"updateApp"];
//    alertBGImgView.layer.cornerRadius = 6;
//    alertBGImgView.layer.masksToBounds = YES;
    alertBGImgView.contentMode = UIViewContentModeScaleAspectFill;
    alertBGImgView.clipsToBounds = YES;
    alertBGImgView.userInteractionEnabled = YES;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 49, alertBGImgView.width-20, 19)];
    [alertBGImgView addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHex:@"#3E3E3E"];
    titleLabel.font = fontBold(20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"发现新版本！";
    
    UIView *horiView = [[UIView alloc] initWithFrame:CGRectMake(alertBGImgView.width/2-114/2, titleLabel.bottom+6, 114, 1)];
    [alertBGImgView addSubview:horiView];
    horiView.backgroundColor = [UIColor colorWithHex:@"#3E3E3E" alpha:1.0];
    
    UIView *horiView1 = [[UIView alloc] initWithFrame:CGRectMake(alertBGImgView.width/2-114/2, horiView.bottom+2, 114, 1)];
    [alertBGImgView addSubview:horiView1];
    horiView1.backgroundColor = [UIColor colorWithHex:@"#3E3E3E" alpha:1.0];
    
    
    UILabel *fixLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(80, horiView1.bottom+14, alertBGImgView.width-80*2, 19)];
    [alertBGImgView addSubview:fixLabel1];
    fixLabel1.textColor = [UIColor colorWithHex:@"#3E3E3E"];
    fixLabel1.font = fontApp(11);
//    fixLabel1.textAlignment = NSTextAlignmentCenter;
    fixLabel1.text = @"1.页面改版";
    
    UILabel *fixLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(80, fixLabel1.bottom+14, alertBGImgView.width-80-20, 19)];
    [alertBGImgView addSubview:fixLabel2];
    fixLabel2.textColor = [UIColor colorWithHex:@"#3E3E3E"];
    fixLabel2.font = fontApp(11);
//    fixLabel2.textAlignment = NSTextAlignmentCenter;
    fixLabel2.text = @"2. 修改Bug，提升稳定性";
    
    UIButton *sureUpdateBtn = [[UIButton alloc] initWithFrame:CGRectMake(alertBGImgView.width/2-69*Screen_Scale, 166*2*Screen_Scale, 69*2*Screen_Scale, 69*2*Screen_Scale)];
    [alertBGImgView addSubview:sureUpdateBtn];
//    [sureUpdateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
//    [sureUpdateBtn setTitleColor:WHITE_Color forState:UIControlStateNormal];
//    [sureUpdateBtn setBackgroundColor:mainColor forState:UIControlStateNormal];
//    sureUpdateBtn.titleLabel.font = fontApp(16);
//    sureUpdateBtn.layer.cornerRadius = 5;
//    sureUpdateBtn.clipsToBounds = YES;
    [sureUpdateBtn addTarget:self action:@selector(sureInquiryBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"版本不息，优化不止，每一次更新，都是为了带给您更好的使用体验。"];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:10];
//    UILabel *titLabel = [UILabel labelWithFrame:CGRectMake(20, alertHeight-20-40-40-50, alertWidth-40, 50)
//                                           text:@"版本不息，优化不止，每一次更新，都是为了带给您更好的使用体验。"
//                                        bgColor:[UIColor clearColor]
//                                           font:fontApp(14)
//                                      textcolor:textColor_333333
//                                  textAlignment:NSTextAlignmentCenter];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [titLabel.text length])];
//    titLabel.attributedText = attributedString;
//    titLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    titLabel.numberOfLines = 2;
//    [alertBGImgView addSubview:titLabel];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertBGImgView];
    _redrechargeView = alertBGImgView;
}

- (void)sureInquiryBtnClick
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (UIView *)getBlackViewAddTap:(BOOL)tap
{
    if (_blackView) {
        return _blackView;
    }
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:view];
    if (tap) {
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
        [view addGestureRecognizer:tapG];
    }
    return view;
}

- (void)hide
{
    if (_blackView) {
        [_blackView removeFromSuperview];
        _blackView = nil;
    }
    
    if (_redrechargeView) {
        for (UIView *view in _redrechargeView.subviews) {
            [view removeFromSuperview];
        }
        [_redrechargeView removeFromSuperview];
        _redrechargeView = nil;
    }
}



@end
