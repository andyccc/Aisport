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
#import "ASTrainNetwork.h"
#import "HomeListModel.h"
#import "NSString+getHeight.h"

#import "CourseShareView.h"
#import "ShowShareBtnView.h"
#import "WechatShareManager.h"
#import "CourseModel.h"


@interface TRClassDetailViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) LoadingSourceView *loadingSourceView;
@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) HomeListModel *model;
@property (nonatomic, strong) NSMutableArray *titleLabArr;

@property (nonatomic, strong) CourseShareView *courseShareView;
@property (nonatomic, strong) ShowShareBtnView *showShareBtnView;
@property (nonatomic, strong) UIButton *collectBtn;

@property (nonatomic, strong) CourseModel *courseModel;

@end

@implementation TRClassDetailViewController

- (CourseShareView *)courseShareView
{
    if (!_courseShareView) {
        _courseShareView = [[CourseShareView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT) HomeListModel:_model];
        _courseShareView.backgroundColor = [UIColor colorWithHex:@"6d6d6f"];
    }
    return _courseShareView;
}

- (void)removeCourseShareView
{
    for (UIView *view in self.courseShareView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.courseShareView removeFromSuperview];
    self.courseShareView = nil;
}

- (ShowShareBtnView *)showShareBtnView
{
    if (!_showShareBtnView) {
        _showShareBtnView = [[ShowShareBtnView alloc] initWithFrame:CGRectMake(0, SCR_HIGHT, SCR_WIDTH, 141)];
        WS(weakSelf);
        _showShareBtnView.clickShareBlock = ^(NSInteger index) {
            [weakSelf handleShareWechatWithIndex:index];
            [weakSelf.navigationController setNavigationBarHidden:NO animated:NO];
            [weakSelf dismissSharetView];
        };
    }
    return _showShareBtnView;
}

- (void)handleShareWechatWithIndex:(NSInteger)index
{
    UIImage *image = [self imageWithUIView:self.courseShareView];
    if (index > 0) {
        [[WechatShareManager shareInstance] shareImageToWechatWithImage:image AndShareType:index-1];
    }else{
        [self saveShareCourseImage];
    }
    
}

- (UIImage*)imageWithUIView:(UIView*)view

{
    UIGraphicsBeginImageContext(view.bounds.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    [view.layer renderInContext:context];

    UIImage* tImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return tImage;

}



-(void)showShareView
{
    WS(weakSelf);
    [UIView animateWithDuration:.3 animations:^{
        weakSelf.showShareBtnView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, -140);
    } completion:nil];
}

-(void)dismissSharetView
{
    WS(weakSelf);
    [UIView animateWithDuration:.2 animations:^{
        weakSelf.showShareBtnView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
    } completion:^(BOOL finished) {
        if(finished)
        {
            for (UIView *view in weakSelf.showShareBtnView.subviews) {
                [view removeFromSuperview];
            }
            weakSelf.showShareBtnView = nil;
            [weakSelf removeCourseShareView];
        }
    }];
}

