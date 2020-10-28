//
//  ClassDetailViewController.m
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import "TRClassDetailViewController.h"
#import "TRPlayVideoViewController.h"
#import "LoadingSourceView.h"
#import "Aisport-Swift.h"
#import "CommonWebController.h"


@interface TRClassDetailViewController ()

@property (nonatomic, strong) LoadingSourceView *loadingSourceView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation TRClassDetailViewController

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
    for (UIView *view in self.loadingSourceView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.loadingSourceView removeFromSuperview];
    self.loadingSourceView = nil;
    
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"全身激活练习";
    
    [self setMainView];

 
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    [rightBtn setTitle:@"动作" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIButton *rightBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    [rightBtn1 setTitle:@"web" forState:UIControlStateNormal];
    [rightBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn1];
    
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1];;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn1 addTarget:self action:@selector(rightBtn1Click1) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

- (void)rightBtnClick
{
    //测试动作界面
    TestController *vc = [[TestController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightBtn1Click1
{
    //web界面
    CommonWebController *vc = [[CommonWebController alloc] init];
    vc.title = @"web标题";
    vc.url = @"https://uat-biz.hidbb.com/";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - setMainUI
- (void)setMainView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-60)];
    [self.view addSubview:scrollView];
    
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 246*2*Screen_Scale)];
    [scrollView addSubview:picImageView];
    picImageView.contentMode = UIViewContentModeScaleAspectFill;
    picImageView.image = [UIImage imageNamed:@"train_classbanner"];
    picImageView.clipsToBounds = YES;
    
    NSArray *numArr = @[@"44",@"4673",@"33"];
    NSArray *titleArr = @[@"累计播放",@"历史成绩",@"累计消耗千卡"];
    for (int i = 0; i < numArr.count; i++) {
        UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/3*i, picImageView.bottom+32, SCR_WIDTH/3, 14)];
        [scrollView addSubview:numberLab];
        numberLab.textColor = [UIColor colorWithHex:@"#333333"];
        numberLab.font = fontBold(19);
        numberLab.textAlignment = NSTextAlignmentCenter;
        numberLab.text = numArr[i];
        
        UILabel *numTiLab = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/3*i, numberLab.bottom+6, SCR_WIDTH/3, 10)];
        [scrollView addSubview:numTiLab];
        numTiLab.textColor = [UIColor colorWithHex:@"#999999"];
        numTiLab.font = fontApp(10);
        numTiLab.textAlignment = NSTextAlignmentCenter;
        numTiLab.text = titleArr[i];
        
        
    }
    
    UIView *introBgView = [[UIView alloc] initWithFrame:CGRectMake(0, picImageView.bottom+80, SCR_WIDTH, 38)];
    [scrollView addSubview:introBgView];
    introBgView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    
    UILabel *introBgLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, introBgView.width-32, introBgView.height)];
    [introBgView addSubview:introBgLab];
    introBgLab.textColor = [UIColor colorWithHex:@"#333333"];
    introBgLab.font = fontBold(13);
    introBgLab.text = @"课程介绍";
    
    NSString *introStr = @"开合跳的训练视频主要针对提臀、美腿、提升上半身力量和精致手臂等进行专项练习，同时大部分的训练都是不需要器械的，只需要在家准备一块瑜伽垫和音乐；开合跳推送的是不需要器材、不分场合、随时随地健身，基本上只需要30分钟以内，这很符合我们现在的生活节奏，没有大把时间、不想去健身房，但又对自己的身材有要求。";
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, introBgView.bottom, SCR_WIDTH-32, 93)];
    [scrollView addSubview:introLabel];
//    introLabel.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
    introLabel.textColor = [UIColor colorWithHex:@"#333333"];
    introLabel.font = fontApp(12);
    introLabel.numberOfLines = 0;
