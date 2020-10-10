//
//  HomeSearchVController.m
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import "HomeSearchVController.h"
#import "SearchView.h"
#import "SearchFlowLayout.h"
#import "SearchTableViewCell.h"
#import "SearchCollectionViewCell.h"
#import "SearchReusableView.h"
#import "ASTrainSearchNetwork.h"
#import "SearchResultsModel.h"

#define SEARCH_HISTORY_RECORDS_KEY @"SEARCH_HISTORY_RECORDS_KEY"

@interface HomeSearchVController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    NSString *searchStr;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *hotRecommendList;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) SearchResultsModel *searchResultsModel;
@property (nonatomic, strong) UIView *searchBgView;
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, assign) SEARCHER_VIEW_STATE searcherState;
@property (nonatomic, strong) UIButton *sortBtn;
@end

@implementation HomeSearchVController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.searchBgView];
    [self.view addSubview:self.searchView];
    [self.searchView becomeFirstResponder];
    [self getSearchDefaultData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark - 获取默认数据
- (void)getSearchDefaultData
{
    [self loadHistoryArray];
    [self requestHotRecommendList];
}

#pragma mark - 获取历史记录数据
- (void)loadHistoryArray
{
    NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_HISTORY_RECORDS_KEY];
    self.historyArray = [self obtainListArray:tempArray];
    [self.collectionView reloadData];
}

- (void)sortAction:(UIButton *)btn
{
    
}

