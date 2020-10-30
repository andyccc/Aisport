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
    
    _icons = @[@"mine_order",@"mine_medal",@"mine_collection",@"mine_aboutme",@"mine_setting"].mutableCopy;
    _titles = @[@"训练记录",@"勋章墙",@"收藏",@"关于我们",@"设置中心"].mutableCopy;
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self postGetUserInfo];
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
    _mainView = mainView;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 136*2*Screen_Scale)];
    headView.backgroundColor = [UIColor whiteColor];
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(21*2*Screen_Scale, headView.height/2-73*Screen_Scale, 73*2*Screen_Scale, 73*2*Screen_Scale)];
    [headView addSubview:_iconImageView];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    _iconImageView.layer.cornerRadius = 73*Screen_Scale;
    _iconImageView.clipsToBounds = YES;
//    _iconImageView.image = [UIImage imageNamed:@"home_banner"];
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId([GVUserDefaults standardUserDefaults].cover)] placeholderImage:nil];
    
    
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImageView.right+15*2*Screen_Scale, headView.height/2-73*Screen_Scale, headView.width-_iconImageView.right-15*2*2*Screen_Scale-20, 73*2*Screen_Scale)];
    [headView addSubview:_nickLabel];
    _nickLabel.textAlignment = NSTextAlignmentLeft;
    _nickLabel.textColor = [UIColor colorWithHex:@"#443C48"];
    _nickLabel.font = fontBold(17);
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
    if (indexPath.row == 0) {
        //训练记录
        CommonWebController *web = [[CommonWebController alloc] init];
        web.title = _titles[indexPath.row];
        web.url = [NSString stringWithFormat:@"%@%@",Host_Url_Web,@"trainRecord"];
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 1){
        //勋章墙
        CommonWebController *web = [[CommonWebController alloc] init];
        web.title = _titles[indexPath.row];
        web.url = [NSString stringWithFormat:@"%@%@",Host_Url_Web,@"medalWall"];
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 2){
        //收藏
        CommonWebController *web = [[CommonWebController alloc] init];
        web.title = _titles[indexPath.row];
        web.url = [NSString stringWithFormat:@"%@%@",Host_Url_Web,@"collection"];
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 3){
        //关于我们
        CommonWebController *web = [[CommonWebController alloc] init];
        web.title = _titles[indexPath.row];
        web.url = [NSString stringWithFormat:@"%@%@",Host_Url_Web,@"aboutUs"];
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 4){
        //设置中心
        SettingViewController *vc = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)postGetUserInfo
{
//    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    
    WS(weakSelf);
    [SVProgressHUD show];
    [LoginNetWork getUserInfoWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            [GVUserDefaults standardUserDefaults].cover = StringForId(responseAfter[@"cover"]);
            [GVUserDefaults standardUserDefaults].nickName = StringForId(responseAfter[@"nickName"]);
//            [GVUserDefaults standardUserDefaults].phone = StringForId(responseAfter[@"phone"]);
            [GVUserDefaults standardUserDefaults].sex = StringForId(responseAfter[@"sex"]);
            [weakSelf.iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(responseAfter[@"cover"])] placeholderImage:nil];
            weakSelf.nickLabel.text = StringForId(responseAfter[@"nickName"]);
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
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
