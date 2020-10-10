//
//  SettingViewController.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "ProfileViewController.h"
#import "ProfileTableViewCell.h"
#import "AlertVC.h"
#import "LoginNetWork.h"
#import "AddPicView.h"
#import "DataPickView.h"
#import "SexViewController.h"
#import "NicknameViewController.h"

@interface ProfileViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic,strong)NSMutableArray *titles, *subTitles;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor whiteColor];

    _titles = @[@"头像",@"昵称",@"性别",].mutableCopy;
    _subTitles = @[@"",@"天涯",@"男",].mutableCopy;
    
    UIButton *saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
//
//    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1];;
//    [shareBtn addTarget:self action:@selector(shareBtnClick)
     
    [saveBtn addTarget:self action:@selector(saveUserInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self setMainView];
    
    [self.view endEditing:YES];
    // Do any additional setup after loading the view.
}

- (void)saveUserInfo
{
    [self.view endEditing:YES];
    
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].cover) forKey:@"cover"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].nickName) forKey:@"nickName"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].sex) forKey:@"sex"];

    [SVProgressHUD show];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    [LoginNetWork fixUserInfoWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            [SVProgressHUD showInfoWithStatus:@"修改成功"];
            [GVUserDefaults standardUserDefaults].firstInfoEnter = 11;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else
        {
            [SVProgressHUD dismiss];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
    _mainView = mainView;
    
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
    
    cell.iconImageView.hidden = YES;
    cell.subTf.hidden = NO;
    cell.subTf.userInteractionEnabled = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.iconImageView.hidden = NO;
        cell.subTf.hidden = YES;
        [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId([GVUserDefaults standardUserDefaults].cover)] placeholderImage:[UIImage imageNamed:@"home_hejipic"]];
    }else if (indexPath.row == 1){
        cell.subTf.userInteractionEnabled = NO;
//        cell.subTf.text = _subTitles[indexPath.row];
        cell.subTf.text = StringForId([GVUserDefaults standardUserDefaults].nickName);
        [self.view endEditing:YES];
    }else if (indexPath.row == _titles.count-1){
        cell.subTf.userInteractionEnabled = NO;
        [self.view endEditing:YES];
//        [cell.subTf becomeFirstResponder];
        NSLog(@"%@",[GVUserDefaults standardUserDefaults].sex);
        cell.subTf.text = [StringNumForId([GVUserDefaults standardUserDefaults].sex, @"1") intValue] == 0 ? @"男":@"女";
    }else{
        cell.subTf.hidden = NO;
        cell.subTf.userInteractionEnabled = YES;
        [cell.subTf becomeFirstResponder];
        cell.subTf.text = StringForId([GVUserDefaults standardUserDefaults].nickName);
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*2*Screen_Scale;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];

    if (indexPath.row == 0) {
        //头像
        WS(weakSelf);
        [[AddPicView shareAddPicView] addPicViewWithPicCount:1 ViewController:self IsCrop:YES AddPicBlock:^(NSArray * _Nonnull picUrlArr) {
            [GVUserDefaults standardUserDefaults].cover = picUrlArr[0];
            [weakSelf.mainView reloadData];
            
        }];
    }else if (indexPath.row == 2) {
        //性别
        
        SexViewController *vc = [SexViewController new];
        vc.sex = [[GVUserDefaults standardUserDefaults].sex intValue];
        @weakify(self);
        vc.finishBlock = ^(NSInteger sex) {
            @strongify(self);
            [GVUserDefaults standardUserDefaults].sex = [NSString stringWithFormat:@"%ld", (long)sex];
            [self.mainView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
        return;
        
        WS(weakSelf);
        DataPickView* p = [[DataPickView alloc]init];
        NSMutableArray *sexs = @[@"男",@"女"].mutableCopy;
        [p showWithArray:sexs Source2:nil Source3:nil Block:^(NSString *stringData1, NSString *stringData2, NSString *stringData3, int selectInt1, int selectInt2, int selectInt3) {
//            [_subTitles[indexPath.section] replaceObjectAtIndex:indexPath.row withObject:stringData1];
//            _detailModel.sex = stringData1;
            [GVUserDefaults standardUserDefaults].sex = [NSString stringWithFormat:@"%d",selectInt1];
            [weakSelf.mainView reloadData];
        }];
    }else if (indexPath.row == 1){
        //昵称
        NicknameViewController *vc = [NicknameViewController new];
        vc.text = [GVUserDefaults standardUserDefaults].nickName;
        @weakify(self);
        vc.finishBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            [GVUserDefaults standardUserDefaults].nickName = text;
            [self.mainView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];

        
    }else{

    }
//    TRClassDetailViewController *vc = [[TRClassDetailViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