//    introLabel.textAlignment = NSTextAlignmentCenter;
    introLabel.text = introStr;
    
    
    UIView *prepareBgView = [[UIView alloc] initWithFrame:CGRectMake(0, introLabel.bottom, SCR_WIDTH, 38)];
    [scrollView addSubview:prepareBgView];
    prepareBgView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    
    UILabel *prepareBgLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, prepareBgView.width-32, prepareBgView.height)];
    [prepareBgView addSubview:prepareBgLab];
    prepareBgLab.textColor = [UIColor colorWithHex:@"#333333"];
    prepareBgLab.font = fontBold(13);
    prepareBgLab.text = @"课前准备";
    
    UILabel *prepareLab1 = [[UILabel alloc] initWithFrame:CGRectMake(28, prepareBgView.bottom+10, SCR_WIDTH-28-16, 24)];
    [scrollView addSubview:prepareLab1];
    prepareLab1.textColor = [UIColor colorWithHex:@"#333333"];
    prepareLab1.font = fontApp(12);
    prepareLab1.numberOfLines = 0;
    prepareLab1.text = @"选择手机播放可以直接练习";
    
    UIView *signView1 = [[UIView alloc] init];
    [scrollView addSubview:signView1];
    [signView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.centerY.mas_equalTo(prepareLab1.mas_centerY);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    signView1.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    signView1.layer.cornerRadius = 3;
    signView1.clipsToBounds = YES;
    
    UILabel *prepareLab2 = [[UILabel alloc] initWithFrame:CGRectMake(28, prepareLab1.bottom, SCR_WIDTH-28-16, 24)];
    [scrollView addSubview:prepareLab2];
    prepareLab2.textColor = [UIColor colorWithHex:@"#333333"];
    prepareLab2.font = fontApp(12);
    prepareLab2.numberOfLines = 0;
    prepareLab2.text = @"投屏需要准备电视/盒子";
    
    UIView *signView2 = [[UIView alloc] init];
    [scrollView addSubview:signView2];
    [signView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.centerY.mas_equalTo(prepareLab2.mas_centerY);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    signView2.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    signView2.layer.cornerRadius = 3;
    signView2.clipsToBounds = YES;
    
    UILabel *prepareLab3 = [[UILabel alloc] initWithFrame:CGRectMake(28, prepareLab2.bottom, SCR_WIDTH-28-16, 24)];
    [scrollView addSubview:prepareLab3];
    prepareLab3.textColor = [UIColor colorWithHex:@"#333333"];
    prepareLab3.font = fontApp(12);
    prepareLab3.numberOfLines = 0;
    prepareLab3.text = @"需要wifi";
    
    UIView *signView3 = [[UIView alloc] init];
    [scrollView addSubview:signView3];
    [signView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(15);
        make.centerY.mas_equalTo(prepareLab3.mas_centerY);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(6);
    }];
    signView3.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    signView3.layer.cornerRadius = 3;
    signView3.clipsToBounds = YES;
    
    scrollView.contentSize = CGSizeMake(SCR_WIDTH, prepareLab3.bottom);
    
    UIButton *startBtn = [[UIButton alloc] init];
    [self.view addSubview:startBtn];
//    startBtn.backgroundColor = [UIColor colorWithString:@"36C2AF"];
    startBtn.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    [startBtn setTitle:@"开始训练" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startTrans) forControlEvents:UIControlEventTouchUpInside];
    startBtn.titleLabel.font = fontBold(19);
    
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}


#pragma mark - Button
- (void)startTrans
{
    [self.view addSubview:self.loadingSourceView];
    
    
    
    // 模拟下载进度
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(progressSimulation) userInfo:self repeats:YES];
    _timer = timer;
}

- (void)progressSimulation
{
    static CGFloat progress = 1.0;
    
    if (progress < 1.0) {
        progress += 0.01;
        
        // 循环
//        if (progress >= 1.0) progress = 0;
        
        self.loadingSourceView.progressView.progress = progress;
//        [self.demoViews enumerateObjectsUsingBlock:^(SDDemoItemView *demoView, NSUInteger idx, BOOL *stop) {
//            demoView.progressView.progress = progress;
//        }];
    }else{
        
        [self removeLoadingView];
        
        TRPlayVideoViewController *vc = [[TRPlayVideoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
