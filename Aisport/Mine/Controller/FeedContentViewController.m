//
//  InviteViewController.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "FeedContentViewController.h"
#import "UITextView+ZWPlaceHolder.h"
#import "MineNetworkManager.h"


@interface FeedContentViewController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *subBtn;


@end

@implementation FeedContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈建议";
    self.view.backgroundColor = [UIColor colorWithHex:@"#F4F4F4"];

    [self createView];
}

- (void)subAction
{
    NSString *cipher = self.textView.text;
    if (![cipher length]) {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"content"] = cipher;
    
    [SVProgressHUD show];
    [MineNetworkManager feedContentWith:params AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD showSuccessWithStatus:@"操作成功"];
        self.textView.text = nil;
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
    }];
}

- (void)createView
{
    _textView = [[UITextView alloc] init];
    _textView.width = SCR_WIDTH - uiv(16*2);
    _textView.height = uiv(120);
    _textView.left = uiv(16);
    _textView.top = uiv(16)+SafeAreaTopHeight;
    _textView.backgroundColor = [UIColor whiteColor];
    _textView.layer.cornerRadius = uiv(5);
    _textView.layer.masksToBounds = YES;
    _textView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    _textView.font = FontR(15);
    _textView.zw_placeHolder = @"您有什么反馈或建议可以写下来哦，以便我们为您提供更好的服务";
    _textView.zw_placeHolderColor = [UIColor colorWithHex:@"#999999"];
    [self.view addSubview:_textView];
    
    _subBtn = [[UIButton alloc] init];
    _subBtn.width = uiv(306);
    _subBtn.height = uiv(44);
    _subBtn.centerX = SCR_WIDTH / 2;
    _subBtn.top = _textView.bottom + uiv(24);
    _subBtn.backgroundColor = [UIColor colorWithHex:@"#FBB313"];
    _subBtn.layer.cornerRadius = _subBtn.height/2.0;
    _subBtn.layer.masksToBounds = YES;
    [_subBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_subBtn addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_subBtn];

}

@end
