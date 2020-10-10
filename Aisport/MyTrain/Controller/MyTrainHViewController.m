//
//  MyTrainHViewController.m
//  Aisport
//
//  Created by Apple on 2020/11/10.
//

#import "MyTrainHViewController.h"
#import "EmptyListView.h"
//#import "WholePartVideoView.h"
//#import "MyWholeTrainLIstViewCell.h"
#import "ASTrainNetwork.h"
#import "MyTrainNetwork.h"
#import "LoadingSourceView.h"
#import "TRClassDetailViewController.h"
#import "VideoDetailWebController.h"

#import "MyTrainHViewCell.h"
#import "MyTrainVideoViewCell.h"
#import "Aisport-Swift.h"

@interface MyTrainHViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *noTodayTrLabel;
@property (nonatomic, strong) EmptyListView *emptyListView;
@property (nonatomic, strong) UIView *todayTrView;
//@property (nonatomic, strong) WholePartVideoView *wholeVideoView;

@property (nonatomic, strong) UITableView *mainView;

@property (nonatomic, strong) NSMutableArray *titleLabArr;

//@property (nonatomic, strong) NSMutableArray *wholeDataSource;
//@property (nonatomic, strong) NSMutableArray *wholeListSource;

@property (nonatomic, strong) NSMutableArray *videoColleSource;
@property (nonatomic, strong) NSMutableArray *videoHistorySource;

@property (nonatomic, assign) NSInteger requestNumber;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *recommendSource;

@property (nonatomic, strong) LoadingSourceView *loadingSourceView;

@end

@implementation MyTrainHViewController

- (NSMutableArray *)videoColleSource
{
    if (!_videoColleSource) {
        _videoColleSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _videoColleSource;
}

- (NSMutableArray *)videoHistorySource
{
    if (!_videoHistorySource) {
        _videoHistorySource = [NSMutableArray arrayWithCapacity:0];
    }
    return _videoHistorySource;
}

- (NSMutableArray *)recommendSource
{
    if (!_recommendSource) {
        _recommendSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _recommendSource;
}

- (NSMutableArray *)titleLabArr
{
    if (!_titleLabArr) {
        _titleLabArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleLabArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#ffffff"];
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    _requestNumber = 0;
    [self getMyTrainTodayTraininge];
    [self getMyVideoCollectList];
    [self getMyRecentlyPlayedList];
    
//    SpotFlake.
//    [self getMyTrainWholePartData];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setMainView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 68*2*Screen_Scale+21*2*Screen_Scale+StatusHeight)];
//    headView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    headView.backgroundColor = [UIColor colorWithHex:@"#ffffff"];
    
    UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, 21*2*Screen_Scale+StatusHeight, SCR_WIDTH-30*2*Screen_Scale, 68*2*Screen_Scale)];
    [headView addSubview:whiteBgView];
    whiteBgView.backgroundColor = [UIColor whiteColor];
    whiteBgView.layer.cornerRadius = 5;
//    whiteBgView.clipsToBounds = YES;
    whiteBgView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.08].CGColor;
    whiteBgView.layer.shadowOffset = CGSizeMake(0,0);
    whiteBgView.layer.shadowRadius = 4;
    whiteBgView.layer.shadowOpacity = 1;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 0, 44, whiteBgView.height)];
    [whiteBgView addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    titleLabel.font = fontBold(15);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.text = @"我的\n数据";

    UIView *vertView = [[UIView alloc] initWithFrame:CGRectMake(titleLabel.right, whiteBgView.height/2-32*Screen_Scale, 1, 32*2*Screen_Scale)];
    [whiteBgView addSubview:vertView];
    vertView.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    
    UIView *todayTrView = [[UIView alloc] initWithFrame:CGRectMake(vertView.right, 0, whiteBgView.width-vertView.right, whiteBgView.height)];
    [whiteBgView addSubview:todayTrView];
    _todayTrView = todayTrView;
    
    [self.titleLabArr removeAllObjects];
    NSArray *titleArr = @[@"嗨动天数",@"已玩视频数",@"最高得分"];
    NSArray *numArr = @[@"323",@"22",@"0"];
    for (int i = 0; i < titleArr.count; i++) {
        
        UILabel *numTiLab = [[UILabel alloc] initWithFrame:CGRectMake(todayTrView.width/3*i, 19*2*Screen_Scale, todayTrView.width/3, 11)];
        [todayTrView addSubview:numTiLab];
        numTiLab.textColor = [UIColor colorWithHex:@"#999999"];
        numTiLab.font = fontApp(11);
        numTiLab.textAlignment = NSTextAlignmentCenter;
        numTiLab.text = titleArr[i];
        
        UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(todayTrView.width/3*i, numTiLab.bottom+8, todayTrView.width/3, 15)];
        [todayTrView addSubview:numberLab];
        numberLab.textColor = [UIColor colorWithHex:@"#333333"];
        numberLab.font = fontBold(16);
        numberLab.textAlignment = NSTextAlignmentCenter;
        numberLab.text = numArr[i];
        [self.titleLabArr addObject:numberLab];
    }
    
    UILabel *noTodayTrLabel = [[UILabel alloc] initWithFrame:CGRectMake(vertView.right+25*2*Screen_Scale, 0, whiteBgView.width-vertView.right-25*2*Screen_Scale, whiteBgView.height)];
    [whiteBgView addSubview:noTodayTrLabel];
    noTodayTrLabel.textColor = [UIColor colorWithHex:@"#999999"];
    noTodayTrLabel.font = fontApp(11);
