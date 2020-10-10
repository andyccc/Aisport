//
//  CommonWebController.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "CommonWebController.h"
#import "WebviewProgressLine.h"
#import <WebKit/WebKit.h>

@interface CommonWebController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) WebviewProgressLine *progressLine;

@end

@implementation CommonWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:@"pageGoBack"];//showVideoAction
    [userContentController addScriptMessageHandler:self name:@"beforeVideoMounted"];//showVideoAction
    [userContentController addScriptMessageHandler:self name:@"sendVideoAction"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;

    
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT) configuration:configuration];
//    [_webView scalesPageToFit];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:_webView];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self setUpNavProgressLine];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"pageGoBack"];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
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
    if ([message.name isEqual:@"pageGoBack"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
    NSLog(@"name = %@, body = %@", message.name, message.body);
    
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
