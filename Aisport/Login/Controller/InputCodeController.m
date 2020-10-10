//
//  InputCodeController.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "InputCodeController.h"
#import "PerfectInfoController.h"
#import "LoginNetWork.h"
#import "CommonNetworkManager.h"
#import "CodeTextField.h"
#import "Aisport-Swift.h"

@interface InputCodeController ()<UITextFieldDelegate,CodeTextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *numberTFArray;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) long second;
@property (nonatomic, strong) UIButton *reGetCodeBtn;
@property (nonatomic, strong) UILabel *phoneLabel;

@end

@implementation InputCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setMainView];
    [self startCountDown];
    // Do any additional setup after loading the view.
}

- (void)setMainView
{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(22, StatusHeight + 20, 18, 32);
    [backButton setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42*2*Screen_Scale, 19*2*Screen_Scale+SafeAreaTopHeight, SCR_WIDTH-42*2*Screen_Scale*2, 23)];
    [self.view addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    titleLabel.font = fontBold(23);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"输入验证码";
    
    UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(46*2*Screen_Scale, titleLabel.bottom+11, 130, 14)];
    [self.view addSubview:subLabel];
    subLabel.textColor = [UIColor colorWithHex:@"#333333"];
    subLabel.font = fontApp(14);
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.text = @"已发送4位验证码至";
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(subLabel.right, titleLabel.bottom+11, 115, 14)];
    [self.view addSubview:phoneLabel];
    phoneLabel.textColor = [UIColor colorWithHex:@"#999999"];
    phoneLabel.font = fontApp(14);
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.text = StringForId(_phone);
    
    
    _numberTFArray = [NSMutableArray arrayWithCapacity:0];
    CGFloat codeW = (SCR_WIDTH - 46*2*Screen_Scale*2 - 25*3)/4;
    for (int i = 0; i < 4; i++) {
        CodeTextField *codeTF = [[CodeTextField alloc] initWithFrame:CGRectMake(46*2*Screen_Scale+(codeW+25)*i, subLabel.bottom+41, codeW, codeW)];
        [self.view addSubview:codeTF];
        codeTF.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        codeTF.textColor = [UIColor colorWithHex:@"#333333"];
        codeTF.font = fontApp(23);
//        phoneTF.placeholder = @"输入手机号码";
        codeTF.textAlignment = NSTextAlignmentCenter;
        codeTF.layer.cornerRadius = 2;
        codeTF.clipsToBounds = YES;
        codeTF.tag = i;
        codeTF.keyboardType = UIKeyboardTypeNumberPad;
        codeTF.delegate = self;
        codeTF.keyInputDelegate = self;
        
        [_numberTFArray addObject:codeTF];
        [codeTF addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
        
        if (i == 0) {
            [codeTF becomeFirstResponder];
        }
    }
    
    UIButton *sureCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(41*2*Screen_Scale, subLabel.bottom+codeW+41+32, SCR_WIDTH-41*2*Screen_Scale*2, 48)];
    [self.view addSubview:sureCodeBtn];
    [sureCodeBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureCodeBtn setBackgroundColor:[UIColor colorWithHex:@"#FBB313"]];
    sureCodeBtn.titleLabel.font = fontBold(18);
    sureCodeBtn.layer.cornerRadius = 48.0/2;
    sureCodeBtn.clipsToBounds = YES;
    [sureCodeBtn addTarget:self action:@selector(clickSureCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *reGetCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(80*2*Screen_Scale, sureCodeBtn.bottom+12, SCR_WIDTH-80*2*Screen_Scale*2, 33)];
    [self.view addSubview:reGetCodeBtn];
    [reGetCodeBtn setTitle:@"重新获取(23）" forState:UIControlStateNormal];
    [reGetCodeBtn setTitleColor:[UIColor colorWithHex:@"#666666"] forState:UIControlStateNormal];
    reGetCodeBtn.titleLabel.font = fontApp(13);
    [reGetCodeBtn addTarget:self action:@selector(clickReGetCodeBtn) forControlEvents:UIControlEventTouchUpInside];
    _reGetCodeBtn = reGetCodeBtn;
}

