//
//  HomeViewController.m
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import "HomeViewController.h"
#import "TRClassDetailViewController.h"
#import "CardStaticView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) CardStaticView *staticView;
@property (nonatomic, strong) UIImageView *classImageView;

@property (nonatomic, strong) UITableView *mainView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    [self setMainView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)setMainView
{
    
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-SafeAreaTopHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:mainView];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainView.estimatedRowHeight = 0;
    mainView.estimatedSectionFooterHeight = 0;
    mainView.estimatedSectionHeaderHeight = 0;
    _mainView = mainView;
    
    
    _bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 254*2*Screen_Scale)];
    [self.view addSubview:_bannerImageView];
    _bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _bannerImageView.clipsToBounds = YES;
    _bannerImageView.image = [UIImage imageNamed:@"home_banner"];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-150/2, StatusHeight + 7, 150, 30)];
    [_bannerImageView addSubview:titleLabel];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = fontBold(16);
    titleLabel.text = @"嗨动AI";
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, _bannerImageView.bottom-14*2*Screen_Scale, SCR_WIDTH, SCR_HIGHT-_bannerImageView.bottom+14*2*Screen_Scale)];
    [self.view addSubview:bottomView];
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
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskHomeListViewCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskHomeListViewCell"];
    }
//    cell.type = _type;
//    TaskHomeModel *model = _dataSource[indexPath.row];
//    cell.model = model;
//    cell.editBtn.hidden = YES;
//    cell.deleteBtn.hidden = YES;
    
    return cell;
}

- (void)btnAction
{
    TRClassDetailViewController *vc = [[TRClassDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
