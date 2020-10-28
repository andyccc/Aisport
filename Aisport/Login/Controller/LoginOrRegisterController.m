//
//  LoginOrRegisterController.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "LoginOrRegisterController.h"
#import "InputCodeController.h"
#import "LoginNetWork.h"

@interface LoginOrRegisterController ()

@property (nonatomic, strong) UITextField *phoneTF;

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
    [getCodeBtn setBackgroundColor:[UIColor colorWithHex:@"#40CDBD"]];
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
    
    UIButton *weChatBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-54*Screen_Scale, otherTitleLabel.bottom+26, 54*2*Screen_Scale, 54*2*Screen_Scale)];
    [self.view addSubview:weChatBtn];
    [weChatBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//    weChatBtn.layer.cornerRadius = 37.0/2;
//    weChatBtn.clipsToBounds = YES;
    [weChatBtn addTarget:self action:@selector(clickWeChatBtn) forControlEvents:UIControlEventTouchUpInside];
    weChatBtn.hidden = NO;
    
//    NSString *agreementStr = @"登录即代表同意嗨动AI用户协议和隐私政策";
    UILabel *agreementLab = [[UILabel alloc] initWithFrame:CGRectMake(21, weChatBtn.bottom+42, SCR_WIDTH-42, 10)];
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
//        [self.navigationController pushViewController:vc animated:YES];
        
        NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
        [body setObject:_phoneTF.text forKey:@"phone"];
        [SVProgressHUD show];
        [LoginNetWork checkUserIdWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            if (ResponseSuccess) {
                //data(responseAfter) 0无账号无用户信息,1有账号无用户信息,2有账号并且有用户信息
                if ([StringForId(responseAfter) isEqual:@"0"]) {
                    [self getRegisterCode];
//                    [self getSendSmsCode];
                }else if ([StringForId(responseAfter) isEqual:@"1"]){
                    [self getSendSmsCode];
                }else if ([StringForId(responseAfter) isEqual:@"2"]){
                    [self getSendSmsCode];
                }
            }
                } andFailerFn:^(NSError * _Nonnull error) {
                    [SVProgressHUD dismiss];
                }];
    }
    
}

- (void)getRegisterCode
{
    
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phoneTF.text forKey:@"mobile"];
//    [NPNetworkAPIList loginSendRegistWith:body AndSuccessFn:^(id responseAfter, id responseBefore) {
//        [SVProgressHUD dismiss];
//        if (ResponseSuccess) {
//            InputCodeController *vc = [[InputCodeController alloc] init];
//            vc.phone = _phoneTF.text;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        } andFailerFn:^(NSError *error) {
//
//        }];
    
    [LoginNetWork getPostCodeWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        /*
         code = 0;
         data = 1;
         msg = "\U5f53\U524d\U6a21\U62df\U5f00\U5173\U5f00\U542f,\U9a8c\U8bc1\U7801\U4e3a: 1803";
         */
        if (ResponseSuccess) {
//            if (<#condition#>) {
//                <#statements#>
//            }
            InputCodeController *vc = [[InputCodeController alloc] init];
            vc.phone = _phoneTF.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
        } andFailerFn:^(NSError * _Nonnull error) {

        }];

}

- (void)getSendSmsCode
{
//    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
//    [body setObject:_phoneTF.text forKey:@"mobile"];
//    [NPNetworkAPIList loginSendLoginWith:body AndSuccessFn:^(id responseAfter, id responseBefore) {
//        if (ResponseSuccess) {
//            InputCodeController *vc = [[InputCodeController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//
//        } andFailerFn:^(NSError *error) {
//
//        }];
    
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phoneTF.text forKey:@"mobile"];
    [LoginNetWork getGetCodeWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            InputCodeController *vc = [[InputCodeController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        } andFailerFn:^(NSError * _Nonnull error) {
            
        }];
}

- (void)clickWeChatBtn
{
    
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
