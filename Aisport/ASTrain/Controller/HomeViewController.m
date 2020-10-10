//
//  HomeViewController.m
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import "HomeViewController.h"
#import "TRClassDetailViewController.h"
#import "CardStaticView.h"
#import "HomeListViewCell.h"
#import "ASTrainNetwork.h"
#import "HomeVideoViewCell.h"
#import "WholePartVideoView.h"
#import "SelVideoPlayer.h"
#import "VideoPreviewVIew.h"

#import "HomeHeadReusableView.h"
#import <AVFoundation/AVFoundation.h>

#import "VideoDetailWebController.h"
#import "CommonWebController.h"
#import "VideoTrainDataService.h"
#import "VideoTrainData.h"
#import "ActionTrainData.h"
#import "CTPlistSaveManage.h"
#import "LoginNetWork.h"
//#import "RBDMuteSwitch.h"

#import "HomeSearchVController.h"
#import "NewVideoDetailViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIImageView *bannerImageView;
@property (nonatomic, strong) CardStaticView *staticView;
@property (nonatomic, strong) UIImageView *classImageView;

@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) WholePartVideoView *wholeVideoView;

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *recommendSource;
@property (nonatomic, strong) NSMutableArray *bannerDataSource;;

@property (nonatomic, strong) UIView *searchBgView;


@property (nonatomic, strong) VideoPreviewVIew *videoPreviewVIew;
@property (nonatomic, strong) NSMutableDictionary *jiluDic;

@end

@implementation HomeViewController

- (VideoPreviewVIew *)videoPreviewVIew
{
    if (!_videoPreviewVIew) {
        _videoPreviewVIew = [[VideoPreviewVIew alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT)];
        _videoPreviewVIew.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.54];
        WS(weakSelf);
        _videoPreviewVIew.canclePlayVideoBlock = ^{
            [weakSelf removeVideoPreviewVIew];
        };
    }
    return _videoPreviewVIew;
}

- (void)removeVideoPreviewVIew
{
    if (_videoPreviewVIew) {
        for (UIView *view in _videoPreviewVIew.subviews) {
            [view removeFromSuperview];
        }
        [_videoPreviewVIew removeFromSuperview];
        _videoPreviewVIew = nil;
    }
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource;
}

- (NSMutableArray *)bannerDataSource
{
    if (!_bannerDataSource) {
        _bannerDataSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _bannerDataSource;
}

- (NSMutableArray *)recommendSource
{
    if (!_recommendSource) {
        _recommendSource = [NSMutableArray arrayWithCapacity:0];
    }
    return _recommendSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.title = @"首页";
    _currentPage = 0;
    [self createMainView];
    
//    for (NSString *fontStr in [UIFont familyNames]) {
//        NSLog(@"familName = %@",fontStr);
//        for (NSString *sting in [UIFont fontNamesForFamilyName:fontStr]) {
//            NSLog(@"string = %@",sting);
//        }
//    }

    [_mainView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    NSLog(@"access_token------%@",StringForId([GVUserDefaults standardUserDefaults].access_token));
    if ([GVUserDefaults standardUserDefaults].firstEnter == 11) {
        [self getHomeVideoPageWithPage:1 AndRefresh:0];
        [self getHomeRecommenVideoData];
        [self getHomeBanner];
        [self postGetUserInfo];
        [GVUserDefaults standardUserDefaults].firstEnter = 0;
        
    }
    
//    NSMutableDictionary *dict = [self getPlistDictionary:@"trainRecord"];
    NSMutableDictionary *dict = [[CTPlistSaveManage shareManage] getPlistDictionary:@"trainRecord"];
    NSArray *allKeys = dict.allKeys;
    if (allKeys.count > 0) {
        _jiluDic = dict;
    }
    for (NSString *key in allKeys) {
        [VideoTrainDataService setDBName:dict[key][@"videoCode"]];
//        [VideoTrainDataService queryWithVideoCode:dict[key][@"videoCode"]];
        NSArray *arrm = [VideoTrainDataService queryWithVideoCode:dict[key][@"videoCode"]];
        for (VideoTrainData *trainData in arrm) {
//            [self getVideomodelscoreWith:trainData];
            if (trainData.endTime == [key longLongValue]) {
                [self addVideoPlayRecordWithDictonary:dict[key] And:trainData];
            }
        }
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (BOOL)shouldAutorotate
{
    return false;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



-(void)createMainView
{
    UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, (25+33+17.0/2)*2*Screen_Scale-20+StatusHeight)];
    [self.view addSubview:searchBgView];
    searchBgView.backgroundColor = [UIColor colorWithHex:@"#2BD6C5"];;
    _searchBgView = searchBgView;
    
    CGFloat searchWidth = SCR_WIDTH-15*2*2*Screen_Scale;
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(15*2*Screen_Scale, 25*2*Screen_Scale-20+StatusHeight, searchWidth, 33*Screen_Scale*2)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.cornerRadius = 33.0*Screen_Scale;
    searchView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.11].CGColor;
    searchView.layer.shadowOffset = CGSizeMake(0,0);
    searchView.layer.shadowRadius = 2;
    searchView.layer.shadowOpacity = 1;
    [self.view addSubview:searchView];
    
    UIImageView* searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 33.0*Screen_Scale-15.0*Screen_Scale, 15*2*Screen_Scale, 15*2*Screen_Scale)];
    searchImg.image = [UIImage imageNamed:@"home_search"];
    [searchView addSubview:searchImg];
    
    UITextField *searchTf = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, searchWidth - 25, 33*2*Screen_Scale)];
    searchTf.font = fontApp(12);
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索视频、作者..." attributes:
                                      @{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#999999"],
                                        NSFontAttributeName:searchTf.font
                                        }];
    searchTf.attributedPlaceholder = attrString;
