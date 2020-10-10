//
//  NewMineViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import "NewMineViewController.h"
#import "ScoreInfoTableViewCell.h"
#import "InviteTableViewCell.h"
#import "MenusTableViewCell.h"
#import "CollectsTableViewCell.h"
#import "SettingViewController.h"
#import "LoginNetWork.h"
#import "ProfileViewController.h"
#import "MyTrainNetwork.h"
#import "RecentJumpViewController.h"
#import "MyBagViewController.h"
#import "MyScoreViewController.h"
#import "ScoreShopViewController.h"
#import "MyCollectsViewController.h"
#import "InviteViewController.h"

#import "MyAddressViewController.h"


@interface NewMineViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainView;

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UIImageView *arrowIcon;

@property (nonatomic, assign) int winTotal;
@property (nonatomic, assign) int winRate;
@property (nonatomic, assign) int maxScore;
@property (nonatomic, assign) int videoTotal;
@property (nonatomic, strong) NSString *cover;


@end

@implementation NewMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHex:@"#F4F4F4"];
    
    [self setRightNavBtnWithIcon:@"icon_setting"];
 
    [self setMainView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefreshAction];
    
    if (IS_LOGINED) {
        _nickLabel.text = StringForId([GVUserDefaults standardUserDefaults].nickName);
    } else {
        _nickLabel.text = @"未登录";
    }

}

- (void)rightNavBtnAction
{
    CHECK_LOGIN();

    SettingViewController *vc = [SettingViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)profileAction
{
    CHECK_LOGIN();
    
    ProfileViewController *vc = [ProfileViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)menusAction:(NSInteger)index
{
    CHECK_LOGIN();

    if (index == 0) {
        // 最近跳过
        RecentJumpViewController *vc = [RecentJumpViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (index == 1) {
        // 我的背包
        MyBagViewController *vc = [MyBagViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (index == 2) {
        // 积分明细
        MyScoreViewController *vc = [MyScoreViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (index == 3) {
        // 积分商城
        ScoreShopViewController *vc = [ScoreShopViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (UIView *)headerView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 136*2*Screen_Scale)];
    headView.backgroundColor = self.view.backgroundColor;

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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileAction)];
    [_nickLabel addGestureRecognizer:tap];
    _nickLabel.userInteractionEnabled = YES;
    
    _arrowIcon = [[UIImageView alloc] init];
    _arrowIcon.width = uiv(6);
    _arrowIcon.height = uiv(11);
    _arrowIcon.image = [UIImage imageNamed:@"icon_arrow"];
    _arrowIcon.centerY = _iconImageView.centerY;
    _arrowIcon.right = UIScreenWidth - uiv(23);
    [headView addSubview:_arrowIcon];
    
    return headView;
}


- (void)setMainView
{
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
    mainView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:mainView];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainView.estimatedRowHeight = 0;
    mainView.estimatedSectionFooterHeight = 0;
    mainView.estimatedSectionHeaderHeight = 0;
    mainView.tableFooterView = [[UIView alloc] init];
    
    WS(weakSelf);
    mainView.mj_header = [JXRefreshHeader headerWithRefreshingBlock:^{
        [SVProgressHUD show];

        [weakSelf headerRefreshAction];
        
    }];
    _mainView = mainView;
    
    mainView.tableHeaderView = [self headerView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        ScoreInfoTableViewCell *cell = [ScoreInfoTableViewCell dequeueReusableWith:tableView];
        
        if (IS_LOGINED) {
            NSDictionary *data = @{
                @"winTotal":@(self.winTotal),
                @"winRate":@(self.winRate),
                @"maxScore":@(self.maxScore),
            };
            
            [cell fillData:data];
        } else {
            [cell fillData:nil];
        }
        
        
        return cell;
    } else if (row == 1 ) {
        InviteTableViewCell *cell = [InviteTableViewCell dequeueReusableWith:tableView];
        [cell fillData:nil];
        
        return cell;

    } else if (row == 2 ) {
        MenusTableViewCell *cell = [MenusTableViewCell dequeueReusableWith:tableView];
        @weakify(self);
        cell.btnBlock = ^(NSInteger index) {
            @strongify(self);
            [self menusAction:index];
        };
        return cell;

    } else if (row == 3 ) {
        CollectsTableViewCell *cell = [CollectsTableViewCell dequeueReusableWith:tableView];
        
        if (IS_LOGINED) {
            
            NSDictionary *data = @{
                @"cover": self.cover ? self.cover : @"",
                @"videoTotal":@(self.videoTotal),
            };
            
            [cell fillData:data];
        } else {
            [cell fillData:nil];

        }
        
        return cell;
    }
    
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        return [ScoreInfoTableViewCell cellHeight];
    } else if (row == 1 ) {
        return [InviteTableViewCell cellHeight];
    } else if (row == 2 ) {
        return [MenusTableViewCell cellHeight];
    } else if (row == 3 ) {
        return [CollectsTableViewCell cellHeight];
    }

    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CHECK_LOGIN();
    
    NSInteger row = indexPath.row;
    if (row == 1) {
        InviteViewController *vc = [InviteViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (row == 3){
        MyCollectsViewController *vc = [MyCollectsViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)headerRefreshAction
{
    if (!IS_LOGINED) {
        [self.mainView.mj_header endRefreshing];
        [self.mainView reloadData];
        return;
    }
    
    
    [self postGetUserInfo];
    [self requestMyCollectData];
    
}

- (void)postGetUserInfo
{
    WS(weakSelf);
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
        [SVProgressHUD dismiss];
        [self.mainView reloadData];
        [weakSelf.mainView.mj_header endRefreshing];
    }];
}

- (void)requestMyCollectData
{
    [MyTrainNetwork getMyCollectInfoWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            if (![StringForId(responseAfter) isEqual:@""]) {
                NSDictionary *myBattle = responseAfter[@"myBattle"];
                if (myBattle) {
                    self.winTotal = [myBattle[@"winTotal"] intValue];
                    self.winRate = [myBattle[@"winRate"] intValue] * 100;
                    self.maxScore = [myBattle[@"maxScore"] intValue];
                }
                self.cover = responseAfter[@"cover"];
                self.videoTotal = [responseAfter[@"videoTotal"] intValue];
                
                [self.mainView reloadData];
            }
        }
        
    } andFailerFn:^(NSError * _Nonnull error) {
        [self.mainView reloadData];
    }];
    
}


@end
