//
//  HomeViewController.m
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import "HomeViewController.h"
#import "TRClassDetailViewController.h"
#import "CardStaticView.h"
#import "HomeListViewCell.h"
#import "ASTrainNetwork.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) CardStaticView *staticView;
@property (nonatomic, strong) UIImageView *classImageView;

@property (nonatomic, strong) UITableView *mainView;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *dataSource;;

@end

@implementation HomeViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    _currentPage = 0;
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [_mainView.mj_header beginRefreshing];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
    WS(weakSelf);
    mainView.mj_header = [JXRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf getHomeCourseWithPage:1 AndRefresh:0];
    }];
    mainView.mj_footer = [JXRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf getHomeCourseWithPage:_currentPage+1 AndRefresh:1];
    }];
    _mainView = mainView;
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 254*2*Screen_Scale+4*2*Screen_Scale)];
    
    _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 254*2*Screen_Scale)];
    [headView addSubview:_bannerImageView];
    _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bannerImageView.clipsToBounds = YES;
    _bannerImageView.image = [UIImage imageNamed:@"home_banner"];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-150/2, StatusHeight + 7, 150, 30)];
    [self.view addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = fontBold(16);
    titleLabel.text = @"嗨动AI";
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _bannerImageView.bottom-14*2*Screen_Scale, SCR_WIDTH, 18*2*Screen_Scale)];
    [headView addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    CAShapeLayer *mask=[CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:bottomView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft  cornerRadii:CGSizeMake(16,16)];
    mask.path = path.CGPath;
    mask.frame = bottomView.bounds;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = path.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    //        borderLayer.strokeColor = [UIColor colorWithHex:@"#FDAB00"].CGColor;
    //        borderLayer.lineWidth = 1;
    borderLayer.frame = bottomView.bounds;
    bottomView.layer.mask = mask;
    [bottomView.layer addSublayer:borderLayer];
    
    
    mainView.tableHeaderView = headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListViewCell"];
    if (cell == nil) {
        cell = [[HomeListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeListViewCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    WS(weakSelf);
    cell.homeCellJumpBlock = ^{
        TRClassDetailViewController *vc = [[TRClassDetailViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.model = self.dataSource[indexPath.row];
//    cell.type = _type;
//    TaskHomeModel *model = _dataSource[indexPath.row];
//    cell.model = model;
//    cell.editBtn.hidden = YES;
//    cell.deleteBtn.hidden = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 97+6+146*2*Screen_Scale+10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListModel *model = self.dataSource[indexPath.row];
    TRClassDetailViewController *vc = [[TRClassDetailViewController alloc] init];
    vc.codeId = StringForId(model.courseCode);
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getHomeCourseWithPage:(NSInteger)page AndRefresh:(int)refresh
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"current"];
    
    WS(weakSelf);
    [ASTrainNetwork getHomeCourseWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if(ResponseSuccess){
            NSArray* temp = responseAfter[@"records"];
            weakSelf.currentPage = [NSString stringForId:responseAfter[@"current"]].integerValue;
            
            if (refresh == 0) {
                [weakSelf.dataSource removeAllObjects];
                [weakSelf.mainView.mj_header endRefreshing];
                [weakSelf.mainView.mj_footer resetNoMoreData];
            }else {
                if(temp.count != 0)
                {
                    [weakSelf.mainView.mj_footer endRefreshing];
                }else{
                    [weakSelf.mainView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            for (NSDictionary * dict in temp) {
                HomeListModel * model = [[HomeListModel alloc] initWithDictionary:dict error:nil];
                model.descriptionStr = StringForId(dict[@"description"]);
                [weakSelf.dataSource addObject:model];
            }
            
        }else{
            if ([StringForId(responseAfter) isEqualToString:@""]) {
                [SVProgressHUD showInfoWithStatus:@"发生未知错误"];
            }else{
                [SVProgressHUD showInfoWithStatus:StringForId(responseAfter)];
            }
            [weakSelf.mainView.mj_header endRefreshing];
            [weakSelf.mainView.mj_footer endRefreshing];
        }
//        [_emptyView showEmptyViewWithData:_dataSource];
        [weakSelf.mainView reloadData];
    } andFailerFn:^(NSError * _Nonnull error) {
        [weakSelf.mainView.mj_header endRefreshing];
        [weakSelf.mainView.mj_footer endRefreshing];
        
    }];
}


- (BOOL)prefersStatusBarHidden {
    
    return YES;
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