- (void)clickSureCodeBtn
{
    [self.view endEditing:YES];
    UITextField *textF1 = self.numberTFArray[0];
    UITextField *textF2 = self.numberTFArray[1];
    UITextField *textF3 = self.numberTFArray[2];
    UITextField *textF4 = self.numberTFArray[3];
    if ([StringForId(textF1.text) isEqual:@""]) {
        return;;
    }
    if ([StringForId(textF2.text) isEqual:@""]) {
        return;;
    }
    if ([StringForId(textF3.text) isEqual:@""]) {
        return;;
    }
    if ([StringForId(textF4.text) isEqual:@""]) {
        return;;
    }
    NSString *code = [NSString stringWithFormat:@"%@%@%@%@",textF1.text,textF2.text,textF3.text,textF4.text];
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:code forKey:@"code"];
    
    
//    PerfectInfoController *vc = [[PerfectInfoController alloc] init];
//    vc.phone = _phone;
//    [self.navigationController pushViewController:vc animated:YES];
    
    if ([StringForId(_status) isEqual:@"0"]) {
        [body setObject:_phone forKey:@"phone"];
        [self registerUserClickWithBody:body];
    }else if ([StringForId(_status) isEqual:@"10"]) {
        [body setObject:[NSString stringWithFormat:@"SMS@%@",_phone] forKey:@"mobile"];
        [body setObject:@"mobile" forKey:@"grant_type"];
        [self loginUserClickWithBody:body];
    }else if ([StringForId(_status) isEqual:@"11"]) {
        [body setObject:_phone forKey:@"phone"];
        [body setObject:_unionId forKey:@"unionId"];
        [body setObject:_nickname forKey:@"nickname"];
        [body setObject:_headimgurl forKey:@"headimgurl"];
        [body setObject:_sex forKey:@"sex"];
        [self registerUserClickWithBody:body];
    }else{
        [body setObject:[NSString stringWithFormat:@"SMS@%@",_phone] forKey:@"mobile"];
        [body setObject:@"mobile" forKey:@"grant_type"];
        [self loginUserClickWithBody:body];
    }
    
    
//    [[CommonNetworkManager share] postWithUrl:@"ai/hidouserinfo/register" body:body success:^(NSDictionary * _Nonnull response) {
//
//        } failure:^(NSError * _Nonnull error) {
//
//        }];

    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
////    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    
    
   
    
}

- (void)loginUserClickWithBody:(NSMutableDictionary *)body
{
    WS(weakSelf);
    [LoginNetWork loginUserWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        /*
         "access_token" = "30a8a1d2-e28f-4850-8d75-ef06c1fad72d";  //首次token
         active = 1;
         "expires_in" = 43093;
         license = "made by pamir";
         "refresh_token" = "66455f00-2a7b-49ae-adf9-5f5e7177220d";  //token失效，可替换token
         scope = server;
         "token_type" = bearer;
         "user_info" =     {
             accountNonExpired = 1;
             accountNonLocked = 1;
             authorities =         (
                             {
                     authority = "ROLE_4";
                 }
             );
             avatar = "<null>";
             credentialsNonExpired = 1;
             deptId = 9;
             enabled = 1;
             id = 440;
             password = "<null>";
             phone = 17326831803;
             tenantId = 1;
             username = 17326831803;
         };
         */
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
        [GVUserDefaults standardUserDefaults].user_Id = StringForId(responseBefore[@"user_info"][@"userCode"]);
        
        long long expiresIn = StringForId(responseBefore[@"expires_in"]).longLongValue/1000;
        NSString *expires_inStr = [DatetimeOpeartion getSecondDataWithSecond:expiresIn];
        [GVUserDefaults standardUserDefaults].expires_in = expires_inStr;
        NSLog(@"%@", [GVUserDefaults standardUserDefaults].expires_in);

        if ([weakSelf.status isEqual:@"10"]) {
            [weakSelf bindPhoneWXUnionId];
        }else{
            [GVUserDefaults standardUserDefaults].firstEnter = 11;
            [GVUserDefaults standardUserDefaults].firstInfoEnter = 11;
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            }];
        }
        
        
        
        } andFailerFn:^(NSError * _Nonnull error) {
            
    }];
}

- (void)registerUserClickWithBody:(NSMutableDictionary *)body
{
    WS(weakSelf);
    [SVProgressHUD show];
    [LoginNetWork registerUserWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {

            [body setObject:[NSString stringWithFormat:@"SMS@%@",weakSelf.phone] forKey:@"mobile"];
            [body setObject:@"mobile" forKey:@"grant_type"];
            [body removeObjectForKey:@"phone"];
            if ([StringForId(weakSelf.status) isEqual:@"11"]) {
                [body removeObjectForKey:@"headimgurl"];
                [body removeObjectForKey:@"nickname"];
                [body removeObjectForKey:@"unionId"];
                [body removeObjectForKey:@"sex"];
            }
            [weakSelf chectCodeStatusIsReSendCode:NO];
            [weakSelf loginUserClickWithBody:body];
        }else{
            [SVProgressHUD showInfoWithStatus:[NSString stringForId:responseBefore[@"msg"]]];

//            PerfectInfoController *vc = [[PerfectInfoController alloc] init];
//            vc.phone = weakSelf.phone;
//            [self.navigationController pushViewController:vƒc animated:YES];
        }
        } andFailerFn:^(NSError * _Nonnull error) {

        }];
}

- (void)clickReGetCodeBtn
{
    [self chectCodeStatusIsReSendCode:YES];
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing--%@",textField.text);
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing--%@",textField.text);
}