//    searchTf.delegate = self;
    searchTf.userInteractionEnabled = NO;
    
    [searchView addSubview:searchTf];
    
    UITapGestureRecognizer *tapSearchGester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSearchVc)];
    [searchView addGestureRecognizer:tapSearchGester];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCR_WIDTH - 37*2*Screen_Scale)/2, (113)*2*Screen_Scale+70);
    layout.minimumInteritemSpacing = 7 ;
    layout.minimumLineSpacing = 8 ;
    layout.sectionInset = UIEdgeInsetsMake(0*2*Screen_Scale, 15*2*Screen_Scale, 15*2*Screen_Scale, 15*2*Screen_Scale);
//    layout.headerReferenceSize = CGSizeMake(SCR_WIDTH, 220*2*Screen_Scale+44*2*Screen_Scale_height+141*2*Screen_Scale);
    
    _mainView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, searchView.bottom+17*2*Screen_Scale/2, SCR_WIDTH, SCR_HIGHT - SafeAreaBottomHeight-((25+33+17.0/2)*2*Screen_Scale-20+StatusHeight)) collectionViewLayout:layout];
    
    [_mainView registerClass:[HomeVideoViewCell class] forCellWithReuseIdentifier:@"HomeVideoViewCell"];
    [_mainView registerClass:[HomeHeadReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
    
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.dataSource = self ;
    _mainView.delegate = self ;
    _mainView.bounces = YES ;
    _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:_mainView];
    WS(weakSelf);
    _mainView.mj_header = [JXRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf getHomeVideoPageWithPage:1 AndRefresh:0];
        [weakSelf getHomeRecommenVideoData];
        [weakSelf getHomeBanner];
    }];
    _mainView.mj_footer = [JXRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf getHomeVideoPageWithPage:weakSelf.currentPage+1 AndRefresh:1];
    }];
    
