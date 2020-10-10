//
//  LoginOrRegisterController.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "LoginOrRegisterController.h"
#import "InputCodeController.h"
#import "LoginNetWork.h"
#import "CommonWebController.h"
#import "WechatShareManager.h"
#import "BindPhoneVController.h"

@interface LoginOrRegisterController ()

@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) NSString *status;  //0无账号无用户信息,1有账号无用户信息,2有账号并且有用户信息

@property (nonatomic, strong) UILabel *otherTitleLabel;
@property (nonatomic, strong) UIImageView *weChatBtn;

@end

@implementation LoginOrRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMainView];
    // Do any additional setup after loading the view.
}

- (void)setMainView
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(22, StatusHeight + 20, 18, 32);
    [backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42*2*Screen_Scale, 19*2*Screen_Scale+SafeAreaTopHeight, SCR_WIDTH-42*2*Screen_Scale*2, 23)];
    [self.view addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    titleLabel.font = fontBold(23);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"手机号登录/注册";
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(46*2*Screen_Scale, titleLabel.bottom+11, SCR_WIDTH-46*2*Screen_Scale*2, 14)];
    [self.view addSubview:subLabel];
    subLabel.textColor = [UIColor colorWithHex:@"#999999"];
    subLabel.font = fontApp(14);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.text = @"嗨动AI有趣的运动即刻开始";
    
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(41*2*Screen_Scale, subLabel.bottom+20, SCR_WIDTH-41*2*Screen_Scale*2, 48)];
    [self.view addSubview:phoneTF];
    phoneTF.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
    phoneTF.textColor = [UIColor colorWithHex:@"#999999"];
    phoneTF.font = fontApp(18);
    phoneTF.placeholder = @"输入手机号码";
    phoneTF.textAlignment = NSTextAlignmentCenter;
    phoneTF.layer.cornerRadius = 48/2;
    phoneTF.clipsToBounds = YES;
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF = phoneTF;
    
    UIButton *getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(41*2*Screen_Scale, phoneTF.bottom+21, SCR_WIDTH-41*2*Screen_Scale*2, 48)];
    [self.view addSubview:getCodeBtn];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [getCodeBtn setBackgroundColor:[UIColor colorWithHex:@"#FBB313"]];
    getCodeBtn.titleLabel.font = fontBold(18);
    getCodeBtn.layer.cornerRadius = 48.0/2;
    getCodeBtn.clipsToBounds = YES;
    [getCodeBtn addTarget:self action:@selector(clickGetCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *otherTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42*2*Screen_Scale, SCR_HIGHT-177*2*Screen_Scale-13, SCR_WIDTH-42*2*Screen_Scale*2, 13)];
    [self.view addSubview:otherTitleLabel];
    otherTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    otherTitleLabel.font = fontBold(13);
    otherTitleLabel.textAlignment = NSTextAlignmentCenter;
    otherTitleLabel.text = @"其他登录方式";
    otherTitleLabel.hidden = YES;
    _otherTitleLabel = otherTitleLabel;
    
    UIImageView *weChatBtn = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-54*Screen_Scale, otherTitleLabel.bottom+26, 54*2*Screen_Scale, 54*2*Screen_Scale)];
    [self.view addSubview:weChatBtn];
    weChatBtn.image = [UIImage imageNamed:@"wechatLogo"];
    weChatBtn.contentMode = UIViewContentModeScaleAspectFill;
//    weChatBtn.layer.cornerRadius = 37.0/2;
    weChatBtn.clipsToBounds = YES;
    weChatBtn.userInteractionEnabled = YES;
    weChatBtn.hidden = YES;
    _weChatBtn = weChatBtn;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWeChatBtn:)];
    [weChatBtn addGestureRecognizer:tap];
    
