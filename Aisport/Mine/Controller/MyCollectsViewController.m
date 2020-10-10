//
//  MyCollectsViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "MyCollectsViewController.h"
#import "MyTrainNetwork.h"
#import "RecentJumpTableViewCell.h"
#import "NewVideoDetailViewController.h"

@interface MyCollectsViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation MyCollectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收藏";
    
    [self setMainView];
    [self headerRefreshAction];
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
        [weakSelf headerRefreshAction];
        
    }];
    _mainView = mainView;
 
    [self.mainView showEmptyView];

}

- (void)headerRefreshAction
{
    [self getMyPlayList];
    
}

- (void)getMyPlayList
{
    [SVProgressHUD show];
    [MyTrainNetwork getMyVideoCollectListWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.dataList = data;
                
                if([self.dataList count]) {
                    [self.mainView hideEmptyView];
                } else {
                    [self.mainView showEmptyView];

                }

                
                [self.mainView reloadData];
            }
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
    return [RecentJumpTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    RecentJumpTableViewCell *cell = [RecentJumpTableViewCell dequeueReusableWith:tableView];
    NSDictionary *data = [self.dataList objectAtIndex:row];
    [cell fillData:data];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary *data = [self.dataList objectAtIndex:row];

    NewVideoDetailViewController *vc = [NewVideoDetailViewController new];
    vc.videoCode = [NSString stringWithFormat:@"%@", data[@"code"]];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
