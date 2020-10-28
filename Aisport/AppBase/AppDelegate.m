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

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    BaseNavigationController *navc1 = [[BaseNavigationController alloc] initWithRootViewController:homeVC];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    BaseNavigationController *navc2 = [[BaseNavigationController alloc] initWithRootViewController:mineVC];
    
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.viewControllers = @[navc1,navc2];
    
    LoginOrRegisterController* loginVc = [[LoginOrRegisterController alloc]init];
    appDelegate.loginNav = [[BaseNavigationController alloc]initWithRootViewController:loginVc];
    
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    appDelegate.loginNav.modalPresentationStyle = 0;
    [navc1 presentViewController:appDelegate.loginNav animated:YES completion:nil];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

@end
