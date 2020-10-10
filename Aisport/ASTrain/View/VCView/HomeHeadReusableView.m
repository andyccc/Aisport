//
//  HomeHeadReusableView.m
//  Aisport
//
//  Created by Apple on 2020/11/16.
//

#import "HomeHeadReusableView.h"
#import "HomeWholeViewCell.h"
#import "CTCardViewLayout.h"

#import "MyVideoListViewCell.h"
#import "MyTrainVideoViewCell.h"
#import "ZBCycleScrollView.h"

@interface HomeHeadReusableView ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,ZBCycleScrollViewDelegate>
{
    ZBCycleScrollView *_cycleScrollView;//轮播图
}

@property (weak ,nonatomic) UICollectionView *collectionView;
@property (weak ,nonatomic) UITableView *tableView;

@property (nonatomic, strong) UILabel *vedioTitleLabel;

@end

@implementation HomeHeadReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        CGFloat searchWidth = SCR_WIDTH-15*2*2*Screen_Scale;
//        UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(15*2*Screen_Scale, 44*2*Screen_Scale, searchWidth, 33*Screen_Scale*2)];
//        searchView.backgroundColor = [UIColor whiteColor];
//        searchView.layer.cornerRadius = 33.0*Screen_Scale;
//        searchView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.11].CGColor;
//        searchView.layer.shadowOffset = CGSizeMake(0,0);
//        searchView.layer.shadowRadius = 2;
//        searchView.layer.shadowOpacity = 1;
//        [self addSubview:searchView];
//        
//        UIImageView* searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 33.0*Screen_Scale-15.0*Screen_Scale, 15*2*Screen_Scale, 15*2*Screen_Scale)];
//        searchImg.image = [UIImage imageNamed:@"home_search"];
//        [searchView addSubview:searchImg];
//        
//        UITextField *searchTf = [[UITextField alloc]initWithFrame:CGRectMake(30, 0, searchWidth - 25, 33*2*Screen_Scale)];
//        searchTf.font = fontApp(12);
//        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索视频" attributes:
//                                          @{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#999999"],
//                                            NSFontAttributeName:searchTf.font
//                                            }];
//        searchTf.attributedPlaceholder = attrString;
//    //    searchTf.delegate = self;
//        searchTf.userInteractionEnabled = NO;
//        
//        [searchView addSubview:searchTf];
//        
//        UITapGestureRecognizer *tapSearchGester = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSearchVc)];
//        [searchView addGestureRecognizer:tapSearchGester];
        
        
        UIView *bgBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, (72-17.0/2)*2*Screen_Scale)];
        [self addSubview:bgBgView];
        bgBgView.backgroundColor = [UIColor colorWithHex:@"#2BD6C5"];;
        
        UIImageView *bannerBgCImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, bgBgView.bottom, SCR_WIDTH, 31*2*Screen_Scale)];
        [self addSubview:bannerBgCImageView];
        bannerBgCImageView.image = [UIImage imageNamed:@"home_bannerBgC"];
        bannerBgCImageView.contentMode = UIViewContentModeScaleAspectFill;
        bannerBgCImageView.clipsToBounds = YES;
        
//        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, 17*2*Screen_Scale/2, SCR_WIDTH-15*2*2*Screen_Scale, 141*2*Screen_Scale)];
//        [self addSubview:picImageView];
//        picImageView.image = [UIImage imageNamed:@"home_banner"];
//        picImageView.contentMode = UIViewContentModeScaleAspectFill;
//        picImageView.clipsToBounds = YES;
//        picImageView.userInteractionEnabled = YES;
        
        _cycleScrollView = [[ZBCycleScrollView alloc] cycleScrollViewWithFrame:CGRectMake(15*2*Screen_Scale, 17*2*Screen_Scale/2, SCR_WIDTH-15*2*2*Screen_Scale, 141*2*Screen_Scale) ScrollDelegate:self];
        _cycleScrollView.pageIndicatorTintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        _cycleScrollView.currentPageIndicatorTintColor = [UIColor whiteColor];
        _cycleScrollView.automatic = YES;
        _cycleScrollView.dotWidth = 5;
        _cycleScrollView.scrollTimeInterval = 5;
        _cycleScrollView.placeholderImage = [UIImage imageNamed:@"placeHolder_Long"];
        [self addSubview:_cycleScrollView];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHomeBannerPic:)];