//    _emptyView = [[EmptyListView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 200) and:3];
//    [_mainView addSubview:_emptyView];
//    _emptyView.center = _mainView.center;
//    _emptyView.hidden = YES;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectOffset(_mainView.bounds, 0, -_mainView.bounds.size.height)];
    bgView.backgroundColor = [UIColor colorWithHex:@"#2BD6C5"];
    [_mainView insertSubview:bgView atIndex:0];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count>0?_dataSource.count:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListModel * model = self.dataSource[indexPath.item];
    HomeVideoViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeVideoViewCell" forIndexPath:indexPath];
    cell.model = model;
    WS(weakSelf);
    cell.playVideoBlcok = ^(NSString * _Nonnull urlStr) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:weakSelf.videoPreviewVIew];
        weakSelf.videoPreviewVIew.videoUrl = urlStr;
    };
    

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isKindOfClass:[UICollectionElementKindSectionHeader class]]) {
        HomeHeadReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];;
        headView.backgroundColor = [UIColor whiteColor];
        headView.videoList = self.recommendSource;
        [headView setBanners:self.bannerDataSource];
        WS(weakSelf);
        headView.homeBannerClickBlcok = ^(NSInteger index) {
//            BannerModel *model = weakSelf.bannerDataSource[index];
//            if ([StringForId(model.id) isEqual:@""]) {
//                return;
//            }
//            CommonWebController *web = [[CommonWebController alloc] init];
//            web.url = [NSString stringWithFormat:@"%@%@?id=%@",Host_Url_Web,@"activeBanner",StringForId(model.id)];
//            [weakSelf.navigationController pushViewController:web animated:YES];
        
        };
        headView.homeHeadCellClickBlcok = ^(HomeListModel * _Nonnull model) {
            if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]) {
                appDelegate.loginNav.modalPresentationStyle = 0;
                [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:nil];
                return;
            }
            
            
            VideoDetailWebController *web = [[VideoDetailWebController alloc] init];
            web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
            if ([[NSUserDefaults standardUserDefaults] boolForKey:StringForId(model.code)]) {
                web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=1",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
            }
            web.codeId = StringForId(model.code);
            web.fromType = 1;
            web.modelMd5 = StringForId(model.modelMd5);
            [weakSelf.navigationController pushViewController:web animated:YES];
        };
        

        
        return headView;
        
    }
    
    return nil;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCR_WIDTH, (141+17.0/2+47*2)*2*Screen_Scale+(100*2*Screen_Scale+10*2*Screen_Scale)*self.recommendSource.count-10*2*Screen_Scale);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]) {
        appDelegate.loginNav.modalPresentationStyle = 0;
        [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:nil];
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        appDelegate.baseTabbar.selectedIndex = 0;
        return;
    }
    
    HomeListModel *model = self.dataSource[indexPath.row];
    VideoDetailWebController *web = [[VideoDetailWebController alloc] init];
//    web.title = _titles[indexPath.row];
    web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:StringForId(model.code)]) {
        web.url = [NSString stringWithFormat:@"%@%@?token=%@&code=%@&enterDetailCount=%lld&isDownloaded=1",Host_Url_Web,@"trainingDetail",[GVUserDefaults standardUserDefaults].access_token,StringForId(model.code),[GVUserDefaults standardUserDefaults].enterDetailCount];
    }
    web.codeId = StringForId(model.code);
    web.fromType = 1;
    web.modelMd5 = StringForId(model.modelMd5);
    [self.navigationController pushViewController:web animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = MIN(1, (offsetY) / (25+33+17.0/2)*2*Screen_Scale);
    _searchBgView.backgroundColor = [UIColor colorWithHex:@"#2BD6C5" alpha:1.0-alpha];
    if (alpha >= 1) {
        _searchBgView.backgroundColor = [UIColor whiteColor];
    }
    NSLog(@"----%f",alpha);
}

//搜索
- (void)goSearchVc
{
    HomeSearchVController *vc = [[HomeSearchVController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    return;
    
    VideoDetailWebController *web = [[VideoDetailWebController alloc] init];
    web.url = [NSString stringWithFormat:@"%@%@?token=%@",Host_Url_Web,@"search",[GVUserDefaults standardUserDefaults].access_token];
    web.fromType = 2;
    [self.navigationController pushViewController:web animated:YES];
}

#pragma mark - Network
- (void)getHomeBanner
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:@"1" forKey:@"current"];
    WS(weakSelf);
    [ASTrainNetwork getHomeBannerWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            [weakSelf.bannerDataSource removeAllObjects];
            NSArray* temp = responseAfter;
            for (NSDictionary *dict in temp) {
                BannerModel *model= [[BannerModel alloc] initWithDictionary:dict error:nil];
                [weakSelf.bannerDataSource addObject:model];
            }
            [weakSelf.mainView reloadData];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getHomeRecommenVideoData
{
//    [SVProgressHUD show];
//    [SVProgressHUD dismiss];
    WS(weakSelf);
    [ASTrainNetwork getRecommendWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            [weakSelf.recommendSource removeAllObjects];
            for (NSDictionary *dict in responseAfter) {
                HomeListModel *model = [[HomeListModel alloc] initWithDictionary:dict error:nil];
                [weakSelf.recommendSource addObject:model];
            }
            [weakSelf.mainView reloadData];
        }
    } andFailerFn:^(NSError * _Nonnull error) {

    }];
}

