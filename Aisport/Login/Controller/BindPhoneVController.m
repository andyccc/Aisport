//
//  BindPhoneVController.m
//  Aisport
//
//  Created by Apple on 2020/12/2.
//

#import "BindPhoneVController.h"
#import "LoginNetWork.h"
#import "InputCodeController.h"

@interface BindPhoneVController ()

@property (nonatomic, strong) UITextField *phoneTF;

@end

@implementation BindPhoneVController

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
    [backButton addTarget:self action:@selector(backButtonBindClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(42*2*Screen_Scale, 54*2*Screen_Scale+SafeAreaTopHeight, SCR_WIDTH-42*2*Screen_Scale*2, 23)];
    [self.view addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    titleLabel.font = fontBold(23);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = @"请输入手机号";
    
    UITextField *phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(41*2*Screen_Scale, titleLabel.bottom+31, SCR_WIDTH-41*2*Screen_Scale*2, 48)];
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
    
}

- (void)backButtonBindClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickGetCodeBtn:(UIButton *)sender
{
    [self.view endEditing:YES];
    if (_phoneTF.text.length > 0 && _phoneTF.text.length < 12) {
        
        NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
        [body setObject:_phoneTF.text forKey:@"phone"];
        [body setObject:_unionId forKey:@"unionId"];
        [SVProgressHUD show];
        WS(weakSelf);
        [LoginNetWork getWXLoginWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [SVProgressHUD dismiss];
            if (ResponseSuccess) {
                BOOL registered = [responseAfter[@"registered"] boolValue];
                if (registered) {
                    InputCodeController *vc = [[InputCodeController alloc] init];
                    vc.phone = weakSelf.phoneTF.text;
                    vc.status = @"10"; //StringForId(responseAfter)
                    vc.unionId = weakSelf.unionId;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else{
                    InputCodeController *vc = [[InputCodeController alloc] init];
                    vc.phone = weakSelf.phoneTF.text;
                    vc.status = @"11"; //StringForId(responseAfter)
                    vc.unionId = weakSelf.unionId;
                    vc.nickname = weakSelf.nickname;
                    vc.headimgurl = weakSelf.headimgurl;
                    vc.sex = weakSelf.sex;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }

                NSLog(@"status-------------%@",StringForId(responseAfter));
                
            }
        } andFailerFn:^(NSError * _Nonnull error) {
            [SVProgressHUD dismiss];
        }];
    }
    
}

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
//            vc.status = weakSelf.status; //StringForId(responseAfter)
            [self.navigationController pushViewController:vc animated:YES];
        }
    } andFailerFn:^(NSError * _Nonnull error) {

    }];

}

- (void)getSendSmsCode
{
    WS(weakSelf);
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_phoneTF.text forKey:@"mobile"];
    [LoginNetWork getGetCodeWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            InputCodeController *vc = [[InputCodeController alloc] init];
            vc.phone = weakSelf.phoneTF.text;
//            vc.status = weakSelf.status;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _phoneTF.text = @"";
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
