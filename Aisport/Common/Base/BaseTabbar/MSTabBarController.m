//
//  MSTabBarController.m
//  MSTabBarController 
//
//  Created by  Admxjx on 16/7/1.
//  Copyright © 2016年  Admxjx. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSTabBar.h"
#import "MSTabBarCONST.h"
#import "MSTabBarItem.h"

@interface MSTabBarController () <MSTabBarDelegate>

@property (nonatomic, strong) MSTabBar *MSTabBar;

@end

@implementation MSTabBarController

#pragma mark -

- (UIColor *)itemTitleColor {
    
    if (!_itemTitleColor) {
        
        _itemTitleColor = [UIColor colorWithHex:@"#443C48"];
    }
    return _itemTitleColor;
}

- (UIColor *)selectedItemTitleColor {
    
    if (!_selectedItemTitleColor) {
        
        _selectedItemTitleColor = [UIColor colorWithHex:@"#1BC2B1"];
    }
    return _selectedItemTitleColor;
}

- (UIFont *)itemTitleFont {
    
    if (!_itemTitleFont) {
        
        _itemTitleFont = [UIFont systemFontOfSize:10.0f];
    }
    return _itemTitleFont;
}

- (UIFont *)badgeTitleFont {
    
    if (!_badgeTitleFont) {
        
        _badgeTitleFont = [UIFont systemFontOfSize:11.0f];
    }
    return _badgeTitleFont;
}

#pragma mark -

- (void)loadView {
    
    [super loadView];
    
    self.itemImageRatio = 0.70f;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor redColor];
    self.tabBar.translucent = NO;
//    self.tabBar.backgroundColor = [UIColor colorWithRed:.1 green:.1 blue:.1 alpha:.7];
    
    [self.tabBar addSubview:({
        
        MSTabBar *tabBar = [[MSTabBar alloc] init];
        tabBar.frame     = self.tabBar.bounds;
        tabBar.delegate  = self;
        
        self.MSTabBar = tabBar;
    })];
//    UIKeyboardWillShowNotification
//    [[NSNotificationCenter defaultCenter] addobserver];
}

//- (void)viewWillLayoutSubviews {
//    
//    [super viewWillLayoutSubviews];
//    
//    
//}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    for (UIView * view in self.tabBar.subviews)
    {
        
        if (![view isKindOfClass:[MSTabBar class]]) {
            
            [view removeFromSuperview];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self removeOriginControls];
}

- (void)removeOriginControls {
    [self.tabBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * obj, NSUInteger idx, BOOL * stop) {
        
        if ([obj isKindOfClass:[UIControl class]]) {
            
            [obj removeFromSuperview];
        }
    }];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    self.MSTabBar.badgeTitleFont         = self.badgeTitleFont;
    self.MSTabBar.itemTitleFont          = self.itemTitleFont;
    self.MSTabBar.itemImageRatio         = self.itemImageRatio;
    self.MSTabBar.itemTitleColor         = self.itemTitleColor;
    self.MSTabBar.selectedItemTitleColor = self.selectedItemTitleColor;
    
    self.MSTabBar.tabBarItemCount = viewControllers.count;
    
    [viewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        UIViewController *VC = (UIViewController *)obj;
        
        UIImage *selectedImage = VC.tabBarItem.selectedImage;
        VC.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self addChildViewController:VC];
        
        [self.MSTabBar addTabBarItem:VC.tabBarItem];
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    if(self.selectedIndex != 2)
    {
        _beforeIndex = self.selectedIndex;
    }
    
    [super setSelectedIndex:selectedIndex];
    
    self.MSTabBar.selectedItem.selected = NO;
    self.MSTabBar.selectedItem = self.MSTabBar.tabBarItems[selectedIndex];
    self.MSTabBar.selectedItem.selected = YES;
}

#pragma mark - XXTabBarDelegate Method

- (void)tabBar:(MSTabBar *)tabBarView didSelectedItemFrom:(NSInteger)from to:(NSInteger)to {
    
    self.selectedIndex = to;
}


//支持旋转
-(BOOL)shouldAutorotate{
    UINavigationController *nav = self.childViewControllers[self.selectedIndex];
    return [nav.topViewController shouldAutorotate];
//    return YES;
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    UINavigationController *nav = self.childViewControllers[self.selectedIndex];
    return [nav.topViewController supportedInterfaceOrientations];
//    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
//    UINavigationController *nav = self.childViewControllers[self.selectedIndex];
//    return [nav.topViewController supportedInterfaceOrientations];
    return UIInterfaceOrientationPortrait;
}

@end
