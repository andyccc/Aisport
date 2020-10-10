//
//  VideoDetailWebController.m
//  Aisport
//
//  Created by Apple on 2020/11/25.
//

#import "VideoDetailWebController.h"
#import "WebviewProgressLine.h"
#import <WebKit/WebKit.h>

#import "LoadingSourceView.h"
#import "Aisport-Swift.h"

#import "ShowShareBtnView.h"
#import "WechatShareManager.h"
#import "UIImageView+WebCache.h"
#import "VideoTrainDataService.h"
#import "DownLoadModel.h"
#import "VideoTrainData.h"


@interface VideoDetailWebController ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) WebviewProgressLine *progressLine;

@property (nonatomic, strong) LoadingSourceView *loadingSourceView;
@property (nonatomic, strong) CourseModel *courseModel;

@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, strong) ShowShareBtnView *showShareBtnView;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIImage *coverImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *reslutID;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *curHighScore;

@property (nonatomic, assign) NSInteger shareType;  //1 详情分享  2 结果页分享

@end

@implementation VideoDetailWebController

- (ShowShareBtnView *)showShareBtnView
{
    if (!_showShareBtnView) {
        _showShareBtnView = [[ShowShareBtnView alloc] initWithFrame:CGRectMake(0, SCR_HIGHT, SCR_WIDTH, 141)];
        WS(weakSelf);
        _showShareBtnView.clickShareBlock = ^(NSInteger index) {
            if (weakSelf.shareType == 1) {
                NSString *urlStr = [NSString stringWithFormat:@"%@%@?randomcode=%@&token=%@&code=%@&isIosShare=true&isDownloaded=",Host_Url_Web,@"trainingDetail",StringForId([GVUserDefaults standardUserDefaults].randomcode),[GVUserDefaults standardUserDefaults].access_token,StringForId(weakSelf.codeId)];
                if ([[NSUserDefaults standardUserDefaults] boolForKey:weakSelf.codeId]) {
                    urlStr = [NSString stringWithFormat:@"%@1",urlStr];
                }
                [[WechatShareManager shareInstance] shareUrlToWechatWithUrl:urlStr Code:weakSelf.codeId Title:weakSelf.name Description:weakSelf.content CoverImage:weakSelf.coverImage AndShareType:index];
            }else if (weakSelf.shareType == 2){
                NSString *urlStr = [NSString stringWithFormat:@"%@%@?randomcode=%@&token=%@&id=%@&isIosShare=true",Host_Url_Web,@"trainingResultFinal",StringForId([GVUserDefaults standardUserDefaults].randomcode),[GVUserDefaults standardUserDefaults].access_token,StringForId(weakSelf.reslutID)];
                [[WechatShareManager shareInstance] shareWebUrlToWechatWithUrl:urlStr Title:StringForId(weakSelf.name) Description:@"我在嗨动AI跳舞取得了惊人得分，快来挑战我吧！" CoverImage:[UIImage imageNamed:@"logo"] AndShareType:index];
            }
            [weakSelf hideCover];
        };
    }
    return _showShareBtnView;
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
            [weakSelf.showShareBtnView removeFromSuperview];
            weakSelf.showShareBtnView = nil;
        }
    }];
}

- (void)hideCover
{
    [self dismissSharetView];
    [_coverView removeFromSuperview];
    _coverView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [VideoTrainDataService setDBName:StringForId(_codeId)];
    NSArray *arrm = [VideoTrainDataService queryWithVideoCode:StringForId(_codeId)];
    for (VideoTrainData *trainData in arrm) {
        NSInteger dayNum = [DatetimeOpeartion compareWithStartDate:[DatetimeOpeartion getDateStrYYYYMMDDWith:trainData.endTime] AndEndDate:[DatetimeOpeartion getNowTime]];
        if (dayNum > 7) {
            [VideoTrainDataService deleteWithVideoCode:trainData.videoCode];
        }
        
    }
    
    
    _shareType = 0;
    [GVUserDefaults standardUserDefaults].enterDetailCount ++;
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"pageGoBack"];//showVideoAction
    [userContentController addScriptMessageHandler:self name:@"beforeVideoMounted"];//showVideoAction
    [userContentController addScriptMessageHandler:self name:@"sendVideoAction"];
    [userContentController addScriptMessageHandler:self name:@"sendDetailShare"];
    [userContentController addScriptMessageHandler:self name:@"sendResultShare"];
    [userContentController addScriptMessageHandler:self name:@"trainingBack"];
    [userContentController addScriptMessageHandler:self name:@"sendBuriedEvent"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;

    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT) configuration:configuration];
    _webView.scrollView.scrollEnabled = NO;
