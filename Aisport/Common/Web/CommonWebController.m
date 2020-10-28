//
//  CommonWebController.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "CommonWebController.h"
#import "WebviewProgressLine.h"
#import <WebKit/WebKit.h>

@interface CommonWebController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) WebviewProgressLine *progressLine;

@end

@implementation CommonWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
//    [_webView scalesPageToFit];
    // UI代理
    _webView.UIDelegate = self;
    // 导航代理
    _webView.navigationDelegate = self;
    // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
    _webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:_webView];

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self setUpNavProgressLine];
    // Do any additional setup after loading the view.
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [_progressLine startLoadingAnimation];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [_progressLine endLoadingAnimation];
//[self.progressView setProgress:0.0f animated:NO];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_progressLine endLoadingAnimation];
}

- (void)setUpNavProgressLine
{
    _progressLine = [[WebviewProgressLine alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 2)];
    _progressLine.lineColor = [UIColor colorWithHex:@"#476ed7"];
    [self.view addSubview:_progressLine];
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