//    noTodayTrLabel.textAlignment = NSTextAlignmentCenter;
    noTodayTrLabel.text = @"还没有锻炼数据，快开始今天的锻炼吧~";
    _noTodayTrLabel = noTodayTrLabel;
    noTodayTrLabel.hidden = YES;
    
    
    
    
    EmptyListView *emptyListView = [[EmptyListView alloc] initWithFrame:CGRectMake(0, whiteBgView.bottom+83*2*Screen_Scale, SCR_WIDTH, (99+90)*2*Screen_Scale) AndType:0];
    [self.view addSubview:emptyListView];
    _emptyListView = emptyListView;
    emptyListView.hidden = YES;
    

    _mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:_mainView];
//    _mainView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    _mainView.backgroundColor = [UIColor colorWithHex:@"#ffffff"];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.tableFooterView = [[UIView alloc] init];
    _mainView.estimatedRowHeight = 0;
    _mainView.estimatedSectionFooterHeight = 0;
    _mainView.estimatedSectionHeaderHeight = 0;
    _mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainView.tableHeaderView = headView;
    _mainView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 20)];
    _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    WS(weakSelf);
//    _mainView.mj_header = [JXRefreshHeader headerWithRefreshingBlock:^{
////        [weakSelf postGetTeacherRemindDataWithPage:1 AndRefresh:0];
//    }];
//    _mainView.mj_footer = [JXRefreshFooter footerWithRefreshingBlock:^{
////        [weakSelf postGetTeacherRemindDataWithPage:_currentPage+1 AndRefresh:1];
//    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.videoHistorySource.count == 0 && self.videoColleSource.count != 0) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.videoColleSource.count > 0 ? self.videoColleSource.count : 1;
    }else{
        if (self.videoColleSource.count == 0 && self.videoHistorySource.count == 0) {
            return self.recommendSource.count;
        }
        return self.videoHistorySource.count > 0 ? self.videoHistorySource.count : 1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.videoColleSource.count == 0 && indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        cell.backgroundColor = tableView.backgroundColor;
        UIView *backBgView = [[UIView alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, 0, SCR_WIDTH-15*2*2*Screen_Scale, 170*2*Screen_Scale)];
        [cell addSubview:backBgView];
        backBgView.backgroundColor = [UIColor whiteColor];
        backBgView.layer.cornerRadius = 5;
        backBgView.clipsToBounds = YES;
        backBgView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.16].CGColor;
        backBgView.layer.shadowOffset = CGSizeMake(0,0);
        backBgView.layer.shadowRadius = 3;
        backBgView.layer.shadowOpacity = 1;
        
        EmptyListView *emptyListView = [[EmptyListView alloc] initWithFrame:CGRectMake(0, 28, SCR_WIDTH-30*2*Screen_Scale, (88+90)*2*Screen_Scale) AndType:1];
        [backBgView addSubview:emptyListView];
        cell.selected = NO;
        return cell;
    }else{
        MyTrainVideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTrainVideoViewCell"];
        if (cell == nil) {
            cell = [[MyTrainVideoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTrainVideoViewCell"];
        }
        cell.backgroundColor = tableView.backgroundColor;
        cell.isHome = NO;
        if (indexPath.section == 0) {
            TrainVideoModel *model = self.videoColleSource[indexPath.row];
            cell.videoModel = model;
            
        }else{
            if (self.videoColleSource.count == 0 && self.videoHistorySource.count == 0) {
                HomeListModel *model = self.recommendSource[indexPath.row];
                cell.homeModel = model;
            }else{
                TrainVideoModel *model = self.videoHistorySource[indexPath.row];
                cell.videoModel = model;
            }
            
        }
        cell.selected = NO;
        return cell;
    }
    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.videoColleSource.count == 0 && indexPath.section == 0) {
        return 170*2*Screen_Scale;
    }
    if (indexPath.section == 0 && self.videoColleSource.count-1 == indexPath.row) {
        return (100)*2*Screen_Scale;
    }else if (indexPath.section == 1 && self.videoHistorySource.count-1 == indexPath.row){
        return (100)*2*Screen_Scale;
    }
    return (100)*2*Screen_Scale+15*2*Screen_Scale;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 49)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, 0, headView.width-15*2*2*Screen_Scale, 49)];
    [headView addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    titleLabel.font = fontBold(17);
    
    if (section == 0) {
        titleLabel.text = @"我的收藏";
    }else{
        if (self.videoColleSource.count == 0 && self.videoHistorySource.count == 0) {
            titleLabel.text = @"推荐视频";
        }else{
            titleLabel.text = @"我跳过的";
        }
    }
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section

{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 0.01)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 49;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;

    if (indexPath.section == 0 && self.videoColleSource.count == 0){
        return;
    }

    VideoDetailWebController *web = [[VideoDetailWebController alloc] init];
//    web.title = _titles[indexPath.row];
    
    if (indexPath.section == 0 && self.videoColleSource.count != 0) {
        TrainVideoModel *model = self.videoColleSource[indexPath.row];
        web.codeId = StringForId(model.code);
        web.modelMd5 = StringForId(model.modelMd5);
//        web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code)];
        web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:StringForId(model.code)]) {
            web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=1",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
        }
        
    }else{
        if (self.videoHistorySource.count == 0 && self.videoColleSource.count == 0) {
            HomeListModel *model = self.recommendSource[indexPath.row];
            web.codeId = StringForId(model.code);
            web.modelMd5 = StringForId(model.modelMd5);
//            web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code)];
            web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
            if ([[NSUserDefaults standardUserDefaults] boolForKey:StringForId(model.code)]) {
                web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=1",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
            }
        }else{
            TrainVideoModel *model = self.videoHistorySource[indexPath.row];
            web.codeId = StringForId(model.code);
            web.modelMd5 = StringForId(model.modelMd5);
//            web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code)];
            web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
            if ([[NSUserDefaults standardUserDefaults] boolForKey:StringForId(model.code)]) {
                web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=1",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
            }
        }
        
    }
    
    web.fromType = 1;
    [self.navigationController pushViewController:web animated:YES];
}