//    NSString *agreementStr = @"登录即代表同意嗨动AI用户协议和隐私政策";
    UILabel *agreementLab = [[UILabel alloc] initWithFrame:CGRectMake(21, weChatBtn.bottom+39, SCR_WIDTH-42, 16)];
    [self.view addSubview:agreementLab];
    agreementLab.userInteractionEnabled = YES;
    agreementLab.numberOfLines = 0;
    agreementLab.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *frontAttr = [[NSMutableAttributedString alloc] initWithString:@"登录即代表同意嗨动AI" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#333333"],NSFontAttributeName:fontApp(10)}];
    NSMutableAttributedString *midAttr = [[NSMutableAttributedString alloc] initWithString:@"用户协议" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#333333"],NSFontAttributeName:fontApp(10),NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]}];

    NSMutableAttributedString *mid1Attr = [[NSMutableAttributedString alloc] initWithString:@"和" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#333333"],NSFontAttributeName:fontApp(10)}];
    NSMutableAttributedString *lastAttr = [[NSMutableAttributedString alloc] initWithString:@"隐私政策" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#333333"],NSFontAttributeName:fontApp(10),NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
    [frontAttr appendAttributedString:midAttr];
    [frontAttr appendAttributedString:mid1Attr];
    [frontAttr appendAttributedString:lastAttr];
    agreementLab.attributedText = frontAttr;
    
    
    UIButton *xieyiButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2, weChatBtn.bottom+42, 50, 10)];
    [self.view addSubview:xieyiButton];
    [xieyiButton addTarget:self action:@selector(clickxieyiButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *zhengceButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2+60, weChatBtn.bottom+42, 50, 10)];
    [self.view addSubview:zhengceButton];
    [zhengceButton addTarget:self action:@selector(clickzhengceButton) forControlEvents:UIControlEventTouchUpInside];
    
//    NSDictionary *linkDic = @{ NSLinkAttributeName : [NSURL URLWithString:@"http://www.google.com"] };
//    [str setAttributes:linkDic range:[[str string] rangeOfString:@"www.google.com"]];
    
//    float agreementH = [NSString getHeightWithText:agreementStr andWithWidth:SCR_WIDTH-42 andWithFont:fontApp(13)];
//    if (agreementH > 20) {
//        agreementLab.height = agreementH;
//        agreementLab.textAlignment = NSTextAlignmentLeft;
//    }
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAgreement)];
//    [agreementLab addGestureRecognizer:tap];
}

- (void)clickGetCodeBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (_phoneTF.text.length > 0 && _phoneTF.text.length < 12) {

//        NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
//        [body setObject:_phoneTF.text forKey:@"phone"];
//        [SVProgressHUD show];
//        [NPNetworkAPIList loginGetStatusWith:body AndSuccessFn:^(id responseAfter, id responseBefore) {
//            if (ResponseSuccess) {
//                //data(responseAfter) 0无账号无用户信息,1有账号无用户信息,2有账号并且有用户信息
//                if ([StringForId(responseAfter) isEqual:@"0"]) {
//                    [self getRegisterCode];
////                    [self getSendSmsCode];
//                }else if ([StringForId(responseAfter) isEqual:@"1"]){
////                    [self getSendSmsCode];
//                }else if ([StringForId(responseAfter) isEqual:@"2"]){
////                    [self getSendSmsCode];
//                }
//            }
//
//                } andFailerFn:^(NSError *error) {
//
//                }];

//        InputCodeController *vc = [[InputCodeController alloc] init];
//        vc.phone = @"17326831803";
//        [self.navigationController pushViewController:vc animated:YES];
        
        NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
        [body setObject:_phoneTF.text forKey:@"phone"];
        [SVProgressHUD show];
        [LoginNetWork checkUserIdWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            if (ResponseSuccess) {
                //data(responseAfter) 0无账号无用户信息,1有账号无用户信息,2有账号并且有用户信息
                self.status = StringForId(responseAfter);
                if ([StringForId(responseAfter) isEqual:@"0"]) {
                    [self getRegisterCode];
//                    [self getSendSmsCode];
                }else if ([StringForId(responseAfter) isEqual:@"1"]){
                    [self getSendSmsCode];
                }else if ([StringForId(responseAfter) isEqual:@"2"]){
                    [self getSendSmsCode];
                }
                NSLog(@"status-------------%@",StringForId(responseAfter));
                
            }
        } andFailerFn:^(NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];
    }
    
}


- (void)clickWeChatBtn:(UITapGestureRecognizer *)tap
{
    WS(weakSelf);
    [[WechatShareManager shareInstance] wechatLoginAppWithSuccessFul:^(NSString *unionId, NSString *nickname, NSString *headimgurl, NSString *sex) {
        [weakSelf judgeIsNeedBindPhoneWithUnionId:unionId Nickname:nickname Headimgurl:headimgurl Sex:sex];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _phoneTF.text = @"";
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self getWechatIsLogin];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)clickxieyiButton
{
    CommonWebController *web = [[CommonWebController alloc] init];
    web.title = @"用户协议";
    web.url = [NSString stringWithFormat:@"%@%@",Host_Url_Web,@"userAgreement"];
    [self.navigationController pushViewController:web animated:YES];
}
- (void)clickzhengceButton
{
    CommonWebController *web = [[CommonWebController alloc] init];
    web.title = @"隐私政策";
    web.url = [NSString stringWithFormat:@"%@%@",Host_Url_Web,@"privacyPolicy"];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)backButtonLoginClick
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
    }];
}

