//
//  MyAddressViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "MyAddressViewController.h"
#import "MyAddressTableViewCell.h"
#import "EditAddressViewController.h"
#import "MineNetworkManager.h"

@interface MyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收获地址";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F4F4F4"];
    
    [self setMainView];
    [self headerRefreshAction];
}

- (void)addAddressAction
{
    [self editWithData:nil];
}

- (void)editWithData:(id)data
{
    EditAddressViewController *vc = [EditAddressViewController new];
    vc.data = data;
    @weakify(self);
    vc.editFinishBlock = ^{
        @strongify(self);
        [self headerRefreshAction];
    };
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)setMainView
{
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-SafeAreaTopHeight) style:UITableViewStylePlain];
    mainView.backgroundColor = self.view.backgroundColor;
    mainView.contentInset = UIEdgeInsetsMake(SafeAreaTopHeight, 0, SafeAreaBottomHeight, 0);
    mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
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
    
    _addBtn = [[UIButton alloc] init];
    _addBtn.width = uiv(306);
    _addBtn.height = uiv(44);
    _addBtn.backgroundColor = [UIColor colorWithHex:@"#FBB313"];
    [_addBtn setTitle:@"添加收获地址" forState:UIControlStateNormal];
    [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addBtn.titleLabel.font = FontBoldR(15);
    _addBtn.centerX = UIScreenWidth / 2.0;
    _addBtn.bottom = UIScreenHeight - uiv(22);
    
    _addBtn.layer.cornerRadius = _addBtn.height/2.0;
    _addBtn.layer.masksToBounds = YES;

    
    [_addBtn addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addBtn];
    
    [self.mainView showEmptyView];

}

- (void)headerRefreshAction
{
    [self getAddressList];
    
}

- (void)cellAction:(int)type data:(id)data
{
    if (type == 0) {
        // 设置成默认
        [self updateAddress:data];
    } else if (type == 1) {
        // 去修改
        [self editWithData:data];
    } else if (type == 2) {
        // 去删除
        [self deleteAddress:data];
    }
}

- (void)updateAddress:(id)data
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = data[@"id"];
    BOOL isDefault = [data[@"isDefault"] intValue];
    params[@"isDefault"] = @(isDefault ? 0 : 1);

    [MineNetworkManager updateAddressWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        [self headerRefreshAction];

    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)deleteAddress:(id)data
{
    NSNumber *dataId = data[@"id"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"id"] = dataId;
    
    [SVProgressHUD show];
    [MineNetworkManager deleteAddressWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        [self headerRefreshAction];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
    }];
}

- (void)getAddressList
{
    [SVProgressHUD show];
    [MineNetworkManager getMyAddressListWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        
        [SVProgressHUD dismiss];
        [self.mainView.mj_header endRefreshing];
        [self.mainView reloadData];

        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.dataList = responseAfter;
                
                
                if([self.dataList count]) {
                    [self.mainView hideEmptyView];
                } else {
                    [self.mainView showEmptyView];
                }

                
                [self.mainView reloadData];
            }
        }

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
    return [MyAddressTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    MyAddressTableViewCell *cell = [MyAddressTableViewCell dequeueReusableWith:tableView];
    NSDictionary *data = [self.dataList objectAtIndex:row];
    [cell fillData:data];
    @weakify(self);
    cell.actionBlock = ^(int type) {
        @strongify(self);
        [self cellAction:type data:data];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSDictionary *data = [self.dataList objectAtIndex:row];
    if (self.selectBlock) {
        self.selectBlock(data);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
