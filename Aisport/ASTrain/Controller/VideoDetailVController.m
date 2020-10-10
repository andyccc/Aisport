//
//  VideoDetailVController.m
//  Aisport
//
//  Created by Apple on 2020/12/14.
//

#import "VideoDetailVController.h"
#import "SelPlayerConfiguration.h"
#import "SelVideoPlayer.h"
#import "UILabel+getWidth.h"

@interface VideoDetailVController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) SelPlayerConfiguration *configuration;
@property (nonatomic, strong) SelVideoPlayer *player;
@property (nonatomic, strong) UIView *introBgView;

@property (nonatomic, strong) NSMutableArray *titleLabArr;


@end

@implementation VideoDetailVController

- (NSMutableArray *)titleLabArr
{
    if (!_titleLabArr) {
        _titleLabArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleLabArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)setHeadView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 245*2*Screen_Scale+67)];
    headView.backgroundColor = [UIColor whiteColor];
    
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = NO;     //自动播放
    configuration.supportedDoubleTap = YES;     //支持双击播放暂停
    configuration.shouldAutorotate = NO;   //自动旋转
    configuration.repeatPlay = NO;     //重复播放
    configuration.shouldAutorotate = NO;
    configuration.statusBarHideState = SelStatusBarHideStateFollowControls;     //设置状态栏隐藏
    configuration.videoGravity = SelVideoGravityResizeAspect;   //拉伸方式
    _configuration = configuration;
    
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 245*2*Screen_Scale) configuration:configuration];
    [headView addSubview:_player];
    
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, _player.bottom, SCR_WIDTH-17*2, 41)];
    [headView addSubview:nameLabel];
    nameLabel.textColor = [UIColor colorWithHex:@"#333333"];
    nameLabel.font = fontBold(19);
    nameLabel.text = @"帕梅拉有氧操";
//    _nameLabel = nameLabel;
    
    NSString *timeStr = @"1.2万人跳过";
    CGFloat timeW = [UILabel getWidthWithTitle:timeStr font:fontApp(10)];
//        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-timeW-8-4, autherLabel.bottom+3, timeW+4, 17)];
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, nameLabel.bottom, timeW+4, 17)];
    [headView addSubview:timeLabel];
    timeLabel.font = fontApp(10);
//        timeLabel.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    timeLabel.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    timeLabel.textAlignment = NSTextAlignmentCenter;
//    timeLabel.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.07];//0.07
    timeLabel.layer.cornerRadius = 3;
    timeLabel.layer.borderColor = [[UIColor colorWithHex:@"#1BC2B1" alpha:1.0] CGColor];
    timeLabel.layer.borderWidth = 1;
    timeLabel.text = timeStr;
//    _timeLabel = timeLabel;
    
    UIView *introBgView = [[UIView alloc] initWithFrame:CGRectMake(0, timeLabel.bottom+10, SCR_WIDTH, 38)];
    [headView addSubview:introBgView];
    introBgView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    
    UILabel *introBgLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, introBgView.width-32, introBgView.height)];
    [introBgView addSubview:introBgLab];
    introBgLab.textColor = [UIColor colorWithHex:@"#333333"];
    introBgLab.font = fontBold(13);
    introBgLab.text = @"课程介绍";
    
    NSString *introStr = @"开合跳的训练视频主要针对提臀、美腿、提升上半身力量和精致手臂等进行专项练习，同时大部分的训练都是不需要器械的，只需要在家准备一块瑜伽垫和音乐；开合跳推送的是不需要器材、不分场合、随时随地健身，基本上只需要30分钟以内，这很符合我们现在的生活节奏，没有大把时间、不想去健身房，但又对自己的身材有要求。";
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, introBgView.bottom, SCR_WIDTH-32, 93)];
    [introBgView addSubview:introLabel];
//    introLabel.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
    introLabel.textColor = [UIColor colorWithHex:@"#333333"];
    introLabel.font = fontApp(12);
    introLabel.numberOfLines = 0;
