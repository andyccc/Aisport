//
//  SettingViewController.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "SettingViewController.h"
#import "SettinCentreViewCell.h"
#import "AlertVC.h"
#import "AppDelegate.h"
#import "LoginNetWork.h"
#import "AddPicView.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic,strong)NSMutableArray *titles, *subTitles;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置中心";
    self.view.backgroundColor = [UIColor whiteColor];

    _titles = @[@"头像",@"性别",@"昵称",@"手机号"].mutableCopy;
    _subTitles = @[@"",@"男",@"天涯",@"1527389679"].mutableCopy;
    
    [self setMainView];
    
    [self.view endEditing:YES];
    // Do any additional setup after loading the view.
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].cover) forKey:@"cover"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].nickName) forKey:@"nickName"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].phone) forKey:@"phone"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].sex) forKey:@"sex"];

    [SVProgressHUD show];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    [LoginNetWork fixUserInfoWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            
            [SVProgressHUD showInfoWithStatus:@"修改成功"];
        }else
        {
            [SVProgressHUD dismiss];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}



- (void)setMainView
{
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
    [self.view addSubview:mainView];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainView.estimatedRowHeight = 0;
    mainView.estimatedSectionFooterHeight = 0;
    mainView.estimatedSectionHeaderHeight = 0;
    mainView.scrollEnabled = NO;
    _mainView = mainView;
    
    
    UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 50*4+(SCR_HIGHT-50*4-SafeAreaTopHeight)/2-48/2, SCR_WIDTH-16*2*Screen_Scale*2, 48)];
    [self.view addSubview:loginOutBtn];
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOutBtn setTitleColor:[UIColor colorWithHex:@"#F22E2E"] forState:UIControlStateNormal];
    [loginOutBtn setBackgroundColor:[UIColor colorWithHex:@"#F2F2F2"]];
    loginOutBtn.titleLabel.font = fontBold(16);
    loginOutBtn.layer.cornerRadius = 48.0/2;
    loginOutBtn.clipsToBounds = YES;
    [loginOutBtn addTarget:self action:@selector(clickLoginOutBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettinCentreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettinCentreViewCell"];
    if (cell == nil) {
        cell = [[SettinCentreViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettinCentreViewCell"];
    }
    cell.index = indexPath.row;
    cell.titleLab.text = _titles[indexPath.row];
    
    cell.iconImageView.hidden = YES;
    cell.subTf.hidden = NO;
    cell.subTf.userInteractionEnabled = YES;
    if (indexPath.row == 0) {
        cell.iconImageView.hidden = NO;
        cell.subTf.hidden = YES;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId([GVUserDefaults standardUserDefaults].cover)] placeholderImage:nil];
    }else if (indexPath.row == _titles.count-1){
        cell.subTf.userInteractionEnabled = NO;
//        cell.subTf.text = _subTitles[indexPath.row];
        cell.subTf.text = StringForId([GVUserDefaults standardUserDefaults].phone);
        [self.view endEditing:YES];
    }else if (indexPath.row == 1){
        [cell.subTf becomeFirstResponder];
        cell.subTf.text = [GVUserDefaults standardUserDefaults].sex == 0 ? @"男":@"女";
    }else{
        [cell.subTf becomeFirstResponder];
        cell.subTf.text = StringForId([GVUserDefaults standardUserDefaults].nickName);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*2*Screen_Scale;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //头像
        [self.view endEditing:YES];
        WS(weakSelf);
        [[AddPicView shareAddPicView] addPicViewWithPicCount:1 ViewController:self IsCrop:NO AddPicBlock:^(NSArray * _Nonnull picUrlArr) {
            [GVUserDefaults standardUserDefaults].cover = picUrlArr[0];
            [weakSelf.mainView reloadData];
            
        }];
    }else if (indexPath.row == 1){
        //性别
    }else if (indexPath.row == 2){
        //昵称
    }else{
        [self.view endEditing:YES];
    }
//    TRClassDetailViewController *vc = [[TRClassDetailViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickLoginOutBtn
{
   
    AlertVC *alv = [[AlertVC alloc] initWithType:0 andTitle:@"是否退出登录？" andMessage:nil and:@[@"退出登录"] and:^(UIAlertAction *action) {
        [GVUserDefaults standardUserDefaults].phone = @"";
        [GVUserDefaults standardUserDefaults].access_token = @"";
        
        appDelegate.loginNav.modalPresentationStyle = 0;
        [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:nil];
        [self.navigationController popToRootViewControllerAnimated:NO];
        appDelegate.baseTabbar.selectedIndex = 0;
    
    }];
    [self presentViewController:alv animated:YES completion:nil];
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
