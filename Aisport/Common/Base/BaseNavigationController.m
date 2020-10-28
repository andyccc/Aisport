//
//  BaseNavigationController.m
//  aisport
//
//  Created by Apple on 2020/10/18.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//支持旋转
-(BOOL)shouldAutorotate{
    return [self.topViewController shouldAutorotate];
}

//支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果push的不是根控制器(不是栈底控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        // 左上角的返回
        _leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 50)];
        [_leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:0];
        _leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftBtn.imageView.clipsToBounds = YES;
        _leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
        [_leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)back:(UIButton*)btn
{
    if(btn.tag == 0)
    {
        [self popViewControllerAnimated:YES];
    }
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