- (void)textFieldDidChangeSelection:(UITextField *)textField
{
    NSLog(@"textFieldDidChangeSelection--%@",textField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    UITextField *textF1 = self.numberTFArray[0];
    UITextField *textF2 = self.numberTFArray[1];
    UITextField *textF3 = self.numberTFArray[2];
    UITextField *textF4 = self.numberTFArray[3];
    if (textField == textF4) {
        if (textField.text.length >= 1 && ![string isEqual:@""]) {
            return NO;
        }
    }else if (textField == textF3){
        if (textField.text.length >= 1 && ![string isEqual:@""]) {
            [textF4 becomeFirstResponder];
            self.index = textF4.tag;
            return NO;
        }
    }else if (textField == textF2){
        if (textField.text.length >= 1 && ![string isEqual:@""]) {
            [textF3 becomeFirstResponder];
            self.index = textF3.tag;
            return NO;
        }
    }else if (textField == textF1){
        if (textField.text.length >= 1 && ![string isEqual:@""]) {
            [textF2 becomeFirstResponder];
            self.index = textF2.tag;
            return NO;
        }
    }
    return YES;
}

- (void)deleteBackward
{
    UITextField *currentTF = self.numberTFArray[self.index];
    if (currentTF.text.length < 1 && self.index != 0) {
        UITextField *nextTF = self.numberTFArray[self.index-1];
        self.index--;
        [nextTF becomeFirstResponder];
    }
}


- (void)textFieldEditingChanged :(UITextField *)textField
{
    NSLog( @"text changed: %@", textField.text);
    UITextField *textF1 = self.numberTFArray[0];
    UITextField *textF2 = self.numberTFArray[1];
    UITextField *textF3 = self.numberTFArray[2];
    UITextField *textF4 = self.numberTFArray[3];
    if (textField == textF1) {
        if (textF1.text.length >= 1) {
            [textF2 becomeFirstResponder];
            self.index = textF2.tag;
        }else{
//            [textF1 becomeFirstResponder];
        }
    }else if (textField == textF2){
        if (textF2.text.length >= 1) {
            [textF3 becomeFirstResponder];
            self.index = textF3.tag;
        }else{
//            [textF1 becomeFirstResponder];
        }
    }else if (textField == textF3){
        if (textF3.text.length >= 1) {
            [textF4 becomeFirstResponder];
            self.index = textF4.tag;
        }else{
//            [textF2 becomeFirstResponder];
        }
    }else if (textField == textF4){
        if (textF4.text.length < 1) {
//            [textF3 becomeFirstResponder];
        }
    }
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

-(void)startCountDown
{
    _second = 60;
    if (!_timer) {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeTimeBtn) userInfo:nil repeats:YES];
    }
    [_timer fire];
}

-(void)changeTimeBtn
{
    if(_second <= 0)
    {
        _reGetCodeBtn.userInteractionEnabled = YES;
//        self.layer.borderColor = mainColor.CGColor;
//        self.backgroundColor = [UIColor clearColor];
        [_reGetCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [self setTitleColor:textColor_333333 forState:UIControlStateNormal];
        [self invalidateTimer];
        
    }else
    {
        _reGetCodeBtn.userInteractionEnabled = NO;
//        self.layer.borderColor = textColor_CCCCCC.CGColor;
//        self.backgroundColor = textColor_CCCCCC;
        [_reGetCodeBtn setTitle:[NSString stringWithFormat:@"重新获取(%ld）",_second] forState:UIControlStateNormal];
//        [self setTitleColor:textColor_999999 forState:UIControlStateNormal];
        _second --;
    }
}

- (void)invalidateTimer
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}



#pragma mark - net
- (void)chectCodeStatusIsReSendCode:(BOOL)isReSendCode
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phone forKey:@"phone"];
    [SVProgressHUD show];
    [LoginNetWork checkUserIdWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            if (!isReSendCode) {
                [SVProgressHUD dismiss];
            }else{
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
            
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)getRegisterCode
{
    WS(weakSelf);
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phone forKey:@"mobile"];
    [LoginNetWork getPostCodeWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        /*
         code = 0;
         data = 1;
         msg = "\U5f53\U524d\U6a21\U62df\U5f00\U5173\U5f00\U542f,\U9a8c\U8bc1\U7801\U4e3a: 1803";
         */
        if (ResponseSuccess) {
//            InputCodeController *vc = [[InputCodeController alloc] init];
//            vc.phone = weakSelf.phoneTF.text;
//            vc.status = @"0";
//            [self.navigationController pushViewController:vc animated:YES];
//            weakSelf.status = StringForId(responseAfter);
            [weakSelf startCountDown];
        }
        } andFailerFn:^(NSError * _Nonnull error) {

        }];

}

- (void)getSendSmsCode
{
    WS(weakSelf);
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phone forKey:@"mobile"];
    [LoginNetWork getGetCodeWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
//            InputCodeController *vc = [[InputCodeController alloc] init];
//            vc.phone = weakSelf.phoneTF.text;
//            vc.status = @"2";
//            [self.navigationController pushViewController:vc animated:YES];
//            weakSelf.status = StringForId(responseAfter);
            [weakSelf startCountDown];
        }
        } andFailerFn:^(NSError * _Nonnull error) {
            
        }];
}

- (void)bindPhoneWXUnionId
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_unionId forKey:@"unionId"];
    [body setObject:_phone forKey:@"phone"];
    [SVProgressHUD show];
    WS(weakSelf);
    [LoginNetWork getWXbindUnionIdWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            [GVUserDefaults standardUserDefaults].firstEnter = 11;
            [GVUserDefaults standardUserDefaults].firstInfoEnter = 11;
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            }];
        }else{
            
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
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
