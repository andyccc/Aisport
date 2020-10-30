//
//  PerfectInfoController.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "PerfectInfoController.h"
#import "AddPicView.h"
#import "ZBImagePicker.h"
#import "LoginNetWork.h"

@interface PerfectInfoController ()

@property (nonatomic, strong) UIButton *manButton;
@property (nonatomic, strong) UIButton *womanButton;
@property (nonatomic, strong) NSString *headPicUrl;
@property (nonatomic, strong) UITextField *nickNameTF;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation PerfectInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

- (void)setMainView
{
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-88*Screen_Scale, SafeAreaTopHeight+21, 88*2*Screen_Scale, 92*2*Screen_Scale)];
    [self.view addSubview:iconImageView];
    iconImageView.image = [UIImage imageNamed:@"login_addPic"];
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.clipsToBounds = YES;
    _iconImageView = iconImageView;
    
    UIButton *addHeadPicBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-88*Screen_Scale, SafeAreaTopHeight+21, 88*2*Screen_Scale, 92*2*Screen_Scale)];
    [self.view addSubview:addHeadPicBtn];
    [addHeadPicBtn addTarget:self action:@selector(clickAddHeadPicBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *nickTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, addHeadPicBtn.bottom+44, SCR_WIDTH-26*2, 16)];
    [self.view addSubview:nickTitleLabel];
    nickTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    nickTitleLabel.font = fontBold(16);
    nickTitleLabel.textAlignment = NSTextAlignmentCenter;
    nickTitleLabel.text = @"输入昵称";
    
    UITextField *nickNameTF = [[UITextField alloc] initWithFrame:CGRectMake(91*2*Screen_Scale, nickTitleLabel.bottom+20, SCR_WIDTH-91*2*Screen_Scale*2, 48)];
    [self.view addSubview:nickNameTF];
    nickNameTF.backgroundColor = [UIColor colorWithHex:@"#ECECEC"];
    nickNameTF.textColor = [UIColor colorWithHex:@"#333333"];
    nickNameTF.font = fontApp(14);
    nickNameTF.placeholder = @"请输入您的昵称";
    nickNameTF.textAlignment = NSTextAlignmentCenter;
    nickNameTF.layer.cornerRadius = 48/2;
    nickNameTF.clipsToBounds = YES;
    _nickNameTF = nickNameTF;
    
    UILabel *sexTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, nickNameTF.bottom+60, SCR_WIDTH-26*2, 16)];
    [self.view addSubview:sexTitleLabel];
    sexTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    sexTitleLabel.font = fontBold(16);
    sexTitleLabel.textAlignment = NSTextAlignmentCenter;
    sexTitleLabel.text = @"选择性别";
    
    UIView *sexBgView = [[UIView alloc] initWithFrame:CGRectMake(91*2*Screen_Scale, sexTitleLabel.bottom+20, SCR_WIDTH-91*2*Screen_Scale*2, 48)];
    [self.view addSubview:sexBgView];
    sexBgView.backgroundColor = [UIColor colorWithHex:@"#ECECEC"];
    sexBgView.layer.cornerRadius = 48.0/2;
    sexBgView.clipsToBounds = YES;
    
    UIButton *manButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sexBgView.width/2, 48)];
    [sexBgView addSubview:manButton];
    [manButton setTitle:@"男士" forState:UIControlStateNormal];
    [manButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
    [manButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [manButton setImage:[UIImage imageNamed:@"login_man_nor"] forState:UIControlStateNormal];
    [manButton setImage:[UIImage imageNamed:@"login_man_sel"] forState:UIControlStateSelected];
    [manButton setBackgroundColor:[UIColor colorWithHex:@"#ECECEC"] forState:UIControlStateNormal];
    [manButton setBackgroundColor:[UIColor colorWithHex:@"#40CDBD"] forState:UIControlStateSelected];
    manButton.titleLabel.font = fontApp(14);
    manButton.layer.cornerRadius = 48.0/2;
    manButton.clipsToBounds = YES;
    [manButton addTarget:self action:@selector(clickManButton:) forControlEvents:UIControlEventTouchUpInside];
    [manButton layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    _manButton = manButton;
    
    UIButton *womanButton = [[UIButton alloc] initWithFrame:CGRectMake(sexBgView.width/2, 0, sexBgView.width/2, 48)];
    [sexBgView addSubview:womanButton];
    [womanButton setTitle:@"女士" forState:UIControlStateNormal];
    [womanButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
    [womanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [womanButton setImage:[UIImage imageNamed:@"login_woman_nor"] forState:UIControlStateNormal];
    [womanButton setImage:[UIImage imageNamed:@"login_woman_sel"] forState:UIControlStateSelected];
    [womanButton setBackgroundColor:[UIColor colorWithHex:@"#ECECEC"] forState:UIControlStateNormal];
    [womanButton setBackgroundColor:[UIColor colorWithHex:@"#FF8989"] forState:UIControlStateSelected];
    womanButton.titleLabel.font = fontApp(14);
    womanButton.layer.cornerRadius = 48.0/2;
    womanButton.clipsToBounds = YES;
    [womanButton addTarget:self action:@selector(clickWomanButton:) forControlEvents:UIControlEventTouchUpInside];
    [womanButton layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleLeft imageTitleSpace:6];
    _womanButton = womanButton;
    
    UIButton *sureInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(47*2*Screen_Scale, sexBgView.bottom+52, SCR_WIDTH-47*2*Screen_Scale*2, 48)];
    [self.view addSubview:sureInfoBtn];
    [sureInfoBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureInfoBtn setBackgroundColor:[UIColor colorWithHex:@"#40CDBD"]];
    sureInfoBtn.titleLabel.font = fontBold(18);
    sureInfoBtn.layer.cornerRadius = 48.0/2;
    sureInfoBtn.clipsToBounds = YES;
    [sureInfoBtn addTarget:self action:@selector(clickSureInfoBtn) forControlEvents:UIControlEventTouchUpInside];

}

- (void)clickAddHeadPicBtn
{
    [self.view endEditing:YES];
    WS(weakSelf);
    [[AddPicView shareAddPicView] addPicViewWithPicCount:1 ViewController:self IsCrop:NO AddPicBlock:^(NSArray * _Nonnull picUrlArr) {
        weakSelf.headPicUrl = picUrlArr[0];
        [weakSelf.iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(picUrlArr[0])] placeholderImage:nil];
        
    }];
    
//    ZBImagePicker *zbimagePicker = [ZBImagePicker imagePicker];
//    [zbimagePicker showImagePickerDataSourceOptionsTitle:@"头像" InController:self ImageCanEdit:YES Result:^(BOOL result, UIImage *image) {
//        if (result) {
////            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
////            [[ZBImageUploader imageUploader] uploadUImage:image Result:^(BOOL success, NSString *resultString) {
////                if (resultString) {
////                    [[userInfoManager shareUserManager] updateUserAvatar:resultString];
////                }
//
////                [_hud hideAnimated:YES];
////                _hud = nil;
////            }];
//        }
//    }];
    
}

- (void)clickManButton:(UIButton *)sender
{
    [self.view endEditing:YES];
    _manButton.selected = YES;
    _womanButton.selected = NO;
}

- (void)clickWomanButton:(UIButton *)sender
{
    [self.view endEditing:YES];
    _manButton.selected = NO;
    _womanButton.selected = YES;
}

- (void)clickSureInfoBtn
{
    [self.view endEditing:YES];
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        [self.navigationController popToRootViewControllerAnimated:NO];
//    }];
    
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    if ([StringForId(_headPicUrl) isEqual:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请选择头像"];
        return;
    }
    [body setObject:_phone forKey:@"phone"];
    [body setObject:_headPicUrl forKey:@"cover"];
    if ([StringForId(_nickNameTF.text) isEqual:@""]) {
        [SVProgressHUD showInfoWithStatus:@"请输入昵称"];
        return;
    }
    [body setObject:_nickNameTF.text forKey:@"nickName"];

    //0 男。1 女
    if (_manButton.selected) {
        [body setObject:@"0" forKey:@"sex"];
    }else if (_womanButton.selected){
        [body setObject:@"1" forKey:@"sex"];
    }else{
        [SVProgressHUD showInfoWithStatus:@"请选择性别"];
        return;
    }

    [SVProgressHUD show];
    [LoginNetWork completeUserInfoWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [self.navigationController popToRootViewControllerAnimated:NO];
            }];
        }else
        {
            [SVProgressHUD showInfoWithStatus:[NSString stringForId:responseBefore[@"msg"]]];
        }
        } andFailerFn:^(NSError * _Nonnull error) {

        }];
    
    
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
