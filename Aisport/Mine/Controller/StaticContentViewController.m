//
//  StaticContentViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "StaticContentViewController.h"

@interface StaticContentViewController ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation StaticContentViewController

- (void)loadView
{
    UIScrollView *scorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, UIScreenHeight)];
//    scorllView.contentInset = UIEdgeInsetsMake(SafeAreaTopHeight, 0, SafeAreaBottomHeight, 0);
    self.view = scorllView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createView];
    [self loadContent];
}

- (void)loadContent
{
    NSString *fileName = nil;
    if (self.contentType == StaticContentTypeIntro) {
        fileName = @"intro";
        self.title = @"企业介绍";
    } else if (self.contentType == StaticContentTypeUser) {
        fileName = @"user";
        self.title = @"用户协议";
    } else if (self.contentType == StaticContentTypePrivate) {
        fileName = @"private";
        self.title = @"隐私政策";
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"intro" ofType:@"txt"];
    if (path) {
        NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        self.contentLabel.text = content;
        [self.contentLabel sizeToFit];
        UIScrollView *scorllView = (UIScrollView *)self.view;
        scorllView.contentSize = CGSizeMake(scorllView.width, self.contentLabel.height);
    }
}

- (void)createView
{
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.width = SCR_WIDTH - uiv(16)*2;
    self.contentLabel.numberOfLines = 99999;
    self.contentLabel.font = FontR(16);
    self.contentLabel.textColor = [UIColor colorWithHex:@"#333333"];
    self.contentLabel.left = uiv(16);
    self.contentLabel.top = uiv(16);
    [self.view addSubview:self.contentLabel];
    
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