#pragma mark - 获取热门搜索
- (void)requestHotRecommendList
{
    WS(weakSelf);
    [SVProgressHUD show];
    [ASTrainSearchNetwork getHotSearch:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            NSArray *temp = responseAfter;
            if ([temp isKindOfClass:[NSArray class]] && temp.count > 0) {
                weakSelf.hotRecommendList = [self obtainListArray:temp];
                [weakSelf.collectionView reloadData];
            }
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 解析搜索记录
- (NSMutableArray *)obtainListArray:(NSArray *)list
{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < list.count; i++) {
        NSString *content = list[i];
        if (content && content.length > 0) {
            CGFloat width = [content boundingRectWithSize:CGSizeMake(UIScreenWidth - UIValue(50), UIValue(30)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{ NSFontAttributeName : FontR(13)} context:nil].size.width + UIValue(10);
            NSDictionary *dic = @{
                @"content" : content,
                @"nameWidth" : @(width),
            };
            [tempArray addObject:dic];
        }
    }
    return tempArray;
}

#pragma mark - 关键字搜索
- (void)keyWordSearch
{
    self.tableView.hidden = NO;
    //接口
    if (!searchStr || searchStr.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入搜索内容"];
        return;
    }
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    [bodyDic setObject:searchStr forKey:@"nameKeyWord"];
    WS(weakSelf)
    [SVProgressHUD show];
    [ASTrainSearchNetwork keyWordSearch:bodyDic AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if (responseAfter && [responseAfter isKindOfClass:[NSDictionary class]]) {
                weakSelf.searchResultsModel = [[SearchResultsModel alloc] initWithDictionary:responseAfter error:nil];
                [weakSelf.tableView reloadData];
            }
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 清除搜索历史
- (void)clearSearchHistory
{
    [self.historyArray removeAllObjects];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SEARCH_HISTORY_RECORDS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.searchResultsModel.videoElementList.count;
    } else {
        return self.searchResultsModel.compilationsElementList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTableViewCell"];
    if (!cell)
    {
        cell = [[SearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SearchTableViewCell"];
    }
    VideoElementListModel *model;
    if (indexPath.section == 0) {
        model = self.searchResultsModel.videoElementListArray[indexPath.row];
    }
    [cell fillCell:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SearchTableViewCell rowHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - 添加搜索历史记录
- (void)addHistory:(NSString *)data
{
    if (!data || data.length == 0) {
        return;
    }
    for (int i = 0; i < self.historyArray.count; i++) {
        NSDictionary *obj = self.historyArray[i];
        if ([obj[@"content"] isEqualToString:data])
        {
            return;
        }
    }
    CGFloat width = [data boundingRectWithSize:CGSizeMake(UIScreenWidth - UIValue(50), UIValue(30)) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{ NSFontAttributeName : FontR(13)} context:nil].size.width + UIValue(10);
    NSDictionary *dic = @{
        @"content" : data,
        @"nameWidth" : @(width),
    };
    [self.historyArray insertObject:dic atIndex:0];
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    NSArray *tempArray = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_HISTORY_RECORDS_KEY];
    NSMutableArray *saveArray = [NSMutableArray arrayWithArray:tempArray];
    [saveArray insertObject:data atIndex:0];
    [[NSUserDefaults standardUserDefaults] setObject:saveArray forKey:SEARCH_HISTORY_RECORDS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - 跳转详情
- (void)jumpDetailBoard:(id)data
{
//    if (data.type.intValue == GARDEN_BOOK_SOURCE_FILE_FOLDER_TYPE)
//    {
//        GardenBookFolderListBoard_iPhone *board = [GardenBookFolderListBoard_iPhone board];
//        board.dataId = data.id;
//        board.navTitle = data.name;
//        [self.stack pushBoard:board animated:YES];
//    }
//    else
//    {
//        [self event:GARDEN_DETAILS];
//        if (data.url && [data.url isKindOfClass:[NSString class]])
//        {
//            [self openUrlInWebView:data.url];
//        }
//        else
//        {
//            [self presentFailureTips:@"未获取到资源内容"];
//        }
//    }
}

#pragma mark -collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return  self.historyArray.count;
    }
    else
    {
        return self.hotRecommendList.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *data;
    if (indexPath.section == 0)
    {
        data = [self.historyArray objectAtIndex:indexPath.row];
    }
    else
    {
        data = [self.hotRecommendList objectAtIndex:indexPath.row];
    }
    [cell fillData:data];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data;
    if (indexPath.section == 0) {
        data = [self.historyArray objectAtIndex:indexPath.row];
    } else {
        data = [self.hotRecommendList objectAtIndex:indexPath.row];
    }
    return CGSizeMake([data[@"nameWidth"] floatValue] + UIValue(10), UIValue(30));
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    BOOL isHave = ((section == 0 && self.historyArray.count > 0) || (section == 1 && self.hotRecommendList.count > 0));
    if (isHave) {
        return CGSizeMake(UIScreenWidth, [SearchReusableView viewHeight]);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"])
    {
        SearchReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SearchReusableView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [reusableView fillData:@"搜索历史" isClear:YES];
        } else {
            [reusableView fillData:@"热门搜索" isClear:NO];
        }
        WS(weakSelf)
        reusableView.clearSearchHistory = ^{
            [weakSelf clearSearchHistory];
        };
        return reusableView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data;
    if (indexPath.section == 0) {
        data = [self.historyArray objectAtIndex:indexPath.row];
    } else {
        data = [self.hotRecommendList objectAtIndex:indexPath.row];
    }
    NSString *text = data[@"content"];
    [self.searchView fillData:text];
    [self searchAction:text];
    searchStr = text;
    [self addHistory:searchStr];
}

#pragma mark - 开始搜索
- (void)startSearch
{
//    [self setTableViewEmptyView];
    [self.tableView reloadData];
}

#pragma mark - 搜索
- (void)searchAction:(NSString *)searchContent
{
    if ([searchContent isEqualToString:searchStr]) {
//        [self setTableViewEmptyView];
        return;
    } else {
        searchStr = searchContent;
    }
    
    if (searchStr && searchStr.length > 0) {
        self.tableView.hidden = NO;
        [self keyWordSearch];
        [self addHistory:searchStr];
    } else {
        [self clearSearchContent];
    }
}

#pragma mark - 清空搜搜内容
- (void)clearSearchContent
{
    searchStr = nil;
    self.searchResultsModel = nil;
    [self.tableView reloadData];
    self.tableView.hidden = YES;
//    [self setCollectionViewEmptyView];
}

- (UIView *)searchBgView
{
    if (!_searchBgView) {
        _searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, StatusHeight + [SearchView viewHeight])];
        _searchBgView.backgroundColor = [UIColor whiteColor];
    }
    return _searchBgView;
}

- (SearchView *)searchView
{
    if (!_searchView)
    {
        _searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, StatusHeight, UIScreenWidth, [SearchView viewHeight])];

        WS(weakSelf)
        _searchView.textFieldStartBlcok = ^(SEARCHER_VIEW_STATE state) {
            weakSelf.searcherState = state;
            [weakSelf startSearch];
        };
        
        _searchView.textFieldSearchBlock = ^(NSString * _Nonnull textStr, SEARCHER_VIEW_STATE state) {
            weakSelf.searcherState = state;
            [weakSelf searchAction:textStr];
        };
        
        _searchView.textFieldClearBlock = ^(SEARCHER_VIEW_STATE state) {
            weakSelf.searcherState = state;
            [weakSelf clearSearchContent];
        };
        
        _searchView.cancelActionBlock = ^(SEARCHER_VIEW_STATE state) {
            weakSelf.searcherState = state;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _searchView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        SearchFlowLayout *flowLayOut = [[SearchFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:UIValue(10)];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) collectionViewLayout:flowLayOut];
        _collectionView.contentInset = UIEdgeInsetsMake(self.searchBgView.bottom, UIValue(16), iPhoneXBottomHeight, UIValue(16));
        [_collectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"SearchCollectionViewCell"];
        [_collectionView registerClass:[SearchReusableView class] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"SearchReusableView"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _collectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
        _tableView.contentInset = UIEdgeInsetsMake(self.searchBgView.bottom, 0, iPhoneXBottomHeight, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.hidden = YES;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

        UIView *headerView = [[UIView alloc] init];
        headerView.width = SCR_WIDTH;
        headerView.height = UIValue(24+5);
        
        UIButton *sortBtn = [[UIButton alloc] init];
        [headerView addSubview:sortBtn];
        self.sortBtn = sortBtn;
        sortBtn.top = UIValue(5);
        sortBtn.left = UIValue(16);
        sortBtn.width = UIValue(70);
        sortBtn.height = UIValue(24);
        sortBtn.titleLabel.font = FontR(17);
        [sortBtn setTitle:@"时间排序" forState:UIControlStateNormal];
        [sortBtn setTitleColor:[UIColor colorWithHex:@"#333333"] forState:UIControlStateNormal];
        [sortBtn addTarget:self action:@selector(sortAction:) forControlEvents:UIControlEventTouchUpInside];
    
        UIImageView *arrowView = [[UIImageView alloc] init];
        arrowView.width = UIValue(16);
        arrowView.height = uiv(9);
        arrowView.left = sortBtn.right + UIValue(10);
        arrowView.image = [UIImage imageNamed:@"icon_arrow_down"];
        arrowView.centerY = sortBtn.centerY;
        
        [headerView addSubview:arrowView];

        
        // _tableView.tableHeaderView = headerView;

    }
    return _tableView;
}

@end
