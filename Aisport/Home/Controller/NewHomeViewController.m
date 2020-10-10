//
//  NewHomeViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "NewHomeViewController.h"
#import "TimeActivityTableViewCell.h"
#import "HomeSectionTableViewCell.h"
#import "TwoImageTableViewCell.h"
#import "OneImageTableViewCell.h"
#import "ThreeSlideTableViewCell.h"
#import "CarouselTableViewCell.h"
#import "HomeBannerView.h"
#import "HomeSearchVController.h"
#import "ASTrainNetwork.h"
#import "TagVideosViewController.h"
#import "LeaderBandViewController.h"
#import "HomeNetworkManager.h"
#import "TimeActivityTableViewCell.h"
#import "NewVideoDetailViewController.h"

@interface NewHomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *searchBgView;

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) HomeBannerView *bannerView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *jingxuanList;
@property (nonatomic, strong) NSArray *activityList;
@property (nonatomic, strong) NSArray *recentlyList;

@property (nonatomic, strong) NSArray *zunbaList;
@property (nonatomic, strong) NSArray *jingdianList;
@property (nonatomic, strong) NSArray *hotterList;



@end

@implementation NewHomeViewController
{
    BOOL isFirstEnter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isFirstEnter = YES;
    
    [self ceateView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self headerRefreshAction];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)headerRefreshAction
{
    [self getHomeBanner];
    [self getHomeRecommenVideoData];
    [self getRecentlyList];
    [self getActivityList];
    [self getTagVideoList];
    
}

