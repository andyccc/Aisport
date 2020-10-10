//
//  AreaSelectViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/25.
//

#import "AreaSelectViewController.h"
#import "AreaSelectTableViewCell.h"
#import "MineNetworkManager.h"


@interface AreaSelectViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView1;
@property (nonatomic, strong) UITableView *mainView2;
@property (nonatomic, strong) UITableView *mainView3;

@property (nonatomic, strong) NSMutableDictionary *areaDic;

@property (nonatomic, strong) NSString *pid1;
@property (nonatomic, strong) NSString *pid2;
@property (nonatomic, strong) NSString *pid3;

@property (nonatomic, strong) id data1;
@property (nonatomic, strong) id data2;
@property (nonatomic, strong) id data3;



@end

@implementation AreaSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pid1 = @"0";
    
    self.areaDic = [NSMutableDictionary dictionary];
    
    self.title = @"选择城市";
    [self setRightNavBtnWithTitle:@"确定"];
    self.view.backgroundColor = [UIColor whiteColor];

    [self createView];
    
    [self headerRefresh];
}

- (void)rightNavBtnAction
{
    !self.finishBlock ?: self.finishBlock(self.data1,self.data2,self.data3);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createView
{
    self.mainView1 = [self createTableView];
    [self.view addSubview:self.mainView1];
    
    self.mainView2 = [self createTableView];
    [self.view addSubview:self.mainView2];
    self.mainView2.left = self.mainView1.right;
    
    self.mainView3 = [self createTableView];
    [self.view addSubview:self.mainView3];
    self.mainView3.left = self.mainView2.right;
}

- (UITableView *)createTableView
{
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH/3.0, SCR_HIGHT-SafeAreaTopHeight)];
    mainView.backgroundColor = self.view.backgroundColor;
    mainView.delegate = self;
    mainView.dataSource = self;
//    mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainView.estimatedRowHeight = 0;
    mainView.estimatedSectionFooterHeight = 0;
    mainView.estimatedSectionHeaderHeight = 0;
    mainView.tableFooterView = [[UIView alloc] init];
    return mainView;
}

- (NSArray *)getDataList:(UITableView *)table
{
    NSArray *dataList = nil;
    if (table == self.mainView1) {
        dataList = self.areaDic[self.pid1];
    } else if (table == self.mainView2) {
        if (self.pid2) {
            dataList = self.areaDic[self.pid2];
        }
    } else if (table == self.mainView3) {
        if (self.pid3) {
            dataList = self.areaDic[self.pid3];
        }
    }
    
    return dataList;
}

- (void)headerRefresh
{
    [self getRegionList:@"0" table:self.mainView1];
}

- (void)getRegionList:(NSString *)pid table:(UITableView *)table
{
    [SVProgressHUD show];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pid"] = pid;
    
    [MineNetworkManager getRegionListWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [self andSuccessFn:responseAfter responseBefore:responseBefore table:table pid:pid];
    } andFailerFn:^(NSError * _Nonnull error) {
        [self andFailerFn:error table:table];
    }];
}

- (void)andFailerFn:(NSError *)error table:(UITableView *)table
{
    [SVProgressHUD dismiss];
    [table.mj_header endRefreshing];
}

- (void)andSuccessFn:(id)responseAfter responseBefore:(id)responseBefore table:(UITableView *)table pid:(NSString *)pid
{
    if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
        NSArray *data = responseAfter;
        if (data && [data isKindOfClass:NSArray.class]) {
            self.areaDic[pid] = data;
            [table reloadData];
        }
    }
    
    [SVProgressHUD dismiss];
    [table.mj_header endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getDataList:tableView] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AreaSelectTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    AreaSelectTableViewCell *cell = [AreaSelectTableViewCell dequeueReusableWith:tableView];
    
    NSArray *dataList = [self getDataList:tableView];
    
    if (dataList && [dataList count] > row) {
        NSDictionary *data = [dataList objectAtIndex:row];
        [cell fillData:data];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSArray *dataList = [self getDataList:tableView];
    if (dataList && [dataList count] > row) {
        id data = [dataList objectAtIndex:row];
        NSString *pid = [data[@"id"] description];
        // 赋值
        if (tableView == self.mainView1) {
            self.pid2 = pid;
            self.data1 = data;
            
            self.data2 = nil;

            self.pid3 = nil;
            self.data3 = nil;
            
            [self.mainView2 reloadData];
            [self.mainView3 reloadData];
            
            [self getRegionList:pid table:self.mainView2];
        } else if (tableView == self.mainView2) {
            self.pid3 = pid;
            self.data2 = data;
            
            self.data3 = nil;
            [self.mainView3 reloadData];

            [self getRegionList:pid table:self.mainView3];
        } else if (tableView == self.mainView3) {
            self.data3 = data;
        }
    }
    
}




@end