- (void)upataTableView
{
    if (self.videoColleSource.count == 0 && self.videoHistorySource.count == 0) {
        WS(weakSelf);
        [weakSelf getMyRecommenVideoPageWithPage:1 AndRefresh:0];
        _mainView.mj_footer = [JXRefreshFooter footerWithRefreshingBlock:^{
            [weakSelf getMyRecommenVideoPageWithPage:weakSelf.currentPage+1 AndRefresh:1];
        }];
    }else{
        _mainView.mj_footer = nil;
    }
}

#pragma mark - 加载资源，开始训练
- (void)startLoadSourceAndTrainWithCodeId:(NSString *)codeId AndCid:(NSString *)cid
{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:codeId]) {
        [self.view addSubview:self.loadingSourceView];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:codeId]) {
       
        return;
    }
    
//    [GVUserDefaults standardUserDefaults].total = @"2350000";
//    [GVUserDefaults standardUserDefaults].complate = @"0";
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:codeId forKey:@"code"];
    CourseModel *model = [[CourseModel alloc] init];
    WS(weakSelf);
    [[CommonNetworkManager share] getVideoByCourseWithUrl:@"ai/video/getVideoByCode" andBody:body andSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:StringForId(responseAfter[@"name"]) forKey:[NSString stringWithFormat:@"name_%@",codeId]];
            [[NSUserDefaults standardUserDefaults] setObject:StringForId(responseAfter[@"url"]) forKey:[NSString stringWithFormat:@"url_%@",codeId]];
            [[NSUserDefaults standardUserDefaults] setObject:StringForId(responseAfter[@"code"]) forKey:[NSString stringWithFormat:@"code_%@",codeId]];
            model.name = StringForId(responseAfter[@"name"]);
            model.url = StringForId(responseAfter[@"url"]);
            model.code = StringForId(responseAfter[@"code"]);
            model.cid = cid;
        }
    } andFailer:^(NSError * _Nonnull error) {
        [weakSelf removeLoadingView];
    } andProgress:^(double value) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf progressSimulationWithProgress:value AndCodeId:codeId CourseModel:model];
        });