- (void)goSearchVc
{
    HomeSearchVController *vc = [[HomeSearchVController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)moreAction:(int)type
{
    TagVideosViewController *vc = [TagVideosViewController new];
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)bannerAction:(id)data
{
    
}

- (void)activityAction:(NSInteger)type
{
    if (type == 0) {
        // 倒计时活动
    } else if (type == 1) {
        // 排行榜
        LeaderBandViewController *vc = [LeaderBandViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (type == 2) {
        // 快速匹配
    }
    
}

- (void)detailAction:(id)data type:(NSInteger)type
{
    if (type == 0) {
        // 嗨动精选
    } else if (type == 1) {
        // 近期上新
    } else if (type == 2) {
        // 尊巴
    } else if (type == 3) {
        // 日韩
    } else if (type == 4) {
        // 欧美
    }
    
    NewVideoDetailViewController *vc = [NewVideoDetailViewController new];
    vc.videoCode = [NSString stringWithFormat:@"%@", data[@"code"]];
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark -

- (void)loadData
{
    NSMutableArray *dataList = [NSMutableArray array];
    // 广告
    [self configActivityCell:dataList];
    
    // 嗨动精选 凸显滚动
    [self configHaidongCell:dataList];
    
    // 近期上线 滑动 三列
    [self configRecentCell:dataList];
    
    // 尊巴专题 2列
    [self configZunbaCell:dataList];
    
    // 日韩经典 1列
    [self configClassicCell:dataList];
    
    // 欧美热辣舞曲
    [self configHotterCell:dataList];
    
    
    self.dataList = dataList;
    [self.mainView reloadData];
    
}


- (void)configActivityCell:(NSMutableArray *)dataList
{
    NSArray *list = [NSArray arrayWithArray:self.activityList];
    if (![list count]) {
        return;
    }

    @weakify(self);
    void (^block) (NSInteger type) = ^(NSInteger type) {
        @strongify(self);
        [self activityAction:type];
    };
    
    // TimeActivityTableViewCell 排行榜
    // QuickMatchActivityTableViewCell 快速匹配
    
    id item = @{
        @"cls": QuickMatchActivityTableViewCell.class,
        @"h": @([QuickMatchActivityTableViewCell cellHeight]),
        @"data": @{
                @"block" :block,
                @"data": list,
        }
    };
    [dataList addObject:item];
}

- (void)configHaidongCell:(NSMutableArray *)dataList
{
    {
        id item = @{
            @"cls": HomeSectionTableViewCell.class,
            @"h": @([HomeSectionTableViewCell cellHeight]),
            @"data": @{
                    @"title": @"嗨动精选",
                    @"more": @(NO),
            }
        };
        [dataList addObject:item];
    }
    // list CarouselTableViewCell
    {
        NSArray *list = [NSArray arrayWithArray:self.jingxuanList];
        if (![list count]) {
            return;
        }
        @weakify(self);
        void (^block) (NSInteger index) = ^ (NSInteger index) {
            @strongify(self);
            id data = list[index];
            [self detailAction:data type:0];
        };
        
        id item = @{
            @"cls": CarouselTableViewCell.class,
            @"h": @([CarouselTableViewCell cellHeight]),
            @"data": @{
                @"data": list,
                @"block": block,
            }
        };
        [dataList addObject:item];
    }
}

- (void)configRecentCell:(NSMutableArray *)dataList
{
    {
        id item = @{
            @"cls": HomeSectionTableViewCell.class,
            @"h": @([HomeSectionTableViewCell cellHeight]),
            @"data": @{
                    @"title": @"近期上新",
                    @"more": @(NO),
                    
            }
        };
        [dataList addObject:item];
    }
    // list ThreeSlideTableViewCell
    {
        NSArray *list = [NSArray arrayWithArray:self.recentlyList];
        if (![list count]) {
            return;
        }

        @weakify(self);
        void (^block) (NSInteger index) = ^ (NSInteger index) {
            @strongify(self);
            id data = list[index];
            [self detailAction:data type:1];
        };
        
        id item = @{
            @"cls": ThreeSlideTableViewCell.class,
            @"h": @([ThreeSlideTableViewCell cellHeight]),
            @"data": @{
                    @"data":list,
                    @"block" : block,
            },

        };
        [dataList addObject:item];
    }
}

- (void)configZunbaCell:(NSMutableArray *)dataList
{
    {
        @weakify(self);
        void (^block) (void) = ^{
            @strongify(self);
            [self moreAction:2];
        };
        
        id item = @{
            @"cls": HomeSectionTableViewCell.class,
            @"h": @([HomeSectionTableViewCell cellHeight]),
            @"data": @{
                    @"title": @"尊巴专题",
                    @"more": @(YES),
                    @"block" : block,
            }
        };
        [dataList addObject:item];
    }
    // list TwoImageTableViewCell
    {
        [self configTwoCell:dataList sourceList:self.zunbaList type:2];
    }
}

- (void)configClassicCell:(NSMutableArray *)dataList
{
    {
        @weakify(self);
        void (^block) (void) = ^{
            @strongify(self);
            [self moreAction:3];
        };
        
        id item = @{
            @"cls": HomeSectionTableViewCell.class,
            @"h": @([HomeSectionTableViewCell cellHeight]),
            @"data": @{
                    @"title": @"日韩经典",
                    @"more": @(YES),
                    @"block" : block,
            }
        };
        [dataList addObject:item];
    }
    // list OneImageTableViewCell
    {
        NSArray *list = [NSArray arrayWithArray:self.jingdianList];
        @weakify(self);
        void (^block) (id data) = ^ (id data) {
            @strongify(self);
            [self detailAction:data type:3];
        };
        
        
        NSInteger count = [list count];
        // 最多限制4个
        if (count > 4) {
            count = 4;
        }
        
        for (int i = 0; i < count; i++) {
            id item = @{
                @"cls": OneImageTableViewCell.class,
                @"h": @([OneImageTableViewCell cellHeight]),
                @"data": @{
                        @"data": list[i],
                        @"block" : block,
                }
            };
            [dataList addObject:item];
        }
    }
}

- (void)configHotterCell:(NSMutableArray *)dataList
{
    {
        @weakify(self);
        void (^block) (void) = ^{
            @strongify(self);
            [self moreAction:4];
        };
        
        id item = @{
            @"cls": HomeSectionTableViewCell.class,
            @"h": @([HomeSectionTableViewCell cellHeight]),
            @"data": @{
                    @"title": @"欧美热辣舞曲",
                    @"more": @(YES),
                    @"block" : block,
            }
        };
        [dataList addObject:item];
    }
    // list TwoImageTableViewCell
    {
        [self configTwoCell:dataList sourceList:self.hotterList type:4];
    }
}

- (void)configTwoCell:(NSMutableArray *)dataList sourceList:(NSArray *)sourceList type:(int)type
{
    NSArray *list = [NSArray arrayWithArray:sourceList];

    NSInteger count = [list count];
    if (count <= 0) {
        return;
    }
    
    // 最多限制4个
    if (count > 4) {
        count = 4;
    }
    
    
    @weakify(self);
    void (^block) (id data) = ^ (id data) {
        @strongify(self);
        [self detailAction:data type:type];
    };
    
//    NSInteger row = ceilf(count/2.0);
    // 偶数显示
    NSInteger row = floorf(count/2.0);

    for (int i = 0; i < row; i++) {
        NSInteger index = i * 2;
        NSInteger len = MIN(2, count - index);
        NSArray *items = [list subarrayWithRange:NSMakeRange(i * 2, len)];
        
        id item = @{
            @"cls": TwoImageTableViewCell.class,
            @"h": @([TwoImageTableViewCell cellHeight]),
            @"data" : @{
                    @"data": items,
                    @"block": block,
            }
        };
        [dataList addObject:item];
    }
}

- (void)configBanner
{
    if (!self.headerView) {
        UIView *headerView = [[UIView alloc] init];
        headerView.width = SCR_WIDTH;
        headerView.height = UIValue(140 +13);
        CGFloat width = SCR_WIDTH - UIValue(32);
        _bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(UIValue(16), 0, width, UIValue(140))];
        [headerView addSubview:_bannerView];
        @weakify(self);
        _bannerView.selectBlock = ^(NSInteger index, id  _Nonnull data) {
            @strongify(self);
            [self bannerAction:data];
        };
        self.headerView = headerView;
    }
    
    if ([self.bannerList count]) {
        [self.bannerView fillData:self.bannerList];
        self.mainView.tableHeaderView = self.headerView;
    } else {
        self.mainView.tableHeaderView = nil;
    }
}

- (void)ceateView
{
    UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, (25+33+17.0/2)*2*Screen_Scale-20+StatusHeight)];
    [self.view addSubview:searchBgView];
    searchBgView.backgroundColor = [UIColor whiteColor];;
    _searchBgView = searchBgView;
    
    CGFloat searchWidth = SCR_WIDTH-15*2*2*Screen_Scale;
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(15*2*Screen_Scale, 25*2*Screen_Scale-20+StatusHeight, searchWidth, 33*Screen_Scale*2)];
    searchView.backgroundColor = [UIColor colorWithHex:@"#F8F8F8"];
    searchView.layer.cornerRadius = 33.0*Screen_Scale;
    searchView.layer.shadowColor = [UIColor colorWithHex:@"#ffffff" alpha:0.11].CGColor;
    searchView.layer.shadowOffset = CGSizeMake(0,0);
    searchView.layer.shadowRadius = 2;
    searchView.layer.shadowOpacity = 1;
    [self.view addSubview:searchView];
    
    UIImageView* searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 33.0*Screen_Scale-15.0*Screen_Scale, 15*2*Screen_Scale, 15*2*Screen_Scale)];
    searchImg.image = [UIImage imageNamed:@"home_search"];
    [searchView addSubview:searchImg];
    
    UITextField *searchTf = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, searchWidth - 25, 33*2*Screen_Scale)];
    searchTf.font = FontR(15);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索视频" attributes:
                                      @{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#999999"],
                                        NSFontAttributeName:searchTf.font
                                        }];
    searchTf.attributedPlaceholder = attrString;