//    [_webView scalesPageToFit];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:_webView];

//    [_webView evaluateJavaScript:@"pageGoBack" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
//
//    }];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
//    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]]]];
    [self setUpNavProgressLine];

    
//    UIButton *startBtn = [[UIButton alloc] init];
//    [self.view addSubview:startBtn];
////    startBtn.backgroundColor = [UIColor colorWithHex:@"36C2AF"];
//    startBtn.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
//    [startBtn setTitle:@"嗨动吧！" forState:UIControlStateNormal];
//    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [startBtn addTarget:self action:@selector(startTrans) forControlEvents:UIControlEventTouchUpInside];
//    startBtn.titleLabel.font = fontBold(16);
//    startBtn.hidden = YES;
//
//    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(self.view);
//        make.height.mas_equalTo(1+SafeAreaBottomHeight);
//        make.bottom.mas_equalTo(self.view.mas_bottom);
//    }];
//    _startBtn = startBtn;
    
//    if (_fromType == 1) {
//        _startBtn.hidden = NO;
//        _webView.height = SCR_HIGHT-1-SafeAreaBottomHeight;
////        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:StringForId(_codeId)];
//    }
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"pageGoBack"];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [VideoTrainDataService queryWithVideoCode:StringForId(_codeId)];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [SVProgressHUD show];
    [_progressLine startLoadingAnimation];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
    [_progressLine endLoadingAnimation];
//[self.progressView setProgress:0.0f animated:NO];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
    [_progressLine endLoadingAnimation];
    
//    //核心方法如下
//    JSContext *content = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    //此处的getMessage和JS方法中的getMessage名称一致.
//    content[@"getMessage"] = ^() {
//        NSArray *arguments = [JSContext currentArguments];
//        for (JSValue *jsValue in arguments) {
//            NSLog(@"=======%@",jsValue);
//        }
//    };

}

- (void)setUpNavProgressLine
{
    _progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 2)];
    _progressLine.lineColor = [UIColor colorWithHex:@"#476ed7"];
    [self.view addSubview:_progressLine];
}


//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //code
    
    if ([message.name isEqual:@"beforeVideoMounted"]) {
        if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]) {
            appDelegate.loginNav.modalPresentationStyle = 0;
            [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:nil];
            [self.navigationController popToRootViewControllerAnimated:NO];
    //        appDelegate.baseTabbar.selectedIndex = 0;
            return;
        }
//        _webView.height = SCR_HIGHT-1-SafeAreaBottomHeight;
//        _startBtn.hidden = NO;
        _codeId = StringForId(message.body[@"code"]);
    }else if ([message.name isEqual:@"pageGoBack"]){
        if (self.fromType == 3) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else if ([message.name isEqual:@"sendVideoAction"]){
        _codeId = StringForId(message.body[@"code"]);
        _author = StringForId(message.body[@"author"]);
        _curHighScore = StringForId(message.body[@"highScore"]);
        [self videoStartTrans];
    }else if ([message.name isEqual:@"sendDetailShare"]){
        _shareType = 1;
        _codeId = StringForId(message.body[@"code"]);
        _name = StringForId(message.body[@"name"]);
        _content = StringForId(message.body[@"content"]);
        WS(weakSelf);
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager loadImageWithURL:[NSURL URLWithString:StringForId(message.body[@"cover"])] options:SDWebImageHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            weakSelf.coverImage = image;
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
            coverView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.2];
            [window addSubview:coverView];
            weakSelf.coverView = coverView;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCover)];
            [coverView addGestureRecognizer:tap];
            
            [window addSubview:self.showShareBtnView];
            [weakSelf showShareView];
        }];
    
//        [self videoStartTrans];
    }else if ([message.name isEqual:@"sendResultShare"]){
        _shareType = 2;
        _reslutID = StringForId(message.body[@"id"]);
        _name = StringForId(message.body[@"song"]);
        WS(weakSelf);
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        [manager loadImageWithURL:[NSURL URLWithString:StringForId(message.body[@"cover"])] options:SDWebImageHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            weakSelf.coverImage = image;
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
            coverView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.2];
            [window addSubview:coverView];
            weakSelf.coverView = coverView;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCover)];
            [coverView addGestureRecognizer:tap];
            
            [window addSubview:self.showShareBtnView];
            [weakSelf showShareView];
        }];
    }else if ([message.name isEqual:@"trainingBack"]){
        [self.navigationController popViewControllerAnimated:NO];
        
        
    }else if ([message.name isEqual:@"sendBuriedEvent"]){
        
    }
  
    NSLog(@"name = %@, body = %@", message.name, message.body);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if ([webView.URL.absoluteString containsString:@"pageGoBack"]) {
        [[UIApplication sharedApplication] openURL:webView.URL];
    }
    if (navigationAction.targetFrame == nil) {
        [webView loadRequest:navigationAction.request];
    }  else {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    decisionHandler(WKNavigationActionPolicyCancel);
}



