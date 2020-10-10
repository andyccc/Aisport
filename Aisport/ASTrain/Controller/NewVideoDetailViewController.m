//
//  NewVideoDetailViewController.m
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import "NewVideoDetailViewController.h"
#import "VideoDetailHeaderView.h"
#import "VideoDetailNameCell.h"
#import "VideoDetailIntroductionCell.h"
#import "VideoDetailParameterCell.h"
#import "VideoDetailBankTitleCell.h"
#import "VideoDetailBankListCell.h"
#import "VideoDetailGrowthListCell.h"
#import "VideoDetailBottomView.h"
#import "AsTrainVideoDetailNetwork.h"
#import "VideoDetailInfoModel.h"
#import "VideoDetailRankListModel.h"
#import "VideoDetailGrowthListModel.h"
#import "ShowShareBtnView.h"

#define FIX_CELL_COUNT 4

@interface NewVideoDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) BOOL isShowIntroduction; //是否展开简介
@property (nonatomic, assign) BOOL isBankList; //是否是排行榜列表
@property (nonatomic, strong) VideoDetailBottomView *bottomView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) VideoDetailInfoModel *videoInfoModel;
@property (nonatomic, strong) NSMutableArray *rannkList;
@property (nonatomic, strong) NSMutableArray *growList;
@property (nonatomic, strong) VideoDetailRankListModel *rankListModel;

@property (nonatomic, strong) UIView *shareBgView;
@property (nonatomic, strong) ShowShareBtnView *showShareBtnView;

@end

@implementation NewVideoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.shareBtn];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.shareBgView];
    [self.view addSubview:self.showShareBtnView];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)backBtnClick:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)shareBtnClick:(UIButton *)btn
{
    [self showShareView];
}

#pragma mark - 分享方法
- (void)handleShareWechatWithIndex:(NSInteger)index
{
//    UIImage *image = [self imageWithUIView:self.courseShareView.backImageView];
//    if (index > 0) {
//        [[WechatShareManager shareInstance] shareImageToWechatWithImage:image AndShareType:index-1];
//    }else{
//        [self saveShareCourseImage];
//    }
    
}

-(void)showShareView
{
    self.shareBgView.hidden = NO;
    WS(weakSelf);
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.showShareBtnView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, -140);
    } completion:nil];
}

-(void)dismissSharetView
{
    WS(weakSelf);
    [UIView animateWithDuration:.2 animations:^{
        weakSelf.showShareBtnView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    } completion:^(BOOL finished) {
        if(finished)
        {
            weakSelf.shareBgView.hidden = YES;
        }
    }];
}

- (void)loadData
{
    self.isShowIntroduction = NO;
    self.isBankList = YES;
    [self requestVideoInfo];
    [self requestList];
}

- (void)requestList
{
    if (self.isBankList) {
        [self requestRankList];
    } else {
        [self requestGrowList];
    }
}

