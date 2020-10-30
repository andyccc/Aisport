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
#import "WechatShareManager.h"
#import <WXApi.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:@"wx2846e9f646cea330" universalLink:@"https://ap.hidoba.com/app/"];
    NSString *version = [WXApi getApiVersion];  //1.8.7.1

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    vc1.view.backgroundColor = [UIColor whiteColor];;
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_nor"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_sel"];
    
    MineViewController *vc2 = [[MineViewController alloc] init];
    vc2.view.backgroundColor = [UIColor whiteColor];;
    vc2.title = @"我的";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_mine_nor"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mine_sel"];
    
//    HomeViewController *homeVC = [[HomeViewController alloc] init];
//    homeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home_nor"];
//    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_sel"];
//    BaseNavigationController *navc1 = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
//
//
//    MineViewController *mineVC = [[MineViewController alloc] init];
//    mineVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_mine_nor"];
//    mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_mine_sel"];
//    BaseNavigationController *navc2 = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    
    BaseNavigationController *navC1 = [[BaseNavigationController alloc] initWithRootViewController:vc1];
    BaseNavigationController *navC2 = [[BaseNavigationController alloc] initWithRootViewController:vc2];
    
    self.baseTabbar = [[MSTabBarController alloc] init];
    self.baseTabbar.itemTitleColor = [UIColor colorWithHex:@"#443C48"];
    self.baseTabbar.selectedItemTitleColor = [UIColor colorWithHex:@"#1BC2B1"];
    self.baseTabbar.viewControllers = @[navC1,navC2];
    
    LoginOrRegisterController* loginVc = [[LoginOrRegisterController alloc]init];
    appDelegate.loginNav = [[BaseNavigationController alloc]initWithRootViewController:loginVc];
    
//    [GVUserDefaults standardUserDefaults].access_token = @"";
    if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""])
    {
        self.window.rootViewController = self.baseTabbar;
        [self.window makeKeyAndVisible];

        appDelegate.loginNav.modalPresentationStyle = 0;
        [navC1 presentViewController:appDelegate.loginNav animated:YES completion:nil];
        [self.window makeKeyAndVisible];

    }else
    {

        self.window.rootViewController = self.baseTabbar;
        [self.window makeKeyAndVisible];
        
       
    }

    
    
    
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
  if ([url.absoluteString containsString:[NSString stringWithFormat:@"%@://platformId=wechat", @""]]) {
            return [WechatShareManager handleOpenUrl:url];
    }
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

@end