//        [self progressSimulationWithProgress:value];
       
        
    }];
}

- (LoadingSourceView *)loadingSourceView
{
    if (!_loadingSourceView) {
        _loadingSourceView = [[LoadingSourceView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _loadingSourceView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.5];
        WS(weakSelf);
        _loadingSourceView.cancleLoadingBlock = ^{
            [weakSelf removeLoadingView];
        };
    }
    
    return _loadingSourceView;
}

- (void)removeLoadingView
{
    if (!_loadingSourceView) {
        return;
    }
    for (UIView *view in _loadingSourceView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.loadingSourceView removeFromSuperview];
    self.loadingSourceView = nil;
    
}

- (void)progressSimulationWithProgress:(double)progress AndCodeId:(NSString *)codeId CourseModel:(CourseModel *)model
{
    if (progress < 1.0) {
        NSLog(@"%f",progress);;
        self.loadingSourceView.progressView.progress = progress;

    }else{
        if ([[NSUserDefaults standardUserDefaults] boolForKey:codeId]) {
            return;
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:StringForId(codeId)];
        [self removeLoadingView];
        
    }
}



#pragma mark - Network
- (void)getMyTrainTodayTraininge
{
    WS(weakSelf);
    [SVProgressHUD show];
    [MyTrainNetwork getmyDataWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            weakSelf.todayTrView.hidden = NO;
            weakSelf.noTodayTrLabel.hidden = YES;
            for (int i = 0; i < weakSelf.titleLabArr.count; i++) {
                UILabel *lab = weakSelf.titleLabArr[i];
                if (i == 0) {
                    lab.text = [NSString stringWithFormat:@"%@",StringNumForId(responseAfter[@"hidoTime"], @"0")];

                }else if (i == 1){
                    lab.text = StringNumForId(responseAfter[@"unlockVideoTotal"], @"0");
                }else{
                    lab.text = StringNumForId(responseAfter[@"maxScore"], @"0");
                }
            }
//            if (StringForId(responseAfter[@"total"]).intValue == 0) {
//                weakSelf.todayTrView.hidden = YES;
//                weakSelf.noTodayTrLabel.hidden = NO;
//            }else{
//
//            }
            
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}


- (void)getMyVideoCollectList
{
    [SVProgressHUD show];
    WS(weakSelf);
    [MyTrainNetwork getMyVideoCollectListWith:@{} AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            NSArray* temp = responseAfter;
            [weakSelf.videoColleSource removeAllObjects];
            for (NSDictionary *dict in temp) {
                TrainVideoModel *model = [[TrainVideoModel alloc] initWithDictionary:dict error:nil];
                [weakSelf.videoColleSource addObject:model];
            }
            weakSelf.requestNumber = weakSelf.requestNumber + 1;
            if (weakSelf.requestNumber >= 2) {
                [weakSelf upataTableView];
            }
            
            [weakSelf.mainView reloadData];
        }else{
            [SVProgressHUD dismiss];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getMyRecentlyPlayedList
{
    [SVProgressHUD show];
    WS(weakSelf);
    [MyTrainNetwork getMyRecentlyPlayedListWith:@{} AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            NSArray* temp = responseAfter[@"videoList"];
            [weakSelf.videoHistorySource removeAllObjects];
            for (NSDictionary *dict in temp) {
                TrainVideoModel *model = [[TrainVideoModel alloc] initWithDictionary:dict error:nil];
                [weakSelf.videoHistorySource addObject:model];
            }
            weakSelf.requestNumber = weakSelf.requestNumber + 1;
            if (weakSelf.requestNumber >= 2) {
                [weakSelf upataTableView];
            }
            [weakSelf.mainView reloadData];
        }else{
            [SVProgressHUD dismiss];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getMyRecommenVideoPageWithPage:(NSInteger)page AndRefresh:(int)refresh
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"current"];

    WS(weakSelf);
    [ASTrainNetwork getHomeWatchingVideoPageWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if(ResponseSuccess){
            NSArray* temp = responseAfter[@"records"];
            weakSelf.currentPage = [NSString stringForId:responseAfter[@"current"]].integerValue;

            if (refresh == 0) {
                [weakSelf.recommendSource removeAllObjects];
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
                [weakSelf.recommendSource addObject:model];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
