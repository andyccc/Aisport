//
//  TagVideosViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "TagVideosViewController.h"
#import "HomeNetworkManager.h"
#import "TwoImageTableViewCell.h"
#import "NewVideoDetailViewController.h"

@interface TagVideosViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSArray *videoList;

@end

@implementation TagVideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.type == 2) {
        self.title = @"尊巴专题";
    } else if (self.type == 3) {
        self.title = @"日韩经典";
    } else if (self.type == 4) {
        self.title = @"欧美热辣舞曲";
    }

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
    

    
}

- (void)headerRefreshAction
{
    [self getVideoList];
    
    
}

- (void)detailAction:(id)data
{
    if (self.type == 2) {
       // 尊巴
   } else if (self.type == 3) {
       // 日韩
   } else if (self.type == 4) {
       // 欧美
   }

    NewVideoDetailViewController *vc = [NewVideoDetailViewController new];
    vc.videoCode = [NSString stringWithFormat:@"%@", data[@"code"]];

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData
{
    NSMutableArray *dataList = [NSMutableArray array];
    
    NSInteger count = [self.videoList count];
    if (count > 0) {
        @weakify(self);
        void (^block) (id data) = ^ (id data) {
            @strongify(self);
            [self detailAction:data];
        };

        
        NSInteger row = ceilf(count/2.0);
        
        for (int i = 0; i < row; i++) {
            NSInteger index = i * 2;
            NSInteger len = MIN(2, count - index);
            NSArray *items = [self.videoList subarrayWithRange:NSMakeRange(i * 2, len)];
            
            id item = @{
                @"cls": TwoImageTableViewCell.class,
                @"h": @([TwoImageTableViewCell cellHeight]),
                @"data": @{
                        @"data": items,
                        @"block" : block,
                }
            };
            [dataList addObject:item];
            
        }
        [self.mainView hideEmptyView];
    } else {
        [self.mainView showEmptyView];
    }
    
    self.dataList = dataList;
    
    [self.mainView reloadData];
}

- (void)getVideoList
{
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tagId"] = @(12);
    
    [HomeNetworkManager getVideosWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.videoList = data;
            }
        }
        
        [SVProgressHUD dismiss];
        [self.mainView.mj_header endRefreshing];
        [self loadData];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self.mainView.mj_header endRefreshing];
        [self loadData];
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
    return [TwoImageTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    TwoImageTableViewCell *cell = [TwoImageTableViewCell dequeueReusableWith:tableView];
    NSDictionary *data = [self.dataList objectAtIndex:row];
    [cell fillData:data[@"data"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary *data = [self.dataList objectAtIndex:row];
    [self detailAction:data[@"data"]];
}


@end
