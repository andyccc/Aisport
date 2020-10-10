//
//  AppDelegate.m
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "LoginOrRegisterController.h"
#import "MineViewController.h"
#import "NewMineViewController.h"
#import "WechatShareManager.h"
#import <WXApi.h>
#import "WCDBService.h"
#import "MyTrainHViewController.h"
#import "AppBootVC.h"
#import "LoginNetWork.h"
#import "UUID.h"
#import "NewHomeViewController.h"
#import "SplashView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //AppID   wx2846e9f646cea330
    //AppSecret  a81e641196edec3aaeaefcbaaab17a8a    //ap.hidbb.com
    [WXApi registerApp:@"wx2846e9f646cea330" universalLink:@"https://ap.hidbb.com/app/"];
    NSString *version = [WXApi getApiVersion];  //1.8.7.1
//    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult * _Nonnull result) {
//        NSLog(@"%@,%u,%@,%@",@(step),result.success,result.errorInfo,result.suggestion);
//    }];
    [SVProgressHUD setBorderWidth:0];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];

    [GVUserDefaults standardUserDefaults].firstEnter = 0;
    [GVUserDefaults standardUserDefaults].firstInfoEnter = 0;
    [self initConfig];
    [LoginNetWork getAppVersion];
    [self saveDevice];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *vcs = [NSMutableArray array];
    
    
    {
        NewHomeViewController *vc1 = [[NewHomeViewController alloc] init];
        vc1.view.backgroundColor = [UIColor whiteColor];
        vc1.title = @"发现";
        vc1.tabBarItem.image = [UIImage imageNamed:@"icon_found"];
        vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_found_sel"];
        BaseNavigationController *navC1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
        [vcs addObject:navC1];
    }
    
    
    
    {
        
        NewMineViewController *vc3 = [[NewMineViewController alloc] init];
        vc3.view.backgroundColor = [UIColor whiteColor];;
        vc3.title = @"我的";
        vc3.tabBarItem.image = [UIImage imageNamed:@"icon_mine"];
        vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_mine_sel"];
        BaseNavigationController *navC3 = [[BaseNavigationController alloc] initWithRootViewController:vc3];
        [vcs addObject:navC3];

    }
    
    
    
    
    {
        HomeViewController *vc1 = [[HomeViewController alloc] init];
        vc1.view.backgroundColor = [UIColor whiteColor];
        vc1.title = @"发现x";
        vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover_nor"];
        vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_sel"];
        BaseNavigationController *navC1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
        [vcs addObject:navC1];
    }
    
    
    
    {
        MyTrainHViewController *vc2 = [[MyTrainHViewController alloc] init];
        vc2.view.backgroundColor = [UIColor whiteColor];;
        vc2.title = @"我的x";
        vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_my_nor"];
        vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_my_sel"];
        BaseNavigationController *navC2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
        [vcs addObject:navC2];

    }
    
    {
        
        MineViewController *vc3 = [[MineViewController alloc] init];
        vc3.view.backgroundColor = [UIColor whiteColor];;
        vc3.title = @"账号x";
        vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_account_nor"];
        vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_account_sel"];
        BaseNavigationController *navC3 = [[BaseNavigationController alloc] initWithRootViewController:vc3];
        [vcs addObject:navC3];

    }

    
    
    self.baseTabbar = [[MSTabBarController alloc] init];
    self.baseTabbar.itemTitleColor = [UIColor colorWithHex:@"#999999"];
    self.baseTabbar.selectedItemTitleColor = [UIColor colorWithHex:@"#FBB313"];
    self.baseTabbar.viewControllers = vcs;
    
    LoginOrRegisterController* loginVc = [[LoginOrRegisterController alloc]init];
    appDelegate.loginNav = [[BaseNavigationController alloc]initWithRootViewController:loginVc];
    
    if ([GVUserDefaults standardUserDefaults].runCount == 0) {
        [GVUserDefaults standardUserDefaults].runCount ++ ;
        self.window.rootViewController = [[AppBootVC alloc] init];
        [self.window makeKeyAndVisible];
    }else{
        [GVUserDefaults standardUserDefaults].runCount ++ ;
        self.window.rootViewController = self.baseTabbar;
        [self.window makeKeyAndVisible];
    //    [GVUserDefaults standardUserDefaults].access_token = @"";
//        if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""])
//        {
//            self.window.rootViewController = self.baseTabbar;
//            [self.window makeKeyAndVisible];
//
//            appDelegate.loginNav.modalPresentationStyle = 0;
//            [navC1 presentViewController:appDelegate.loginNav animated:YES completion:nil];
//            [self.window makeKeyAndVisible];
//
//        }else
//        {
//
//            self.window.rootViewController = self.baseTabbar;
//            [self.window makeKeyAndVisible];
//
//
//        }

    }
    
    
    [SplashView show];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
//    if (url) {
//        <#statements#>
//    }
    return [WechatShareManager handleOpenUrl:url];
}

- (void)saveDevice
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    NSString *uuid = [UUID getUUIDByKeyChain];
    [GVUserDefaults standardUserDefaults].uuid = uuid;
    [body setObject:uuid forKey:@"deviceId"];
    [body setObject:@"ios" forKey:@"deviceType"];
    [body setObject:[NSString stringWithFormat:@"%f",SCR_WIDTH] forKey:@"screenWide"];
    [body setObject:[NSString stringWithFormat:@"%f",SCR_HIGHT] forKey:@"screenHigh"];
    [LoginNetWork postSaveDeviceWith:nil WithHeaders:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

- (void)showLogin
{
    appDelegate.loginNav.modalPresentationStyle = 0;
    appDelegate.baseTabbar.selectedIndex = 0;
    [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:nil];
}

- (void)initConfig
{
    // 配置数据库并启动
    NSString *loginedUserId = @"123";
    
    [WCDBService setDBName:loginedUserId];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enterBackgroundStop" object:nil];
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enterForegroundPlay" object:nil];
}

@end