- (NSMutableArray *)titleLabArr
{
    if (!_titleLabArr) {
        _titleLabArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleLabArr;
}

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
    if (!_loadingSourceView) {
        return;
    }
    for (UIView *view in _loadingSourceView.subviews) {
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

 
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    [shareBtn setImage:[UIImage imageNamed:@"train_share"] forState:UIControlStateNormal];
//    [shareBtn setImage:[UIImage imageNamed:@"train_share"] forState:UIControlStateNormal];
    
    UIButton *collectBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
    [collectBtn setImage:[UIImage imageNamed:@"train_collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"train_collect_sel"] forState:UIControlStateSelected];
//    [collectBtn setTitle:@"web" forState:UIControlStateNormal];
//    [collectBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    UIBarButtonItem *rightItem1 = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
    
    self.navigationItem.rightBarButtonItems = @[rightItem,rightItem1];;
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _collectBtn = collectBtn;
    
//    [self generateQrCod];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getCourseDetail];
}

- (void)shareBtnClick
{
//    //测试动作界面
//    TestController *vc = [[TestController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view addSubview:self.courseShareView];
    [self.view addSubview:self.showShareBtnView];
    [self showShareView];
    
}

- (void)collectBtnClick
{
//    //web界面
//    CommonWebController *vc = [[CommonWebController alloc] init];
//    vc.title = @"web标题";
//    vc.url = @"https://uat-biz.hidbb.com/";
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self postCollectCourse];
}

#pragma mark - setMainUI
- (void)setMainView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT-60)];
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 246*2*Screen_Scale)];
    [scrollView addSubview:picImageView];
    picImageView.contentMode = UIViewContentModeScaleAspectFill;
    picImageView.image = [UIImage imageNamed:@"train_classbanner"];
    picImageView.clipsToBounds = YES;
    _picImageView = picImageView;
    
    [self.titleLabArr removeAllObjects];
    NSArray *numArr = @[@"44",@"4673",@"33"];
    NSArray *titleArr = @[@"累计播放",@"历史成绩",@"累计消耗千卡"];
    for (int i = 0; i < numArr.count; i++) {
        UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/3*i, picImageView.bottom+32, SCR_WIDTH/3, 14)];
        [scrollView addSubview:numberLab];
        numberLab.textColor = [UIColor colorWithHex:@"#333333"];
        numberLab.font = fontBold(19);
        numberLab.textAlignment = NSTextAlignmentCenter;
        numberLab.text = numArr[i];
        [self.titleLabArr addObject:numberLab];
        
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
    _introLabel = introLabel;
    
    
    //WithFrame:CGRectMake(0, introLabel.bottom, SCR_WIDTH, 38)
    UIView *prepareBgView = [[UIView alloc] init];
    [scrollView addSubview:prepareBgView];
    [prepareBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView.mas_left).offset(0);
        make.top.equalTo(introLabel.mas_bottom).offset(0);
        make.width.mas_equalTo(SCR_WIDTH);
        make.height.mas_equalTo(38);
    }];
    prepareBgView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
    
    
    //WithFrame:CGRectMake(16, 0, prepareBgView.width-32, prepareBgView.height)
    UILabel *prepareBgLab = [[UILabel alloc] init];
    [prepareBgView addSubview:prepareBgLab];
    [prepareBgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(prepareBgView.mas_left).offset(16);
        make.top.equalTo(prepareBgView.mas_top).offset(0);
        make.width.mas_equalTo(SCR_WIDTH-32);
        make.height.mas_equalTo(38);
    }];
    prepareBgLab.textColor = [UIColor colorWithHex:@"#333333"];
    prepareBgLab.font = fontBold(13);
    prepareBgLab.text = @"课前准备";
    
    
    //WithFrame:CGRectMake(28, prepareBgView.bottom+10, SCR_WIDTH-28-16, 24)
    UILabel *prepareLab1 = [[UILabel alloc] init];
    [scrollView addSubview:prepareLab1];
    [prepareLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView.mas_left).offset(28);
        make.top.equalTo(prepareBgView.mas_bottom).offset(10);
        make.width.mas_equalTo(SCR_WIDTH-28-16);
        make.height.mas_equalTo(24);
    }];
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
    
    //WithFrame:CGRectMake(28, prepareLab1.bottom, SCR_WIDTH-28-16, 24)
    UILabel *prepareLab2 = [[UILabel alloc] init];
    [scrollView addSubview:prepareLab2];
    [prepareLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView.mas_left).offset(28);
        make.top.equalTo(prepareLab1.mas_bottom).offset(0);
        make.width.mas_equalTo(SCR_WIDTH-28-16);
        make.height.mas_equalTo(24);
    }];
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
    
    //WithFrame:CGRectMake(28, prepareLab2.bottom, SCR_WIDTH-28-16, 24)
    UILabel *prepareLab3 = [[UILabel alloc] init];
    [scrollView addSubview:prepareLab3];
    [prepareLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView.mas_left).offset(28);
        make.top.equalTo(prepareLab2.mas_bottom).offset(0);
        make.width.mas_equalTo(SCR_WIDTH-28-16);
        make.height.mas_equalTo(24);
    }];
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

- (void)updataCourseView
{
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(_model.detailCover)] placeholderImage:nil];
    for (int i = 0; i < self.titleLabArr.count; i++) {
        UILabel *label = self.titleLabArr[i];
        if (i == 0) {
            label.text = StringNumForId(_model.playTotal, @"0");
        }else if (i == 1){
            label.text = StringNumForId(_model.highScore, @"0");
        }else if (i == 2){
            label.text = StringNumForId(_model.calorieTotal, @"0");
        }
    }
    
    CGFloat introH = [NSString getHeightWithText:StringForId(_model.content) andWithWidth:SCR_WIDTH-32 andWithFont:fontApp(12)];
    _introLabel.height = introH+18+27;
    _introLabel.text = StringForId(_model.content);
    
    _scrollView.contentSize = CGSizeMake(SCR_WIDTH, _introLabel.bottom+38+10+24*3);
    
    if ([StringForId(_model.isCollect) isEqual:@"1"]) {
        _collectBtn.selected = YES;
    }else{
        _collectBtn.selected = NO;
    }
}


