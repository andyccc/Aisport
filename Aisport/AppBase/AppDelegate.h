//
//  AppDelegate.h
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic,strong) BaseNavigationController* loginNav;
@property (strong, nonatomic) MSTabBarController* baseTabbar;

- (void)showLogin;


@end