//    searchTf.delegate = self;
    searchTf.userInteractionEnabled = NO;
    
    [searchView addSubview:searchTf];
    
    UITapGestureRecognizer *tapSearchGester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSearchVc)];
    [searchView addGestureRecognizer:tapSearchGester];

    
    
    
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, searchView.bottom+17*2*Screen_Scale/2, SCR_WIDTH, SCR_HIGHT - SafeAreaBottomHeight-((25+33+17.0/2)*2*Screen_Scale-20+StatusHeight)) style:UITableViewStylePlain];
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
    
    [self.view addSubview:_mainView];
    
    
    

}

#pragma mark -
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
    NSInteger row = indexPath.row;
    id item = [self.dataList objectAtIndex:row];
    return [item[@"h"] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    id item = [self.dataList objectAtIndex:row];
    id data = item[@"data"];
    Class cls = item[@"cls"];
    BaseTableViewCell *cell = [cls dequeueReusableWith:tableView];
    [cell fillData:data];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(1, (offsetY) / (25+33+17.0/2)*2*Screen_Scale);
    _searchBgView.backgroundColor = [UIColor colorWithHex:@"#ffffff" alpha:1.0-alpha];
    if (alpha >= 1) {
        _searchBgView.backgroundColor = [UIColor whiteColor];
    }
    NSLog(@"----%f",alpha);
}

#pragma mark - Network
- (void)getHomeBanner
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:@"1" forKey:@"current"];

    [ASTrainNetwork getHomeBannerWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.bannerList = data;
                [self configBanner];
            }
        }
        
    } andFailerFn:^(NSError * _Nonnull error) {
        [self configBanner];
    }];
    
//https://dev-gateway.hidbb.com/ai/video/recommend
}

// 嗨动精选
- (void)getHomeRecommenVideoData
{
    [ASTrainNetwork getRecommend2With:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.jingxuanList = data;
                
                [self loadData];
            }
        }

    } andFailerFn:^(NSError * _Nonnull error) {
        [self loadData];

    }];
}

// 活动
- (void)getActivityList
{
    
    [HomeNetworkManager getActivityWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.activityList = data;
                
                [self loadData];
            }
        }

    } andFailerFn:^(NSError * _Nonnull error) {
        [self loadData];

    }];
}

// 标签视频
- (void)getRecentlyList
{
    // 近期上新
    [HomeNetworkManager getRecentlyWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.recentlyList = data;
                
                [self loadData];
            }
        }

    } andFailerFn:^(NSError * _Nonnull error) {
        [self loadData];

    }];
}

- (void)getTagVideoList
{
    if (isFirstEnter) {
        [SVProgressHUD show];
        isFirstEnter = NO;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tagId"] = @(12);
    
    [HomeNetworkManager getVideosWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                
                self.zunbaList = data;
                self.jingdianList = data;
                self.hotterList = data;

                [self loadData];
            }
        }
        
        [SVProgressHUD dismiss];
        [self.mainView.mj_header endRefreshing];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self loadData];

        [self.mainView.mj_header endRefreshing];
    }];
}




@end