#pragma mark - Network
- (void)getRegisterCode
{
    WS(weakSelf);
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phoneTF.text forKey:@"mobile"];
    [LoginNetWork getPostCodeWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        /*
         code = 0;
         data = 1;
         msg = "\U5f53\U524d\U6a21\U62df\U5f00\U5173\U5f00\U542f,\U9a8c\U8bc1\U7801\U4e3a: 1803";
         */
        if (ResponseSuccess) {
            InputCodeController *vc = [[InputCodeController alloc] init];
            vc.phone = weakSelf.phoneTF.text;
            vc.status = weakSelf.status; //StringForId(responseAfter)
            [self.navigationController pushViewController:vc animated:YES];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];

}

- (void)getSendSmsCode
{
    WS(weakSelf);
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phoneTF.text forKey:@"mobile"];
    [LoginNetWork getGetCodeWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            InputCodeController *vc = [[InputCodeController alloc] init];
            vc.phone = weakSelf.phoneTF.text;
            vc.status = weakSelf.status;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"yan"];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}


- (void)judgeIsNeedBindPhoneWithUnionId:(NSString *)unionId Nickname:(NSString *)nickname Headimgurl:(NSString *)headimgurl Sex:(NSString *)sex
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:unionId forKey:@"unionId"];
    [SVProgressHUD show];
    WS(weakSelf);
    [LoginNetWork getWXLoginWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            [weakSelf loginUserClickWithPhone:StringForId(responseAfter[@"phone"]) Code:StringForId(responseAfter[@"code"])];
        }else if ([responseBefore[@"code"] intValue]== 1){
            if (![StringForId(responseBefore[@"data"][@"unionIdIsBind"]) isEqual:@""] && [StringForId(responseBefore[@"data"][@"unionIdIsBind"]) isEqual:@"0"]) {
                BindPhoneVController *vc = [[BindPhoneVController alloc] init];
                vc.unionId = unionId;
                vc.nickname = nickname;
                vc.headimgurl = headimgurl;
                vc.sex = sex;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)loginUserClickWithPhone:(NSString *)phone Code:(NSString *)code
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:code forKey:@"code"];
    [body setObject:[NSString stringWithFormat:@"SMS@%@",phone] forKey:@"mobile"];
    [body setObject:@"mobile" forKey:@"grant_type"];
    WS(weakSelf);
    [LoginNetWork loginUserWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if ([StringForId(responseBefore[@"access_token"]) isEqual:@""]) {
            [SVProgressHUD showInfoWithStatus:@"登陆失败"];
            return;
        }
        [GVUserDefaults standardUserDefaults].access_token = StringForId(responseBefore[@"access_token"]);
        [GVUserDefaults standardUserDefaults].refresh_token = StringForId(responseBefore[@"refresh_token"]);
        [GVUserDefaults standardUserDefaults].phone = StringForId(responseBefore[@"user_info"][@"phone"]);
        [GVUserDefaults standardUserDefaults].cover = StringForId(responseBefore[@"user_info"][@"cover"]);
        [GVUserDefaults standardUserDefaults].nickName = StringForId(responseBefore[@"user_info"][@"nickName"]);
        [GVUserDefaults standardUserDefaults].sex = StringForId(responseBefore[@"user_info"][@"sex"]);
        
        long long expiresIn = StringForId(responseBefore[@"expires_in"]).longLongValue/1000;
        NSString *expires_inStr = [DatetimeOpeartion getSecondDataWithSecond:expiresIn];
        [GVUserDefaults standardUserDefaults].expires_in = expires_inStr;
        NSLog(@"%@", [GVUserDefaults standardUserDefaults].expires_in);
        

        [GVUserDefaults standardUserDefaults].firstEnter = 11;
        [GVUserDefaults standardUserDefaults].firstInfoEnter = 11;
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
            [weakSelf.navigationController popViewControllerAnimated:NO];
        }];
        
        
        } andFailerFn:^(NSError * _Nonnull error) {
            
    }];
}


- (void)getWechatIsLogin
{
//    NSMutableDictionary* body = [NSMutableDictionary dictionaryWithCapacity:0];
//    [body setObject:@"1" forKey:@"type"];
    
    WS(weakSelf);
    [[LoginNetWork share] AFGETNetworkWithUrl:@"ai/param/isHidden" andBody:nil andSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
//        [GVUserDefaults standardUserDefaults].version = responseAfter;
        if ([StringForId(responseAfter) isEqual:@"1"]) {
            weakSelf.otherTitleLabel.hidden = YES;
            weakSelf.weChatBtn.hidden = YES;
        }else{
            weakSelf.otherTitleLabel.hidden = NO;
            weakSelf.weChatBtn.hidden = NO;
        }
    } andFailer:^(NSError * _Nonnull error) {
        
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