//        [picImageView addGestureRecognizer:tap];
        
        
//        NSArray *iconImages = @[@"",@""];
//        NSArray *iconTitles = @[@"#分类",@"#排行榜"];
//        CGFloat imageW = (SCR_WIDTH-16*2*Screen_Scale*2-9*2*Screen_Scale)/2;
//        for (int i = 0; i < iconImages.count; i++) {
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*2*Screen_Scale+(imageW+9*2*Screen_Scale)*i, picImageView.bottom+10, imageW, 76*2*Screen_Scale)];
//            [self addSubview:imageView];
//            imageView.image = [UIImage imageNamed:@"train_rank"];
//            imageView.contentMode = UIViewContentModeScaleAspectFill;
//            imageView.layer.cornerRadius = 5;
//            imageView.clipsToBounds = YES;
//            imageView.userInteractionEnabled = YES;
//            imageView.tag = i;
//
//            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, imageView.width, imageView.height)];
//            [imageView addSubview:titleLabel];
//            titleLabel.textColor = [UIColor colorWithHex:@"#FFFFFF"];
//            titleLabel.font = fontApp(13);
//            titleLabel.textAlignment = NSTextAlignmentCenter;
////            titleLabel.layer.cornerRadius = 5;
////            titleLabel.clipsToBounds = YES;
//            titleLabel.text = iconTitles[i];
//
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topViewClick:)];
//            [imageView addGestureRecognizer:tap];
//
//        }
//
//        UILabel *hejiTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, picImageView.bottom+10+76*2*Screen_Scale, SCR_WIDTH-30*2*Screen_Scale, 53*2*Screen_Scale_height)];
//        [self addSubview:hejiTitleLabel];
//        hejiTitleLabel.font = fontBold(17);
//        hejiTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
//        hejiTitleLabel.text = @"发现精彩合集";
//
//        UIButton *moreButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH-15*2*Screen_Scale-65, picImageView.bottom+10+76*2*Screen_Scale, 65, 53*2*Screen_Scale)];
//        [self addSubview:moreButton];
//        [moreButton setTitle:@"查看全部" forState:UIControlStateNormal];
//        [moreButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
//        moreButton.titleLabel.font = fontApp(11);
//        [moreButton setImage:[UIImage imageNamed:@"arror_right"] forState:UIControlStateNormal];
//        [moreButton layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleRight imageTitleSpace:4];
//        moreButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        moreButton.hidden = YES;
////        [moreButton addTarget:self action:@selector(clickPlaceOKButton:) forControlEvents:UIControlEventTouchUpInside];
//
//
//        UIView *collectionViewBackView = [[UIView alloc] initWithFrame:CGRectMake(0, picImageView.bottom+139, SCR_WIDTH, (153)*2*Screen_Scale)];
//        collectionViewBackView.backgroundColor = [UIColor whiteColor];
//        collectionViewBackView.alpha = 0.2;
//        [self addSubview:collectionViewBackView];
//
//        CTCardViewLayout *flowLayout = [[CTCardViewLayout alloc] init];
//        flowLayout.itemSize = CGSizeMake(138*2*Screen_Scale, (138+43)*2*Screen_Scale);
////            flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
////            flowLayout.minimumLineSpacing = 0.f;
//
//        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, picImageView.bottom+139, SCR_WIDTH, (138+43)*2*Screen_Scale) collectionViewLayout:flowLayout];
//        collectionView.delegate = self;
//        collectionView.dataSource = self;
//        collectionView.showsVerticalScrollIndicator = NO;
//        collectionView.showsHorizontalScrollIndicator = NO;
//        collectionView.backgroundColor = [UIColor clearColor];
//        [collectionView registerClass:[HomeWholeViewCell class] forCellWithReuseIdentifier:@"HomeWholeViewCell"];
////            [collectionView registerClass:[ZBSpaceHeaderViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:resueFooter];
//        //此处给其增加长按手势，用此手势触发cell移动效果
////            UILongPressGestureRecognizer *longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
////            [collectionView addGestureRecognizer:longGesture];
//        [self addSubview:collectionView];
//        _collectionView = collectionView;
//
//
        UILabel *renqiLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, _cycleScrollView.bottom, SCR_WIDTH-30*2*Screen_Scale, 47*2*Screen_Scale)];
        [self addSubview:renqiLabel];
        renqiLabel.font = fontBold(17);
        renqiLabel.textColor = [UIColor colorWithHex:@"#333333"];
        renqiLabel.text = @"嗨动精选";
