//
//  BaseViewController.m
//  aisport
//
//  Created by Apple on 2020/10/18.
//

#import "BaseViewController.h"
#import "LoginNetWork.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
}

- (void)setRightNavBtnWithIcon:(NSString *)icon
{
    [self setRightNavBtn:nil icon:icon];
}

- (void)setRightNavBtnWithTitle:(NSString *)title
{
    [self setRightNavBtn:title icon:nil];
}

- (void)setRightNavBtn:(NSString *)title icon:(NSString *)icon
{
    if (!title && !icon ) {
        return;
    }
    
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 50)];
    if (title) {
        [saveBtn setTitle:title forState:UIControlStateNormal];
    }
    
    if (icon) {
        [saveBtn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    }
    
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:saveBtn];
    
    [saveBtn addTarget:self action:@selector(rightNavBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rightNavBtnAction
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self getCreatePageSession];
    
    NSLog(@"viewWillAppear : %@", [self description]);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self postGetEventWithEvent:@"exiit"];
    
    
    NSLog(@"viewWillAppear : %@", [self description]);
}

- (void)postGetEventWithEvent:(NSString *)event
{
//    long long endTime = [DatetimeOpeartion getCurrentSeconds];
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setObject:event forKey:@"Event"];
    [body setObject:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forKey:@"Event-Time"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].user_Id) forKey:@"User-Id"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].page_Session_Id) forKey:@"Page-Session-Id"];
    [body setObject:StringForId([GVUserDefaults standardUserDefaults].uuid) forKey:@"Device-Id"];
    [body setObject:@"HomeViewController" forKey:@"Source-Url"];
    [body setObject:NSStringFromClass([self class]) forKey:@"Current-Url"];
    [LoginNetWork getPageEventWith:nil WithHeaders:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
                
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getCreatePageSession
{
    [LoginNetWork getCreatePageSessionWith:nil WithHeaders:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            [GVUserDefaults standardUserDefaults].page_Session_Id = StringForId(responseAfter);
            [self postGetEventWithEvent:@"load"];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}


//支持旋转
-(BOOL)shouldAutorotate{
    return false;
}
//支持的方向 因为界面A我们只需要支持竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
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