//    introLabel.textAlignment = NSTextAlignmentCenter;
    introLabel.text = introStr;
//    _introLabel = introLabel;
    
    [self.titleLabArr removeAllObjects];
    NSArray *numArr = @[@"44",@"4673",@"简单"];
    NSArray *titleArr = @[@"历史成绩",@"视频消耗",@"视频难度"];
    for (int i = 0; i < numArr.count; i++) {
        //WithFrame:CGRectMake(SCR_WIDTH/3*i,introBgView.bottom+3, SCR_WIDTH/3, 10)
        UILabel *numTiLab = [[UILabel alloc] init];
        [headView addSubview:numTiLab];
        [numTiLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView.mas_left).offset(headView.width/3*i);
            make.top.equalTo(introBgView.mas_bottom).offset(0);
            make.width.mas_equalTo(headView.width/3);
            make.height.mas_equalTo(10);
        }];
        numTiLab.textColor = [UIColor colorWithHex:@"#999999"];
        numTiLab.font = fontApp(10);
        numTiLab.textAlignment = NSTextAlignmentCenter;
        numTiLab.text = titleArr[i];
        
        //WithFrame:CGRectMake(SCR_WIDTH/3*i, numTiLab.bottom+64, SCR_WIDTH/3, 20)
        UILabel *numberLab = [[UILabel alloc] init];
        [headView addSubview:numberLab];
        [numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headView.mas_left).offset(headView.width/3*i);
            make.top.equalTo(numTiLab.mas_bottom).offset(0);
            make.width.mas_equalTo(headView.width/3);
            make.height.mas_equalTo(20);
        }];
        numberLab.textColor = [UIColor colorWithHex:@"#333333"];
        numberLab.font = fontBold(18);
        numberLab.textAlignment = NSTextAlignmentCenter;
        numberLab.text = numArr[i];
        [self.titleLabArr addObject:numberLab];
        
        
    }
    
    //WithFrame:CGRectMake(0, 0, SCR_WIDTH, 251*2*Screen_Scale)
    UIView *horiView = [[UIView alloc] init];
    [headView addSubview:horiView];
    [horiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(introBgView.mas_bottom).offset(0);
        make.left.equalTo(headView.mas_left).offset(0);
        make.width.mas_equalTo(headView.width);
        make.height.mas_equalTo(10);
    }];
    horiView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:1.0];
    
    UIButton *rankButton = [[UIButton alloc] init];
    [headView addSubview:rankButton];
    [rankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horiView.mas_bottom).offset(0);
        make.left.equalTo(headView.mas_left).offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(headView.width/2-0.5);
    }];
    [rankButton setTitle:@"排行榜" forState:UIControlStateNormal];
    [rankButton setTitleColor:[UIColor colorWithHex:@"#333333"] forState:UIControlStateNormal];
    [rankButton setTitleColor:[UIColor colorWithHex:@"#1BC2B1"] forState:UIControlStateNormal];
    rankButton.titleLabel.font = fontBold(15);
    rankButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [rankButton addTarget:self action:@selector(clickRankButton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *growButton = [[UIButton alloc] init];
    [headView addSubview:growButton];
    [growButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horiView.mas_bottom).offset(0);
        make.right.equalTo(headView.mas_right).offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(headView.width/2-0.5);
    }];
    [growButton setTitle:@"我的成长" forState:UIControlStateNormal];
    [growButton setTitleColor:[UIColor colorWithHex:@"#333333"] forState:UIControlStateNormal];
    [growButton setTitleColor:[UIColor colorWithHex:@"#1BC2B1"] forState:UIControlStateSelected];
    growButton.titleLabel.font = fontBold(15);
    growButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [growButton addTarget:self action:@selector(clickGrowButton) forControlEvents:UIControlEventTouchUpInside];
    
    
}


- (void)setMainView
{
    UITableView *mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT) style:UITableViewStylePlain];
    [self.view addSubview:mainView];
    mainView.delegate = self;
    mainView.dataSource = self;
//    mainView.tableHeaderView = se
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
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
