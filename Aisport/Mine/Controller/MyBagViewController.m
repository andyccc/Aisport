//
//  MyBagViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "MyBagViewController.h"
#import "MyBagCollectionViewCell.h"
#import "MineNetworkManager.h"
#import "IconTipsView.h"

@interface MyBagViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *tableView;
@property (nonatomic, strong) NSArray *dataList;


@end

@implementation MyBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的背包";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F4F4F4"];

    [self createView];
    
    [self headerRefresh];
}

- (void)headerRefresh
{
    [SVProgressHUD show];
    [MineNetworkManager getMyBagListWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];

        if (ResponseSuccess && ![StringForId(responseAfter) isEqual:@""]) {
            NSArray *data = responseAfter;
            if (data && [data isKindOfClass:NSArray.class]) {
                self.dataList = data;
                
                if([self.dataList count]) {
                    [self.tableView hideEmptyView];
                } else {
                    [self.tableView showEmptyView];

                }

                
                [self.tableView reloadData];
            }
        }
        
        [self.tableView.mj_header endRefreshing];
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

- (void)createView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init]; //自动网格布局/自动流式布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical; //滚动方向设为垂直滚动
    layout.minimumLineSpacing = UIValue(10);//行间距
    layout.minimumInteritemSpacing = UIValue(10);//列间距
    layout.itemSize = [MyBagCollectionViewCell sizeForItemCell];
    CGFloat cols = IS_IPAD ? 4 : 4;
    CGFloat space = ((self.view.width - layout.itemSize.width * cols) - UIValue(10)) / cols;
    layout.sectionInset = UIEdgeInsetsMake(space, space, space, space);//item边距

    _tableView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) collectionViewLayout:layout];
    _tableView.contentInset = UIEdgeInsetsMake(SafeAreaTopHeight, 0, SafeAreaBottomHeight, 0);
    _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    @weakify(self);
    _tableView.mj_header = [JXRefreshHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self headerRefresh];
    }];

    [_tableView registerClass:MyBagCollectionViewCell.class forCellWithReuseIdentifier:MyBagCollectionViewCell.reuseIdentifier];
    [self.view addSubview:_tableView];
    
    [self.tableView showEmptyView];

}

- (void)useBag:(id)data
{
    [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"propsId"] = data[@"pid"];
    [MineNetworkManager useMyBagWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        [self headerRefresh];
        
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataList count];
//    return  10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyBagCollectionViewCell *cell = [MyBagCollectionViewCell dequeueReusableCell:collectionView indexPath:indexPath];
    NSInteger row = indexPath.row;
    id data = [self.dataList objectAtIndex:row];
    [cell fillData:data];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [DynamicAlbumCollectionViewCell sizeForItemCell];
//}

//定义每个UICollectionView 的 margin
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(UIValue(10), UIValue(16), UIValue(10), UIValue(16));
//}

#pragma mark - UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;

    id data = [self.dataList objectAtIndex:row];
    IconTipsView *view = [[IconTipsView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
    
    NSString *cover = data[@"propsImage"];
    [view.iconView sd_setImageWithURL:[NSURL URLWithString:StringForId(cover)] placeholderImage:nil];
    view.infoLabel.text = data[@"propsName"];
    view.desLabel.text = data[@"propsContent"];
    [view.okBtn setTitle:@"使用" forState:UIControlStateNormal];
    @weakify(view);
    @weakify(self);

    view.okBlock = ^{
        @strongify(view);
        @strongify(self);

        [self useBag:data];
        [view dismiss];
    };
    [view show];
    
}
//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

@end
