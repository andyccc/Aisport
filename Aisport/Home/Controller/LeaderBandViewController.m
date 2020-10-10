//
//  LeaderBandViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "LeaderBandViewController.h"
#import "LeaderBandRankingTableViewCell.h"
#import "LeaderBandTitleView.h"
#import "HomeNetworkManager.h"

@interface LeaderBandViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSDictionary *myRank;
@property (nonatomic, strong) RankingView *myRankView;

@end

@implementation LeaderBandViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"舞王排行榜";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F4F4F4"];

    [self setMainView];
    [self headerRefreshAction];

}
- (void)setMainView
{
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCR_WIDTH, SCR_HIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
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
        [weakSelf headerRefreshAction];
        
    }];
    _mainView = mainView;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.width = SCR_WIDTH;
    headerView.backgroundColor = [UIColor whiteColor];
    UIImageView *bannerView = [[UIImageView alloc] init];
    bannerView.height = UIValue(169);
    bannerView.width = SCR_WIDTH;
    bannerView.image = [UIImage imageNamed:@"leader_band_banner"];
    bannerView.clipsToBounds = YES;
    [headerView addSubview:bannerView];
    
    LeaderBandTitleView *titleView = [[LeaderBandTitleView alloc] initWithFrame:CGRectMake(0, bannerView.bottom - UIValue(18), SCR_WIDTH, UIValue(18 + 22 + 13))];
    [headerView addSubview:titleView];
    headerView.height = titleView.bottom;
    _mainView.tableHeaderView = headerView;
    
    _myRankView = [[RankingView alloc] initWithFrame:CGRectMake(0, UIScreenHeight - SafeAreaBottomHeight , SCR_WIDTH, UIValue(82))];
    _myRankView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_myRankView];
}

- (void)headerRefreshAction
{
    [self getRankingList];
    
}

- (void)setMyCurrentRank
{
    if (!self.myRank) {
        return;
    }
    
    NSInteger rank = [self.myRank[@"rank"] integerValue];
    [self.myRankView setNumber:rank];
    self.myRankView.nickLabel.text = self.myRank[@"nickName"];
    [self.myRankView.avatarView sd_setImageWithURL:[NSURL URLWithString:self.myRank[@"headImage"]]];
    self.myRankView.eggsLabel.text = [self.myRank[@"total"] description];
}

- (void)getRankingList
{
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"propsId"] = @(1);
    [HomeNetworkManager getRankingListWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter[@"rankList"];
            self.myRank = responseAfter[@"myRank"];
            if (data && [data isKindOfClass:NSArray.class]) {
                self.dataList = data;
            }
            [self setMyCurrentRank];
            [self.mainView reloadData];
        }

        [SVProgressHUD dismiss];
        [self.mainView.mj_header endRefreshing];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self.mainView.mj_header endRefreshing];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LeaderBandRankingTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    LeaderBandRankingTableViewCell *cell = [LeaderBandRankingTableViewCell dequeueReusableWith:tableView];
    NSDictionary *data = [self.dataList objectAtIndex:row];
    [cell fillData:data];
    [cell setRankIndex:row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;

}

@end
