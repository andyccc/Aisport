//
//  SettingViewController.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "ContactViewController.h"
#import "ProfileTableViewCell.h"
#import "AlertVC.h"
#import "LoginNetWork.h"
#import "AddPicView.h"
#import "DataPickView.h"
#import "SexViewController.h"
#import "NicknameViewController.h"

@interface ContactViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic,strong)NSMutableArray *titles, *subTitles;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    self.view.backgroundColor = [UIColor whiteColor];

    _titles = @[@"企业邮箱",@"联系电话",@"微信公众号",@"微信号"].mutableCopy;
    _subTitles = @[@"haidong@hidbb.com",@"1735786017",@"嗨动陪练",@"嗨动Lisa"].mutableCopy;
    
    
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
    mainView.scrollEnabled = YES;
    _mainView = mainView;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.width = SCR_WIDTH;
    headerView.height = UIValue(135 + 32);

    UIImageView *bg = [[UIImageView alloc] init];
    bg.top = UIValue(9);
    bg.left = UIValue(7);
    bg.image = [UIImage imageNamed:@"icon_concat_woman_bg"];
    bg.width = headerView.width - UIValue(14);
    bg.height = headerView.height - UIValue(18);
    [headerView addSubview:bg];

    UIView *content = [[UIView alloc] init];
    content.left = UIValue(16);
    content.top = UIValue(16);
    content.width = SCR_WIDTH - UIValue(32);
    content.height = UIValue(135);
    content.layer.cornerRadius = UIValue(5);
    content.layer.masksToBounds = YES;
    [headerView addSubview:content];

    UIImageView *pic = [[UIImageView alloc] init];
    pic.image = [UIImage imageNamed:@"icon_concat_woman"];
    pic.width = UIValue(168);
    pic.height = UIValue(135);
    pic.right = content.width;
    [content addSubview:pic];

    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.width = UIValue(200);
    titleLabel.height = UIValue(30);
    titleLabel.font = FontR(28);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.top = UIValue(38);
    titleLabel.left = UIValue(13);
    titleLabel.text = @"嗨动为您服务";
    [content addSubview:titleLabel];
    
    
    UILabel *title1Label = [[UILabel alloc] init];
    title1Label.width = UIValue(200);
    title1Label.height = UIValue(26);
    title1Label.font = FontR(14);
    title1Label.textColor = [UIColor colorWithHex:@"#999999"];
    title1Label.top = UIValue(10) + titleLabel.bottom;
    title1Label.left = UIValue(13);
    title1Label.text = @"您遇到什么问题随时联系我们";
    [content addSubview:title1Label];
    
    
    
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
    }
    cell.index = indexPath.row;
    cell.titleLab.text = _titles[indexPath.row];
    cell.titleLab.width = UIValue(200);
    cell.subTf.text = _subTitles[indexPath.row];
    cell.subTf.hidden = NO;
    cell.subTf.enabled = NO;
    cell.iconImageView.hidden = YES;
    cell.subTf.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*2*Screen_Scale;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