//
//        UIButton *changeButton = [[UIButton alloc] initWithFrame:CGRectMake(SCR_WIDTH-15*2*Screen_Scale-65, collectionView.bottom, 65, 50*2*Screen_Scale)];
//        [self addSubview:changeButton];
//        [changeButton setTitle:@"换一批" forState:UIControlStateNormal];
//        [changeButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
//        changeButton.titleLabel.font = fontApp(11);
//        [changeButton setImage:[UIImage imageNamed:@"arror_right"] forState:UIControlStateNormal];
//        [changeButton layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleRight imageTitleSpace:4];
//        changeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        changeButton.hidden = YES;
////        [changeButton addTarget:self action:@selector(clickPlaceOKButton:) forControlEvents:UIControlEventTouchUpInside];
//
//
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _cycleScrollView.bottom+47*2*Screen_Scale+20*2*Screen_Scale, SCR_WIDTH, (100*2*Screen_Scale+10*2*Screen_Scale)*3-10*2*Screen_Scale) style:UITableViewStylePlain];
        [self addSubview:tableView];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        _tableView = tableView;



        UILabel *vedioTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, tableView.bottom, SCR_WIDTH-30*2*Screen_Scale, 47*2*Screen_Scale)];
        [self addSubview:vedioTitleLabel];
        vedioTitleLabel.font = fontBold(17);
        vedioTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        vedioTitleLabel.text = @"大家在练";
        _vedioTitleLabel = vedioTitleLabel;
    }
    return self;
}


#pragma mark - UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    if (_personMe) {
//        return [userInfoManager shareUserManager].photos.count;
//    }else{
//
//        return _userinformation.photos.count;
//    }
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeWholeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeWholeViewCell" forIndexPath:indexPath];
//    if (_personMe) {
//        NSString *imageUrl = [userInfoManager shareUserManager].photos[indexPath.row];
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
//    }else{
//        NSString *imageUrl = _userinformation.photos[indexPath.row];
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
//    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videoList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTrainVideoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTrainVideoViewCell"];
    if (cell == nil) {
        cell = [[MyTrainVideoViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyTrainVideoViewCell"];
    }
    cell.isHome = YES;
    cell.homeModel = self.videoList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.videoList.count != 0 && indexPath.row == self.videoList.count-1) {
        return 100*2*Screen_Scale;
    }
    return 100*2*Screen_Scale+10*2*Screen_Scale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.selected = NO;
    
    if (self.homeHeadCellClickBlcok) {
        HomeListModel *model = self.videoList[indexPath.row];
        self.homeHeadCellClickBlcok(model);
    }
}

- (void)topViewClick:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 0) {
        //分类
    }else if (tap.view.tag == 1){
        //排行榜
    }
    else{
        
    }
}

- (void)clickHomeBannerPic:(UITapGestureRecognizer *)tap
{
//    if (self.homeBannerClickBlcok) {
//        self.homeBannerClickBlcok();
//    }
}


//搜索
- (void)goSearchVc
{
    if (self.homeSearchBlcok) {
        self.homeSearchBlcok();
    }
}

- (void)setVideoList:(NSMutableArray *)videoList
{
    _videoList = videoList;
    _tableView.height = (100*2*Screen_Scale+10*2*Screen_Scale)*self.videoList.count-10*2*Screen_Scale;
    _vedioTitleLabel.top =_tableView.bottom;
    [_tableView reloadData];
}

- (void)setBanners:(NSArray *)banner
{
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
    for (BannerModel *model in banner) {
        [images addObject:model.image];
    }
    _cycleScrollView.imagesArray = images;
}


#pragma mark - ZBCycleScrollViewDelegate
- (void)cycleScrollViewDidSelectIndex:(NSInteger)index
{
//    if (_delegate && [_delegate respondsToSelector:@selector(gameBannerClick:)]) {
//        [_delegate gameBannerClick:index];
//    }
    if (self.homeBannerClickBlcok) {
        self.homeBannerClickBlcok(index);
    }
}

@end