- (LoadingSourceView *)loadingSourceView
{
    if (!_loadingSourceView) {
        _loadingSourceView = [[LoadingSourceView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _loadingSourceView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.5];
        WS(weakSelf);
        _loadingSourceView.cancleLoadingBlock = ^{
            [[CommonNetworkManager share] cancleDownLoad];
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
    
//    [_timer invalidate];
//    _timer = nil;
}

- (void)videoStartTrans
{
    
   
}

/*
 {
     code = 0;
     data =     {
         actionList =         (
         );
         code = 402011241;
         detailMd5 = "<null>";
         detailSize = "<null>";
         detailUrl = "<null>";
         internetUrl = "<null>";
         modelAddress = "https://pub-1302721296.cos.ap-shanghai.myqcloud.com/video_pack/1606205678.zip";
         modelMd5 = a84c002deb9fdc39316f7017635c0c21;
         modelName = "1606205678.zip";
         modelSize = 2052737;
         modelTime = "2020-11-24 16:15:07";
         name = "Don't_Start_Now";
         nodeVoiceList = "<null>";
         size = "<null>";
         time = 0;
         totalSize = 2052737;
         triggerVoiceList = "<null>";
         unzipPassword = "<null>";
         url = "https://pub.hidbb.com/ai-dev/ai-video/f93de090cef04aec9f639b35c705f852.mp4";
         voiceIds = "<null>";
     };
     msg = "<null>";
 }
 */

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
        if ([[NSUserDefaults standardUserDefaults] boolForKey:_codeId]) {
            return;
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:StringForId(_codeId)];
        [self removeLoadingView];
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    
        }];
    }
}

#pragma mark - plist本地存储资源信息
- (void)insertToPlist:(NSDictionary *)dictionary nickName:(NSString *)nickName {
//    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"chatRoom.plist"];
    
    //获取Document文件
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:_codeId];//将需要创建的串拼接到后面
//        NSString * dataFilePath = [docsdir stringByAppendingPathComponent:@"AnnouncementData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
//        BOOL dataIsDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
//        BOOL dataExisted = [fileManager fileExistsAtPath:dataFilePath isDirectory:&dataIsDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *extention = @"mp4";
//    NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@/%@.plist", documentsDirectory, _codeId, @"videoResource"];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //下边if判断很重要，不然会写入失败.
    if (!userDict) {
        userDict = [[NSMutableDictionary alloc] init];
    }
    //设置属性值
    [userDict setObject:dictionary forKey:nickName];
    //写入文件
    [userDict writeToFile:plistPath atomically:YES];
}
//注意：如果想每次都替换数据，把上边的[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]改成：[[NSMutableDictionary alloc] init]，if语句三行代码去掉即可

//2.读取plist（代码创建的plist文件）
- (NSMutableDictionary *)getPlistDictionary:(NSString *)nickName
{
//    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"chatRoom.plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@/%@.plist", documentsDirectory, _codeId, @"videoResource"];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc ]initWithContentsOfFile:plistPath];
    return userDict;
    //userDict[nickName]就是上边方法存入的字典,取出来就可以进行相应的赋值操作啦
}

#pragma mark - Network

- (void)getVideoResourceWithIsDownLoad:(BOOL)isDownLoad
{
    
}

//- (void)goToDownloadResourceWith:(id  _Nullable)responseObject
//{
//    WS(weakSelf);
//    [[CommonNetworkManager share] goToDownloadResourceWith:responseObject WithCourseId:_codeId AndSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
//
//    } andFailer:^(NSError * _Nonnull error) {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *cachesPath = [paths objectAtIndex:0];
//        NSString *pathString = [NSString stringWithFormat:@"%@/%@",cachesPath,weakSelf.codeId];
//        [[NSFileManager defaultManager] removeItemAtPath:pathString error:&error];
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:StringForId(weakSelf.codeId)];
//        [weakSelf removeLoadingView];
//
//    } andProgress:^(double value) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self progressSimulationWithProgress:value];
//        });
//    }];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
