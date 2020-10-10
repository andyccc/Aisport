//
//  SettingViewController.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "SettingViewController.h"
#import "SettinCentreViewCell.h"
#import "AlertVC.h"
#import "SystemMethods.h"
#import "AboutViewController.h"
#import "MyAddressViewController.h"
#import "SDImageCache.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SettingViewController
{
    __block CGFloat _totalSize;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置中心";
    self.view.backgroundColor = [UIColor colorWithHex:@"#f8f8f7"];
    [self loadData];
    [self setMainView];
    
}

- (void)calcCache
{
    @weakify(self);
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        @strongify(self);
        self -> _totalSize = totalSize;
        [self loadData];
    }];

}

- (void)loadData
{
    self.dataArray = [NSMutableArray array];
    SettinCentreViewCellData *data1 = [SettinCentreViewCellData new];
    data1.titleStr = @"我的收获地址";
    data1.tag = Adress_Cell_Tag;
    [self.dataArray addObject:data1];
    
    SettinCentreViewCellData *data2 = [SettinCentreViewCellData new];
    data2.titleStr = @"关于我们";
    data2.tag = About_Us_Cell_Tag;
    [self.dataArray addObject:data2];
    
    SettinCentreViewCellData *data3 = [SettinCentreViewCellData new];
    data3.titleStr = @"清除缓存";
    data3.contentStr =
    (_totalSize >= 1 ? [NSString stringWithFormat:@"%.2fM", _totalSize] : [NSString stringWithFormat:@"%.2fK", _totalSize * 1024]);
    
    data3.tag = Clear_Cache_Cell_Tag;
    [self.dataArray addObject:data3];
    
    SettinCentreViewCellData *data4 = [SettinCentreViewCellData new];
    data4.titleStr = @"检查更新";
    data4.tag = Check_Update_Cell_Tag;
    data4.contentStr = [SystemMethods SystemGetSoftVersion];
    [self.dataArray addObject:data4];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    mainView.tableFooterView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor clearColor];
    _mainView = mainView;
    
    
    UIButton *loginOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+78*2*Screen_Scale*self.dataArray.count + 13, SCR_WIDTH, 62)];
    [self.view addSubview:loginOutBtn];
    [loginOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [loginOutBtn setTitleColor:[UIColor colorWithHex:@"#FE6047"] forState:UIControlStateNormal];
    [loginOutBtn setBackgroundColor:[UIColor colorWithHex:@"#ffffff"]];
    loginOutBtn.titleLabel.font = fontBold(15);
    [loginOutBtn addTarget:self action:@selector(clickLoginOutBtn) forControlEvents:UIControlEventTouchUpInside];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettinCentreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettinCentreViewCell"];
    if (cell == nil) {
        cell = [[SettinCentreViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettinCentreViewCell"];
    }
    SettinCentreViewCellData *data = self.dataArray[indexPath.row];
    [cell fillData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78*2*Screen_Scale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettinCentreViewCellData *data = self.dataArray[indexPath.row];
    if (data.tag == Adress_Cell_Tag) {
        MyAddressViewController *vc = [MyAddressViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (data.tag == About_Us_Cell_Tag) {
        [self gotoAboutUs:data];
    } else if (data.tag == Clear_Cache_Cell_Tag) {
        @weakify(self);
        [SVProgressHUD show];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [SVProgressHUD showSuccessWithStatus:@"已清理"];
            @strongify(self);
            self -> _totalSize = 0;
            [self loadData];
        }];
        
    } else if (data.tag == Check_Update_Cell_Tag) {
        NSString *url = @"https://apps.apple.com/cn/app/%E5%97%A8%E5%8A%A8ai/id1537049249";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
        
        }];
    }
}

#pragma mark - 关于我们
- (void)gotoAboutUs:(SettinCentreViewCellData *)data
{
    AboutViewController *vc = [AboutViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickLoginOutBtn
{
   
    AlertVC *alv = [[AlertVC alloc] initWithType:0 andTitle:@"是否退出登录？" andMessage:nil and:@[@"退出登录"] and:^(UIAlertAction *action) {
        [GVUserDefaults standardUserDefaults].phone = @"";
        [GVUserDefaults standardUserDefaults].access_token = nil;
        [GVUserDefaults standardUserDefaults].nickName = @"";
        [GVUserDefaults standardUserDefaults].sex = @"";
        [GVUserDefaults standardUserDefaults].cover = @"";
        [GVUserDefaults standardUserDefaults].expires_in = nil;
        appDelegate.loginNav.modalPresentationStyle = 0;
        [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:^{
            [self.navigationController popToRootViewControllerAnimated:NO];
            appDelegate.baseTabbar.selectedIndex = 0;
        }];
        
    
    }];
    [self presentViewController:alv animated:YES completion:nil];
}

@end