- (void)getHomeVideoPageWithPage:(NSInteger)page AndRefresh:(int)refresh
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"current"];

    WS(weakSelf);
    [ASTrainNetwork getHomeWatchingVideoPageWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if(ResponseSuccess){
            NSArray* temp = responseAfter[@"records"];
            weakSelf.currentPage = [NSString stringForId:responseAfter[@"current"]].integerValue;

            if (refresh == 0) {
                [weakSelf.dataSource removeAllObjects];
                [weakSelf.mainView.mj_header endRefreshing];
                [weakSelf.mainView.mj_footer resetNoMoreData];
            }else {
                if(temp.count != 0)
                {
                    [weakSelf.mainView.mj_footer endRefreshing];
                }else{
                    [weakSelf.mainView.mj_footer endRefreshingWithNoMoreData];
                }
            }

            for (NSDictionary * dict in temp) {
                HomeListModel * model = [[HomeListModel alloc] initWithDictionary:dict error:nil];
                [weakSelf.dataSource addObject:model];
            }

        }else{
            if ([StringForId(responseAfter) isEqualToString:@""]) {
                [SVProgressHUD showInfoWithStatus:@"发生未知错误"];
            }else{
                [SVProgressHUD showInfoWithStatus:StringForId(responseAfter)];
            }
            [weakSelf.mainView.mj_header endRefreshing];
            [weakSelf.mainView.mj_footer endRefreshing];
        }
//        [_emptyView showEmptyViewWithData:_dataSource];
        [weakSelf.mainView reloadData];
    } andFailerFn:^(NSError * _Nonnull error) {
        [weakSelf.mainView.mj_header endRefreshing];
        [weakSelf.mainView.mj_footer endRefreshing];

    }];
}


- (void)addVideoPlayRecordWithDictonary:(NSDictionary *)dict And:(VideoTrainData *)trainData
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setDictionary:dict];
    [SVProgressHUD show];
//    [SVProgressHUD dismiss];
    WS(weakSelf);
    [ASTrainNetwork addVideoPlayRecordWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        /*
         {
             code = 0;
             data =     {
                 medal =         {
                     courseName = "\U5e15\U6885\U62c9";
                     createTime = "2020-10-26 10:48:32";
                     id = 1;
                     image = "https://i.loli.net/2020/10/26/ReUsbvTZokaOA9W.jpg";
                     level = 1;
                     name = "\U521d\U7ea7\U6311\U6218\U8005";
                     updateTime = "2020-10-29 14:03:54";
                 };
                 rid = 23;
             };
             msg = "<null>";
         }
         */
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if (trainData.isUpload != 1) {
                [self getVideomodelscoreWith:trainData Rid:StringForId(responseAfter[@"rid"])];
            }else{
                [weakSelf.jiluDic removeObjectForKey:[NSString stringWithFormat:@"%lld",trainData.endTime]];
                [[CTPlistSaveManage shareManage] replacePlist:weakSelf.jiluDic NickName:@"trainRecord"];
            }

//            [weakSelf.jiluDic removeObjectForKey:body[@"endTime"]];
//            [[CTPlistSaveManage shareManage] replacePlist:weakSelf.jiluDic NickName:@"trainRecord"];
//            [self insertToPlist:weakSelf.jiluDic];
//            [self checkVideoPlayRecordWithId:StringForId(responseAfter[@"rid"])];
            
        }else{
            [SVProgressHUD dismiss];
        }
        
            
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)getVideomodelscoreWith:(VideoTrainData *)trainData Rid:(NSString *)rid
{
    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];

    NSArray *acions = trainData.actionScoreLogs;
    if (acions <= 0) {
        [VideoTrainDataService deleteWithVideoCode:trainData.videoCode];
        return;
    }
    NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:0];
    for (ActionTrainData *dat in acions) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setObject:[NSString stringWithFormat:@"%ld",dat.uid] forKey:@"uid"];
        [dict setObject:[NSString stringWithFormat:@"%ld",(long)(dat.time*1000)] forKey:@"time"];
        [dict setObject:[NSString stringWithFormat:@"%@",dat.createTime] forKey:@"createTime"];
        [dict setObject:[NSString stringWithFormat:@"%ld",dat.modelScore] forKey:@"modelScore"];
        [dict setObject:dat.keyFrameId forKey:@"keyFrameId"];
        [dict setObject:dat.videoCode forKey:@"videoCode"];
        [dict setObject:dat.json forKey:@"json"];
        [dict setObject:rid forKey:@"rid"];
        [arrM addObject:dict];
    }
    
    