#pragma mark - 请求视频详情
- (void)requestVideoInfo
{
    NSMutableDictionary *bobyDic = [NSMutableDictionary dictionary];
    [bobyDic setObject:self.videoCode forKey:@"code"];
    WS(weakSelf);
    [SVProgressHUD show];
    [AsTrainVideoDetailNetwork getVideoInfo:bobyDic AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if (responseAfter && [responseAfter isKindOfClass:[NSDictionary class]]) {
                weakSelf.videoInfoModel = [[VideoDetailInfoModel alloc] initWithDictionary:responseAfter error:nil];
                [weakSelf.tableView reloadData];
                [self.bottomView fillData:weakSelf.videoInfoModel.isCollected.boolValue];
                return;
            }
        }
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - 请求排行榜
- (void)requestRankList
{
    NSMutableDictionary *bobyDic = [NSMutableDictionary dictionary];
    [bobyDic setObject:self.videoCode forKey:@"code"];
    [SVProgressHUD show];
    [AsTrainVideoDetailNetwork getVideoDetailRank:bobyDic AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if (responseAfter && [responseAfter isKindOfClass:[NSDictionary class]]) {
                self.rankListModel = [[VideoDetailRankListModel alloc] initWithDictionary:responseAfter error:nil];
                self.rannkList = [NSMutableArray arrayWithArray:self.rankListModel.list];
                
                if ([self.rannkList count]) {
                    [self.tableView hideEmptyView];
                } else {
                    [self.tableView showEmptyView];
                    self.tableView.emptyView.centerY =  self.tableView.height / 2.0 + self.tableView.emptyView.iconImageView.height;

                }
                
                [self.tableView reloadData];
                return;
            }
        }
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - 请求成长列表
- (void)requestGrowList
{
    NSMutableDictionary *bobyDic = [NSMutableDictionary dictionary];
    [bobyDic setObject:self.videoCode forKey:@"videoCode"];
    [SVProgressHUD show];
    [AsTrainVideoDetailNetwork getVideoDetailMyGrowing:bobyDic AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if (responseAfter && [responseAfter isKindOfClass:[NSArray class]]) {
                self.growList = [VideoDetailGrowthListModel arrayOfModelsFromDictionaries:responseAfter error:nil];
                
                if ([self.growList count]) {
                    [self.tableView hideEmptyView];
                } else {
                    [self.tableView showEmptyView];
                    self.tableView.emptyView.centerY =  self.tableView.height / 2.0 + self.tableView.emptyView.iconImageView.height;
                }

                
                [self.tableView reloadData];
                return;
            }
        }
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

#pragma mark - 收藏
- (void)colloectionVideo
{
    [SVProgressHUD show];
    [AsTrainVideoDetailNetwork collectionVideo:self.videoCode AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            self.videoInfoModel.isCollected = self.videoInfoModel.isCollected.boolValue ? @(0):@(1);
            [self.bottomView fillData:self.videoInfoModel.isCollected.boolValue];
            return;
        }
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //1:视频名称 2、视频简介 3、难度系数  4、排行榜 5、排行榜列表
    NSInteger count = self.isBankList ? self.rannkList.count : self.growList.count;
    return 4 + count ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row  = indexPath.row;
    if (row == 0) {
        return [VideoDetailNameCell cellHeight];
    } else if (row == 1) {
        NSString *temp = self.videoInfoModel.content;
        NSString *content = [NSString stringWithFormat:@"简介：%@", temp];
        return self.isShowIntroduction ? [VideoDetailIntroductionCell cellHeight:content] : 0;
    } else if (row == 2) {
        return [VideoDetailParameterCell cellHeight];
    }else if (row == 3) {
        return [VideoDetailBankTitleCell cellHeight];
    } else {
        return self.isBankList ? [VideoDetailBankListCell cellHeihgt] : [VideoDetailGrowthListCell cellHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [VideoDetailHeaderView cellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    VideoDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"VideoDetailHeaderView"];
    if (!headerView) {
        headerView = [[VideoDetailHeaderView alloc] initWithReuseIdentifier:@"VideoDetailHeaderView"];
    }
    [headerView fillData:self.videoInfoModel];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        return [self configNamCell:tableView cellForRowAtIndexPath:indexPath];
    } else if (row == 1) {
        return [self configIntroductionCell:tableView cellForRowAtIndexPath:indexPath];
    } else if (row == 2) {
        return [self configParmasCell:tableView cellForRowAtIndexPath:indexPath];
    } else if (row == 3) {
        return [self configBankTitleCell:tableView cellForRowAtIndexPath:indexPath];
    } else {
        if (self.isBankList) {
            return [self configBankListCell:tableView cellForRowAtIndexPath:indexPath];
        } else {
            return [self configGrowthListCell:tableView cellForRowAtIndexPath:indexPath];
        }
    }
}

- (UITableViewCell *)configNamCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoDetailNameCell"];
    if (!cell) {
        cell = [[VideoDetailNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoDetailNameCell"];
    }
    [cell fillData:self.videoInfoModel withShowIntroduction:self.isShowIntroduction];
    WS(weakSelf)
    cell.showIntroductionBlock = ^{
        weakSelf.isShowIntroduction = !weakSelf.isShowIntroduction;
        [weakSelf.tableView reloadData];
    };
    return cell;
}

- (UITableViewCell *)configIntroductionCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoDetailIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoDetailIntroductionCell"];
    if (!cell) {
        cell = [[VideoDetailIntroductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoDetailIntroductionCell"];
    }
    [cell fillData:self.videoInfoModel];
    return cell;
}

- (UITableViewCell *)configParmasCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailParameterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoDetailParameterCell"];
    if (!cell) {
        cell = [[VideoDetailParameterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoDetailParameterCell"];
    }
    [cell fillData:self.videoInfoModel];
    return cell;
}

- (UITableViewCell *)configBankTitleCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailBankTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoDetailBankTitleCell"];
    if (!cell) {
        cell = [[VideoDetailBankTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoDetailBankTitleCell"];
    }
    [cell fillData:self.videoInfoModel isBankList:self.isBankList];
    WS(weakSelf)
    cell.showBankListBlock = ^(BOOL isBank) {
        weakSelf.isBankList = isBank;
        [self requestList];
        [weakSelf.tableView reloadData];
    };
    return cell;
}

- (UITableViewCell *)configBankListCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoDetailBankListCell"];
    if (!cell) {
        cell = [[VideoDetailBankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoDetailBankListCell"];
    }
    NSInteger index = indexPath.row - FIX_CELL_COUNT;
    NSDictionary *dic = [self.rannkList objectAtIndex:index];
    [cell fillData:dic withIndex:index];
    return cell;
}

- (UITableViewCell *)configGrowthListCell:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailGrowthListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoDetailGrowthListCell"];
    if (!cell) {
        cell = [[VideoDetailGrowthListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoDetailGrowthListCell"];
    }
    NSInteger index = indexPath.row - FIX_CELL_COUNT;
    VideoDetailGrowthListModel *model = [self.growList objectAtIndex:index];
    [cell fillData:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(-StatusHeight, 0, iPhoneXBottomHeight + self.bottomView.height, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame =CGRectMake(4, StatusHeight, 50, 50);
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setImage:[UIImage imageNamed:@"back_btn_icon"] forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame =CGRectMake(0, StatusHeight, 50, 50);
        _shareBtn.right = SCR_WIDTH - 4;
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (VideoDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[VideoDetailBottomView alloc] initWithFrame:CGRectMake(0, SCR_HIGHT-iPhoneXBottomHeight-UIValue(50), SCR_WIDTH, UIValue(50))];
        _bottomView.backgroundColor = [UIColor clearColor];
        WS(weakSelf);
        _bottomView.collectionVideoBlock = ^{
            [weakSelf colloectionVideo];
        };
        _bottomView.danceActionBlock = ^{
            //去跳舞吧
            
        };
    }
    return _bottomView;
}

- (UIView *)shareBgView
{
    if (!_shareBgView) {
        _shareBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _shareBgView.backgroundColor = [UIColor blackColor];
        _shareBgView.alpha = 0.5;
        _shareBgView.hidden = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSharetView)];
        [_shareBgView addGestureRecognizer:tap];
    }
    return _shareBgView;
}

- (ShowShareBtnView *)showShareBtnView
{
    if (!_showShareBtnView) {
        _showShareBtnView = [[ShowShareBtnView alloc] initWithFrame:CGRectMake(0, SCR_HIGHT, SCR_WIDTH, 141)];
        _showShareBtnView.backgroundColor = [UIColor whiteColor];
        WS(weakSelf);
        _showShareBtnView.clickShareBlock = ^(NSInteger index) {
            [weakSelf handleShareWechatWithIndex:index];
            [weakSelf dismissSharetView];
        };
    }
    return _showShareBtnView;
}

@end
