//
//  PlayVideoViewController.m
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import "TRPlayVideoViewController.h"
#import "SelectedModelView.h"
#import "GuideTVView.h"
#import "PlaceMobileView.h"
//#import "CalibrateBodyView.h"
#import "TRAIPlayVideoViewController.h"
#import "BaseNavigationController.h"

@interface TRPlayVideoViewController ()

@property (nonatomic, strong) SelectedModelView *selectedModelView;
@property (nonatomic, strong) GuideTVView *guideTVView;
@property (nonatomic, strong) PlaceMobileView *placeMobileView;


@end

@implementation TRPlayVideoViewController

#pragma mark - 选择模式
- (SelectedModelView *)selectedModelView
{
    if (!_selectedModelView) {
        _selectedModelView = [[SelectedModelView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _selectedModelView.backgroundColor = [UIColor blackColor];
        
        WS(weakSelf);
        _selectedModelView.clickOKModelBlock = ^(BOOL isSelecedTV) {
            [weakSelf removeSelectedModelView];
            
            if (isSelecedTV) {
                [weakSelf.view addSubview:weakSelf.guideTVView];
            }else{
                [weakSelf.view addSubview:weakSelf.placeMobileView];
            }
            
        };
        _selectedModelView.backSelectedBlock = ^{
            [weakSelf removeSelectedModelView];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    
    
    return _selectedModelView;
}

- (void)removeSelectedModelView
{
    for (UIView *view in self.selectedModelView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.selectedModelView removeFromSuperview];
    self.selectedModelView = nil;
}


#pragma mark - 投屏指引
- (GuideTVView *)guideTVView
{
    if (!_guideTVView) {
        _guideTVView = [[GuideTVView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _guideTVView.backgroundColor = [UIColor blackColor];
        
        WS(weakSelf);

        _guideTVView.backGuideTVBlock = ^{
            [weakSelf removeGuideTVView];
            [weakSelf.view addSubview:weakSelf.placeMobileView];
        };
    }
    
    
    return _guideTVView;
}

- (void)removeGuideTVView
{
    for (UIView *view in self.guideTVView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.guideTVView removeFromSuperview];
    self.guideTVView = nil;
}



#pragma mark - 放置手机
- (PlaceMobileView *)placeMobileView
{
    if (!_placeMobileView) {
        _placeMobileView = [[PlaceMobileView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _placeMobileView.backgroundColor = [UIColor blackColor];
        
        WS(weakSelf);
        _placeMobileView.clickPlaceOKlBlock = ^() {
            [weakSelf removePlaceMobileView];
            [weakSelf placeMobileUpdataView];
        };
        _placeMobileView.backPlaceMobileBlock = ^{
            [weakSelf removePlaceMobileView];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    
    
    return _placeMobileView;
}

- (void)removePlaceMobileView
{
    for (UIView *view in self.placeMobileView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.placeMobileView removeFromSuperview];
    self.placeMobileView = nil;
}

//#pragma mark - 校对身体
//- (CalibrateBodyView *)calibrateBodyView
//{
//    if (!_calibrateBodyView) {
//        _calibrateBodyView = [[CalibrateBodyView alloc] initWithFrame:CGRectMake(0, 0, SCR_HIGHT, SCR_WIDTH)];
////        _calibrateBodyView.backgroundColor = [UIColor clearColor];
//        
////        WS(weakSelf);
////        _calibrateBodyView.clickPlaceOKlBlock = ^() {
////            [weakSelf removePlaceMobileView];
//////            [weakSelf.view addSubview:weakSelf.guideTVView];
////        };
////        _calibrateBodyView.backPlaceMobileBlock = ^{
////            [weakSelf removePlaceMobileView];
////            [weakSelf.navigationController popViewControllerAnimated:YES];
////        };
//    }
//    
//    
//    return _calibrateBodyView;
//}
//
//- (void)removeCalibrateBodyView
//{
//    for (UIView *view in self.calibrateBodyView.subviews) {
//        [view removeFromSuperview];
//    }
//    
//    [self.calibrateBodyView removeFromSuperview];
//    self.calibrateBodyView = nil;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.selectedModelView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


//处理界面
- (void)placeMobileUpdataView
{
    
//    [self.view addSubview:self.calibrateBodyView];
    
    [self rotatePlayScreen];
}


//旋转屏幕
- (void)rotatePlayScreen
{
//    //不能直接调用，但是可以间接的去调用，下面的方法就是利用 KVO机制去间接调用，多次验证不会被打回，放心！
//    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
//    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
//
//    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
//    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    

    TRAIPlayVideoViewController *vc = [[TRAIPlayVideoViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];

}

//支持旋转
//-(BOOL)shouldAutorotate{
//    return YES;
//}
////支持的方向 因为界面A我们只需要支持竖屏
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    
//    return UIInterfaceOrientationMaskLandscapeRight;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
