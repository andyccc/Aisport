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

@interface InputCodeController ()

@property (nonatomic, strong) NSMutableArray *numberTFArray;

@end

@implementation InputCodeController

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
    phoneLabel.text = @"13345975890";
    
    
    _numberTFArray = [NSMutableArray arrayWithCapacity:0];
    CGFloat codeW = (SCR_WIDTH - 46*2*Screen_Scale*2 - 25*3)/4;
    for (int i = 0; i < 4; i++) {
        UITextField *codeTF = [[UITextField alloc] initWithFrame:CGRectMake(46*2*Screen_Scale+(codeW+25)*i, subLabel.bottom+41, codeW, codeW)];
        [self.view addSubview:codeTF];
        codeTF.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        codeTF.textColor = [UIColor colorWithHex:@"#333333"];
        codeTF.font = fontApp(23);
//        phoneTF.placeholder = @"输入手机号码";
        codeTF.textAlignment = NSTextAlignmentCenter;
        codeTF.layer.cornerRadius = 2;
        codeTF.clipsToBounds = YES;
        codeTF.keyboardType = UIKeyboardTypeNumberPad;
        
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
    [sureCodeBtn setBackgroundColor:[UIColor colorWithHex:@"#40CDBD"]];
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
    [body setObject:_phone forKey:@"phone"];
    [body setObject:code forKey:@"code"];
    
    
//    [[CommonNetworkManager share] postWithUrl:@"ai/hidouserinfo/register" body:body success:^(NSDictionary * _Nonnull response) {
//
//        } failure:^(NSError * _Nonnull error) {
//
//        }];

    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
////    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

//    WS(weakSelf);
//    [SVProgressHUD show];
//    [LoginNetWork registerUserWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
//        [SVProgressHUD dismiss];
//        if (ResponseSuccess) {
//            PerfectInfoController *vc = [[PerfectInfoController alloc] init];
//            vc.phone = weakSelf.phone;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
////            [SVProgressHUD showInfoWithStatus:[NSString stringForId:responseBefore[@"msg"]]];
//
//            PerfectInfoController *vc = [[PerfectInfoController alloc] init];
//            vc.phone = weakSelf.phone;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        } andFailerFn:^(NSError * _Nonnull error) {
//
//        }];
    
    PerfectInfoController *vc = [[PerfectInfoController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)clickReGetCodeBtn
{
    
}

- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
        }else{
            [textF1 becomeFirstResponder];
        }
    }else if (textField == textF2){
        if (textF2.text.length >= 1) {
            [textF3 becomeFirstResponder];
        }else{
            [textF1 becomeFirstResponder];
        }
    }else if (textField == textF3){
        if (textF3.text.length >= 1) {
            [textF4 becomeFirstResponder];
        }else{
            [textF2 becomeFirstResponder];
        }
    }else if (textField == textF4){
        if (textF4.text.length < 1) {
            [textF3 becomeFirstResponder];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