//    NSError *error = nil;
//    NSData *courseJsonData = [NSJSONSerialization dataWithJSONObject:arrM options:kNilOptions error:&error];
//    NSString *dotJsonString = [[NSString alloc] initWithData:courseJsonData encoding:NSUTF8StringEncoding];
    
    [body setObject:arrM forKey:@"list"];
//    [body setObject:rid forKey:@"rid"];
    WS(weakSelf);
    [ASTrainNetwork getVideomodelscoreWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if (ResponseSuccess) {
            [weakSelf.jiluDic removeObjectForKey:[NSString stringWithFormat:@"%lld",trainData.endTime]];
            [[CTPlistSaveManage shareManage] replacePlist:weakSelf.jiluDic NickName:@"trainRecord"];
            [VideoTrainDataService updateUploadStateWithVideoCode:trainData.videoCode];
//            [VideoTrainDataService deleteWithVideoCode:trainData.videoCode];
        }
    } andFailerFn:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];

}

- (void)postGetUserInfo
{
//    NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
    
    WS(weakSelf);
    [SVProgressHUD setBorderWidth:0];
    [SVProgressHUD show];
    [LoginNetWork getUserInfoWith:nil AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        [SVProgressHUD dismiss];
        if (ResponseSuccess) {
            if (![StringForId(responseAfter) isEqual:@""]) {
                [GVUserDefaults standardUserDefaults].cover = StringForId(responseAfter[@"cover"]);
                [GVUserDefaults standardUserDefaults].nickName = StringForId(responseAfter[@"nickName"]);
    //            [GVUserDefaults standardUserDefaults].phone = StringForId(responseAfter[@"phone"]);
                [GVUserDefaults standardUserDefaults].sex = StringForId(responseAfter[@"sex"]);
//                [weakSelf.iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(responseAfter[@"cover"])] placeholderImage:[UIImage imageNamed:@"home_hejipic"]];
//                weakSelf.nickLabel.text = StringForId(responseAfter[@"nickName"]);
            }
            
        }
        [weakSelf.mainView.mj_header endRefreshing];
    } andFailerFn:^(NSError * _Nonnull error) {
        [weakSelf.mainView.mj_header endRefreshing];
    }];
}


//- (BOOL)prefersStatusBarHidden {
//    
//    return YES;
//}


//#pragma mark - plist本地存储资源信息
////重新写入
//- (void)insertToPlist:(NSDictionary *)dictionary {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
////    NSString *extention = @"mp4";
////    NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
//    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@.plist", documentsDirectory, @"trainRecord"];
//    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
////    //下边if判断很重要，不然会写入失败.
////    if (!userDict) {
////        userDict = [[NSMutableDictionary alloc] init];
////    }
//    //设置属性值
//    [userDict setDictionary:dictionary];
//    //写入文件
//    [userDict writeToFile:plistPath atomically:YES];
//}
//
////2.读取plist（代码创建的plist文件）
//- (NSMutableDictionary *)getPlistDictionary:(NSString *)nickName
//{
////    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"chatRoom.plist"];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@.plist", documentsDirectory, @"trainRecord"];
//    NSMutableDictionary *userDict = [[NSMutableDictionary alloc ]initWithContentsOfFile:plistPath];
//    return userDict;
//    //userDict[nickName]就是上边方法存入的字典,取出来就可以进行相应的赋值操作啦
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
