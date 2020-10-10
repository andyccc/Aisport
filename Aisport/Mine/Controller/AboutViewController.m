//
//  AboutViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "AboutViewController.h"
#import "ProfileTableViewCell.h"
#import "StaticContentViewController.h"
#import "SystemMethods.h"
#import "FeedContentViewController.h"
#import "ContactViewController.h"


@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic,strong)NSMutableArray *titles, *subTitles;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";

    self.view.backgroundColor = [UIColor colorWithHex:@"#F8F8F7"];

    _titles = @[@"企业介绍",@"隐私协议",@"反馈建议",@"联系我们"].mutableCopy;
    
    
    [self setMainView];
    
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
    mainView.scrollEnabled = NO;
    mainView.backgroundColor = self.view.backgroundColor;
    _mainView = mainView;
    
    
    UIView *headerView = [[UIView alloc] init];
    headerView.width = SCR_WIDTH;
    headerView.height = UIValue(237);
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.width = uiv(101);
    iconView.height = UIValue(101);
    iconView.top = UIValue(68);
    iconView.centerX = SCR_WIDTH /2;
    iconView.image = [UIImage imageNamed:@"AppIcon60x60"];
    iconView.layer.cornerRadius = UIValue(23);
    iconView.layer.masksToBounds = YES;
    [headerView addSubview:iconView];
    
    UILabel *verLabel = [[UILabel alloc] init];
    verLabel.width = iconView.width;
    verLabel.height = UIValue(22);
    verLabel.font = FontR(15);
    verLabel.textColor = [UIColor colorWithHex:@"#333333"];
    verLabel.textAlignment = NSTextAlignmentCenter;
    verLabel.left = iconView.left;
    verLabel.top = iconView.bottom + UIValue(4);
    verLabel.text = @"当前版本";
    [headerView addSubview:verLabel];

    UILabel *ver1Label = [[UILabel alloc] init];
    ver1Label.width = iconView.width;
    ver1Label.height = UIValue(20);
    ver1Label.font = FontR(14);
    ver1Label.textColor = [UIColor colorWithHex:@"#999999"];
    ver1Label.textAlignment = NSTextAlignmentCenter;
    ver1Label.left = iconView.left;
    ver1Label.top = verLabel.bottom + UIValue(4);
    ver1Label.text = [SystemMethods SystemGetSoftVersion];
    [headerView addSubview:ver1Label];

    mainView.tableHeaderView = headerView;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettinCentreViewCell"];
    if (cell == nil) {
        cell = [[ProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettinCentreViewCell"];
        
        cell.iconImageView.hidden = YES;
        cell.subTf.hidden = YES;
        cell.subTf.userInteractionEnabled = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.index = indexPath.row;
    cell.titleLab.text = _titles[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*2*Screen_Scale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
       // 企业介绍
        StaticContentViewController *vc = [StaticContentViewController new];
        vc.contentType = StaticContentTypeIntro;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (row == 1) {
        // 隐私协议
        StaticContentViewController *vc = [StaticContentViewController new];
        vc.contentType = StaticContentTypePrivate;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 2){
       // 反馈建议
        FeedContentViewController *vc = [FeedContentViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (row == 3) {
        // 联系我们
        ContactViewController *vc = [ContactViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
