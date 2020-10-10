//
//  AppBootVC.m
//  Aisport
//
//  Created by Apple on 2020/11/16.
//

#import "AppBootVC.h"
#import "AppDelegate.h"

@interface AppBootVC ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView* mainView;
@property (nonatomic,strong)UIPageControl* pageControl;

@end

@implementation AppBootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray* bootImgs = @[@"yindaoye_1",@"yindaoye_2",@"yindaoye_3"];
    _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.contentSize = CGSizeMake(SCR_WIDTH*bootImgs.count, SCR_HIGHT);
    _mainView.showsHorizontalScrollIndicator = NO;
    
    for(int i=0;i<bootImgs.count;i++)
    {
        UIImageView* img = [[UIImageView alloc]initWithFrame:CGRectMake(SCR_WIDTH*i, 0, SCR_WIDTH, SCR_HIGHT)];
        img.image = [UIImage imageNamed:bootImgs[i]];
        img.contentMode = UIViewContentModeScaleAspectFill;
        [_mainView addSubview:img];
        img.userInteractionEnabled = YES;
        
        UIButton *tiaoguoButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH-29*2*Screen_Scale-52*2*Screen_Scale, 41*2*Screen_Scale, 52*2*Screen_Scale, 24*2*Screen_Scale)];
        [img addSubview:tiaoguoButton];
        [tiaoguoButton setTitle:@"跳过" forState:UIControlStateNormal];
        [tiaoguoButton setTitleColor:[UIColor colorWithHex:@"#333333"] forState:UIControlStateNormal];
        [tiaoguoButton setBackgroundColor:[UIColor colorWithHex:@"#333333" alpha:0.08]];
        tiaoguoButton.titleLabel.font = fontApp(13);
        tiaoguoButton.layer.cornerRadius = 24*Screen_Scale;
        tiaoguoButton.clipsToBounds = YES;
        [tiaoguoButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
        tiaoguoButton.hidden = NO;
        
        if(i==bootImgs.count - 1)
        {
            tiaoguoButton.hidden = YES;
//            img.userInteractionEnabled = YES;
            
            UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(78*2*Screen_Scale, SCR_HIGHT - 41*2*Screen_Scale-46, SCR_WIDTH - 78*2*Screen_Scale*2, 46)];
            btn.layer.cornerRadius = 46/2;
//            btn.layer.borderColor = WHITE_Color.CGColor;
//            btn.layer.borderWidth = 1;
            btn.clipsToBounds = YES;
            [btn setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"] forState:UIControlStateNormal];
            [btn setTitle:@"开始体验" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
            [img addSubview:btn];
            
//            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
//            img.userInteractionEnabled = YES;
//            [img addGestureRecognizer:tap];
        }
    }
        
    [self.view addSubview:_mainView];
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(SCR_WIDTH/2 - 100, SCR_HIGHT - 86*2*Screen_Scale, 200, 20)];
    self.pageControl.numberOfPages = bootImgs.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithHex:@"#1BC2B1"];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithHex:@"#CDCDCD"];
    [self.view addSubview:self.pageControl];
    self.pageControl.currentPage = 0;
    // Do any additional setup after loading the view.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageControl.currentPage = scrollView.contentOffset.x/SCR_WIDTH;
    NSLog(@"%f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x >= 1*SCR_WIDTH+SCR_WIDTH/2) {
        _pageControl.hidden = YES;
    }else{
        _pageControl.hidden = NO;
    }
    
}


-(void)tapClick
{
//    if(![GVUserDefaults standardUserDefaults].access_token)
//    {
//        appDelegate.window.rootViewController = appDelegate.baseTabbar;
//        [appDelegate.window makeKeyAndVisible];
//        appDelegate.loginNav.modalPresentationStyle = 0;
//        [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:YES completion:nil];
//
//    }else
//    {
//        appDelegate.window.rootViewController = appDelegate.baseTabbar;
//        [appDelegate.window makeKeyAndVisible];
//
//    }
    appDelegate.window.rootViewController = appDelegate.baseTabbar;
    [appDelegate.window makeKeyAndVisible];
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