#pragma mark - Button
- (void)startTrans
{
//    [GVUserDefaults standardUserDefaults].total = @"2350000";
//    [GVUserDefaults standardUserDefaults].complate = @"0";
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_codeId forKey:@"courseCode"];
    [[CommonNetworkManager share] getVideoByCourseWithUrl:@"ai/video/getVideoByCourse" andBody:body andSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            CourseModel *model = [[CourseModel alloc] init];
            model.name = StringForId(responseAfter[@"name"]);
            model.url = StringForId(responseAfter[@"url"]);
            _courseModel = model;
        }
    } andFailer:^(NSError * _Nonnull error) {
        
    } andProgress:^(double value) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self progressSimulationWithProgress:value];
        });
       
        
    }];
    
    [self.view addSubview:self.loadingSourceView];
//    // 模拟下载进度
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(progressSimulation) userInfo:self repeats:YES];
//    _timer = timer;
}

- (void)progressSimulationWithProgress:(double)progress
{
//    static CGFloat progress = 1.0;
    
    if (progress < 1.0) {
//        progress += 0.01;
        
        // 循环
//        if (progress >= 1.0) progress = 0;
        NSLog(@"%f",progress);;
        self.loadingSourceView.progressView.progress = progress;
//        [self.demoViews enumerateObjectsUsingBlock:^(SDDemoItemView *demoView, NSUInteger idx, BOOL *stop) {
//            demoView.progressView.progress = progress;
//        }];
    }else{
        
        [self removeLoadingView];
        
        TRPlayVideoViewController *vc = [[TRPlayVideoViewController alloc] init];
        vc.courseModel = _courseModel;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - Network
- (void)getCourseDetail
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_codeId forKey:@"code"];
    WS(weakSelf);
    [SVProgressHUD show];
    [ASTrainNetwork getByCourseCodeDetailWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            weakSelf.model = [[HomeListModel alloc] initWithDictionary:responseAfter error:nil];
            [weakSelf updataCourseView];
        }else{
            [SVProgressHUD showInfoWithStatus:StringForId(responseBefore[@"msg"])];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

- (void)postCollectCourse
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_codeId forKey:@"code"];
    NSLog(@"%@",[GVUserDefaults standardUserDefaults].access_token);
    [SVProgressHUD show];
    WS(weakSelf);
    [ASTrainNetwork postCollectSwitchCourseWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if ([StringForId(weakSelf.model.isCollect) isEqual:@"1"]) {
                weakSelf.model.isCollect = @"0";
                weakSelf.collectBtn.selected = NO;
            }else{
                weakSelf.model.isCollect = @"1";
                weakSelf.collectBtn.selected = YES;
            }
        }else{
            [SVProgressHUD showInfoWithStatus:StringForId(responseBefore[@"msg"])];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

- (void)generateQrCod
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:_codeId forKey:@"code"];
    NSLog(@"%@",[GVUserDefaults standardUserDefaults].access_token);
    [SVProgressHUD show];
    WS(weakSelf);
    [ASTrainNetwork generateQrCodWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 保存相册
- (void)saveShareCourseImage
{
    UIGraphicsBeginImageContextWithOptions(self.courseShareView.frame.size, NO, [UIScreen mainScreen].scale);
    [self.courseShareView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //保存完后调用的方法
    SEL selector = @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:);
    //保存
    UIImageWriteToSavedPhotosAlbum(snapshotImage, self, selector, NULL);
}




//图片保存完后调用的方法
- (void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error){
        //保存失败
#ifdef DEBUG
        [SVProgressHUD showInfoWithStatus:@"保存相册失败"];
        //                NSLog(@"屏幕截图保存相册失败：%@",error);
#endif
    }else {
        //保存成功
#ifdef DEBUG
        [SVProgressHUD showInfoWithStatus:@"保存相册成功"];
        //                NSLog(@"屏幕截图保存相册成功");
#endif
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
