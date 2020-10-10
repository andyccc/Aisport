//
//  MineViewController.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "MineViewController.h"
#import "MineTitleIconViewCell.h"
#import "SettingViewController.h"
#import "LoginNetWork.h"
#import "CommonWebController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nickLabel;

@property (nonatomic,strong)NSMutableArray* icons,* titles;

@end

@implementation MineViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
   // ,@"mine_medal" //,@"勋章墙"
    _icons = @[@"mine_aboutme",@"mine_setting"].mutableCopy;//@"mine_order",@"mine_collection",
    _titles = @[@"关于我们",@"设置中心"].mutableCopy;//@"练习记录",@"收藏",
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([GVUserDefaults standardUserDefaults].firstInfoEnter == 11) {
        [self postGetUserInfo];
        [GVUserDefaults standardUserDefaults].firstInfoEnter = 0;
    }
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]) {
        appDelegate.loginNav.modalPresentationStyle = 0;
        appDelegate.baseTabbar.selectedIndex = 0;
        [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:nil];
//        [self.navigationController popToRootViewControllerAnimated:NO];
        return;
    }
}

- (void)setMainView
{
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
    [self.view addSubview:mainView];
    mainView.delegate = self;
    mainView.dataSource = self;
//    mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainView.estimatedRowHeight = 0;
    mainView.estimatedSectionFooterHeight = 0;
    mainView.estimatedSectionHeaderHeight = 0;
    mainView.tableFooterView = [[UIView alloc] init];
    WS(weakSelf);
    mainView.mj_header = [JXRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf postGetUserInfo];
        
    }];
    _mainView = mainView;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 136*2*Screen_Scale)];
    headView.backgroundColor = [UIColor whiteColor];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21*2*Screen_Scale, headView.height/2-73*Screen_Scale, 73*2*Screen_Scale, 73*2*Screen_Scale)];
    [headView addSubview:_iconImageView];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.layer.cornerRadius = 73*Screen_Scale;
    _iconImageView.clipsToBounds = YES;
//    _iconImageView.image = [UIImage imageNamed:@"home_banner"];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId([GVUserDefaults standardUserDefaults].cover)] placeholderImage:[UIImage imageNamed:@"home_hejipic"]];
    
    
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right+15*2*Screen_Scale+6*2*Screen_Scale, headView.height/2-73*Screen_Scale, headView.width-_iconImageView.right-15*2*2*Screen_Scale-20, 73*2*Screen_Scale)];
    [headView addSubview:_nickLabel];
    _nickLabel.textAlignment = NSTextAlignmentLeft;
    _nickLabel.textColor = [UIColor colorWithHex:@"#443C48"];
    _nickLabel.font = fontBold(20);
    _nickLabel.numberOfLines = 0;
    _nickLabel.text = StringForId([GVUserDefaults standardUserDefaults].nickName);
    
    mainView.tableHeaderView = headView;
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
    MineTitleIconViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTitleIconViewCell"];
    if (cell == nil) {
        cell = [[MineTitleIconViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineTitleIconViewCell"];
    }
    cell.titleLab.text = _titles[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:_icons[indexPath.row]];
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
    if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]) {
        
    }
    if (indexPath.row == 0){
        //关于我们
        CommonWebController *web = [[CommonWebController alloc] init];
        web.title = _titles[indexPath.row];
        web.url = [NSString stringWithFormat:@"%@%@?token=%@",Host_Url_Web,@"aboutUs",[GVUserDefaults standardUserDefaults].access_token];
//        web.url = [NSString stringWithFormat:@"%@%@",Host_Url_Web,@"aboutUs"];
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 1){
        //设置中心
        SettingViewController *vc = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
//    else if (indexPath.row == 1){
//        //勋章墙
//        CommonWebController *web = [[CommonWebController alloc] init];
//        web.title = _titles[indexPath.row];
//        web.url = [NSString stringWithFormat:@"%@%@?token=%@",Host_Url_Web,@"trainingMedalWall",[GVUserDefaults standardUserDefaults].access_token];
//        [self.navigationController pushViewController:web animated:YES];
//    }
//    if (indexPath.row == 0) {
//        //训练记录
//        CommonWebController *web = [[CommonWebController alloc] init];
//        web.title = _titles[indexPath.row];
//        web.url = [NSString stringWithFormat:@"%@%@?token=%@",Host_Url_Web,@"trainingRecord",[GVUserDefaults standardUserDefaults].access_token];
//        [self.navigationController pushViewController:web animated:YES];
//    }else if (indexPath.row == 1){
//        //收藏
//        CommonWebController *web = [[CommonWebController alloc] init];
//        web.title = _titles[indexPath.row];
//        web.url = [NSString stringWithFormat:@"%@%@?token=%@",Host_Url_Web,@"trainingCollection",[GVUserDefaults standardUserDefaults].access_token];
//        [self.navigationController pushViewController:web animated:YES];
//    }else
    
}

- (void)postGetUserInfo
{
//    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    
    WS(weakSelf);
    [SVProgressHUD setBorderWidth:0];
    [SVProgressHUD show];
    [LoginNetWork getUserInfoWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if (![StringForId(responseAfter) isEqual:@""]) {
                [GVUserDefaults standardUserDefaults].cover = StringForId(responseAfter[@"cover"]);
                [GVUserDefaults standardUserDefaults].nickName = StringForId(responseAfter[@"nickName"]);
    //            [GVUserDefaults standardUserDefaults].phone = StringForId(responseAfter[@"phone"]);
                [GVUserDefaults standardUserDefaults].sex = StringForId(responseAfter[@"sex"]);
                [weakSelf.iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(responseAfter[@"cover"])] placeholderImage:[UIImage imageNamed:@"home_hejipic"]];
                weakSelf.nickLabel.text = StringForId(responseAfter[@"nickName"]);
            }
            
        }
        [weakSelf.mainView.mj_header endRefreshing];
    } andFailerFn:^(NSError * _Nonnull error) {
        [weakSelf.mainView.mj_header endRefreshing];
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
