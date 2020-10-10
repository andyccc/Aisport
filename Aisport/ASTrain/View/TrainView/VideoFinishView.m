//
//  VideoFinishView.m
//  Aisport
//
//  Created by Apple on 2020/11/26.
//

#import "VideoFinishView.h"
#import "WebviewProgressLine.h"
#import <WebKit/WebKit.h>
#import "ShowShareBtnView.h"
#import "WechatShareManager.h"


@interface VideoFinishView ()<WKScriptMessageHandler,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) WebviewProgressLine *progressLine;

@property (nonatomic, strong) ShowShareBtnView *showShareBtnView;
@property (nonatomic, strong) UIView *coverView;


@end

@implementation VideoFinishView

- (instancetype)initWithFrame:(CGRect)frame Url:(NSString *)urlStr IsReachability:(BOOL)isReachability
{
    if (self = [super initWithFrame:frame]) {
        
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        [userContentController addScriptMessageHandler:self name:@"showVideoAction"];//showVideoAction
        [userContentController addScriptMessageHandler:self name:@"trainingBack"];
        [userContentController addScriptMessageHandler:self name:@"pageGoBack"];
        [userContentController addScriptMessageHandler:self name:@"sendResultMomentShare"];
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.userContentController = userContentController;

        
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCR_max, SCR_min) configuration:configuration];
    //    [_webView scalesPageToFit];
        // UI代理
        _webView.UIDelegate = self;
        // 导航代理
        _webView.navigationDelegate = self;
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [self addSubview:_webView];

    //    [_webView evaluateJavaScript:@"pageGoBack" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    //
    //    }];

//        if (isReachability) {
//            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
//        }else{
//
//        }
        NSString *path = [[NSBundle mainBundle] pathForResource:@"train-result/index" ofType:@"html"];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSString *URLString = [url absoluteString];
        NSString *queryString = [NSString stringWithFormat:@"?%@",urlStr];
//        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:queryString] invertedSet];
        NSString *hString = [queryString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

//        NSString * [queryString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
//        [queryString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *URLwithQueryString = [URLString stringByAppendingString:hString];
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:URLwithQueryString]]];
        
        [self setUpNavProgressLine];

        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-263.0/2, SCR_HIGHT-63-37, 263, 37)];
        [self addSubview:backButton];
        [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(20);
            make.left.equalTo(self.mas_left).offset(18+StatusHeight);
            make.height.mas_equalTo(25);
            make.width.mas_equalTo(25);
        }];
        [backButton setImage:[UIImage imageNamed:@"train_finishback"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(clickBackButton) forControlEvents:UIControlEventTouchUpInside];
        backButton.hidden = YES;
    }
    
    return self;
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
    [self addSubview:_progressLine];
}


//WKScriptMessageHandler协议方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    //code
    if ([message.name isEqual:@"trainingBack"]) {
        if (self.videoReStartPlayBlock) {
            self.videoReStartPlayBlock();
        }
//        _webView.height = SCR_HIGHT-1-SafeAreaBottomHeight;
//        _startBtn.hidden = NO;
//        _codeId = StringForId(message.body[@"code"]);
    }else if ([message.name isEqual:@"sendResultMomentShare"]){
//        _shareType = 2;
//        _reslutID = StringForId(message.body[@"id"]);
//        _name = StringForId(message.body[@"song"]);
        
        if ([StringForId(_reslutID) isEqual:@""]) {
            [SVProgressHUD showInfoWithStatus:@"暂无网络"];
            return;
        }
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        coverView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.2];
        [window addSubview:coverView];
        self.coverView = coverView;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideCover)];
        [coverView addGestureRecognizer:tap];
        
        [window addSubview:self.showShareBtnView];
        [self showShareView];
    }else if ([message.name isEqual:@"pageGoBack"]){
        if (self.videoFinishBlock) {
            self.videoFinishBlock();
        }
    }
//    else if ([message.name isEqual:@"pageGoBack"]){
//        [self.navigationController popViewControllerAnimated:YES];
//    }else if ([message.name isEqual:@"sendVideoAction"]){
//        _codeId = StringForId(message.body[@"code"]);
//        [self videoStartTrans];
//    }
    NSLog(@"name = %@, body = %@", message.name, message.body);
    
}

- (void)setUrl:(NSString *)url
{
    _url = url;
}

- (ShowShareBtnView *)showShareBtnView
{
    if (!_showShareBtnView) {
        _showShareBtnView = [[ShowShareBtnView alloc] initWithFrame:CGRectMake(0, SCR_HIGHT, SCR_WIDTH, 141)];
        WS(weakSelf);
        _showShareBtnView.clickShareBlock = ^(NSInteger index) {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@?randomcode=%@&token=%@&id=%@&isIosShare=true",Host_Url_Web,@"trainingResultFinal",StringForId([GVUserDefaults standardUserDefaults].randomcode),[GVUserDefaults standardUserDefaults].access_token,StringForId(weakSelf.reslutID)];
            [[WechatShareManager shareInstance] shareWebUrlToWechatWithUrl:urlStr Title:StringForId(weakSelf.name) Description:@"我在嗨动AI跳舞取得了惊人得分，快来挑战我吧！" CoverImage:[UIImage imageNamed:@"logo"] AndShareType:index];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
