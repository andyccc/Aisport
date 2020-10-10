//
//  ZBCycleScrollView.m
//  ZhuangDianBi
//
//  Created by ZDB on 2017/4/7.
//  Copyright © 2017年 ZDB. All rights reserved.
//

#import "ZBCycleScrollView.h"
#import "ZBCycleScrollViewCell.h"
//#import "UIViewExt.h"
#import "ZBPageControl.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ZBCycleScrollView ()<ZBCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak ,nonatomic) UIImageView *backgroundImageView;
@property (weak ,nonatomic) UICollectionView *collectionView;
@property (weak ,nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (weak ,nonatomic) ZBPageControl *pageControl;


@property (strong ,nonatomic) NSTimer *scrollTimer;
@property (assign ,nonatomic) NSInteger realCount;//多少张图片
@property (assign ,nonatomic) NSInteger totalCount;//记录设置的总数
@property (assign ,nonatomic) NSInteger originIndex;//初始页码
@property (assign ,nonatomic) NSInteger currentIndex;//记录当前页码
@property (assign ,nonatomic) NSInteger willDisplayIndex;//将要展示的index
@property (assign ,nonatomic) NSInteger didDisplayIndex;//正在展示的index
@end
@implementation ZBCycleScrollView
static NSString *CycleCellIdentifier = @"ZBCycle";

- (instancetype)cycleScrollViewWithFrame:(CGRect)frame ScrollDelegate:(id<ZBCycleScrollViewDelegate>)delegate
{
    ZBCycleScrollView *cycleScrollView = [[ZBCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.delegate = delegate;
    return cycleScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMainView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _collectionView.frame = self.bounds;
    _flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    _backgroundImageView.frame = self.bounds;
}

- (void)setMainView
{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    _backgroundImageView = backgroundImageView;
    [self addSubview:backgroundImageView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.f;
    flowLayout.minimumInteritemSpacing = 0.f;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.scrollsToTop = NO;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.pagingEnabled = YES;
    [collectionView registerClass:[ZBCycleScrollViewCell class] forCellWithReuseIdentifier:CycleCellIdentifier];
    [self addSubview:collectionView];
    
    
    _flowLayout = flowLayout;
    _collectionView = collectionView;
    
    
}

#pragma mark - 自动滚动
- (void)setAutomatic:(BOOL)automatic
{
    _automatic = automatic;
    if (automatic) {
        [self invalidateTimer];
        [self setUpTimer];
    }else{
        [self invalidateTimer];
    }
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    _backgroundImageView.image = placeholderImage;
}

- (void)setUpTimer
{
    if (self.totalCount!=0 && self.scrollTimeInterval) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
        _scrollTimer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
}

- (void)invalidateTimer
{
    if (_scrollTimer) {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

- (void)automaticScroll
{
    [self scrollToIndex:self.currentIndex+1];
}

- (void)setUpPageControl
{
    if (!_dotWidth ) return;
    if (!_realCount) {
        if (_pageControl) {
            [_pageControl removeFromSuperview];
            _pageControl = nil;
        }
        return;
    }
    if (_realCount == 1) {
        if (_pageControl) {
            [_pageControl removeFromSuperview];
            _pageControl = nil;
        }
        return;
    }
    
    if (!_pageControl) {
        CGPoint controlCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-_dotWidth-5);
        ZBPageControl *pageControl = [[ZBPageControl alloc] pageControlWithCenter:controlCenter Count:_realCount DotDiameter:_dotWidth];
        pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
        pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
        _pageControl = pageControl;
        [self addSubview:pageControl];
    }else{
        [_pageControl removeFromSuperview];
        _pageControl = nil;
        CGPoint controlCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height-_dotWidth-5);
        ZBPageControl *pageControl = [[ZBPageControl alloc] pageControlWithCenter:controlCenter Count:_realCount DotDiameter:_dotWidth];
        pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
        pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
        _pageControl = pageControl;
        [self addSubview:pageControl];
    }
}

- (void)scrollToIndex:(NSInteger)index
{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

#pragma mark - Setter Getter
- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    if (imagesArray.count == 0) return;
    _realCount = imagesArray.count;
    _totalCount = imagesArray.count * 100;
    _originIndex = _totalCount/2;
    _currentIndex = _originIndex;
    if (_realCount >1 ) {
        _willDisplayIndex = 1;
        _didDisplayIndex = 0;
    }else if (_realCount == 1){
        _willDisplayIndex = 0;
        _didDisplayIndex = 0;
    }
    [self layoutIfNeeded];
    [self setUpPageControl];
    [self invalidateTimer];
    [self setUpTimer];
    [_collectionView reloadData];
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    if (_realCount == 1) {
        self.automatic = NO;
        _collectionView.scrollEnabled = NO;
    }else{
        _collectionView.scrollEnabled = YES;
    }
}

- (void)setDotWidth:(CGFloat)dotWidth
{
    _dotWidth = dotWidth;
    [self setUpPageControl];
}

- (void)setScrollTimeInterval:(NSTimeInterval)scrollTimeInterval
{
    _scrollTimeInterval = scrollTimeInterval;
    if (_automatic) {
        [self invalidateTimer];
        [self setUpTimer];
    }
}


- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    [self setUpPageControl];
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    [self setUpPageControl];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    _willDisplayIndex = indexPath.row%_realCount;
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZBCycleScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CycleCellIdentifier forIndexPath:indexPath];
    cell.placeholder = _placeholderImage;
    cell.imageString = _imagesArray[indexPath.row%_realCount];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(cycleScrollViewDidSelectIndex:)]) {
        [_delegate cycleScrollViewDidSelectIndex:indexPath.row%_realCount];
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.currentIndex = self.collectionView.contentOffset.x/self.flowLayout.itemSize.width;
    _didDisplayIndex = self.currentIndex%_realCount;
    if (self.currentIndex == _totalCount-1) {
        self.currentIndex = self.currentIndex - _originIndex;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else if (self.currentIndex == 0){
        self.currentIndex = self.currentIndex + _originIndex;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    if (_pageControl) {
        [_pageControl pageControlDidSelectDot:_didDisplayIndex];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"will - %ld / did - %ld",(long)_willDisplayIndex,(long)_didDisplayIndex);
//    
//    CGFloat percent = (scrollView.contentOffset.x - self.currentIndex*_flowLayout.itemSize.width)/_flowLayout.itemSize.width;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_automatic) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_automatic) {
        [self invalidateTimer];
        [self setUpTimer];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - ZBCycleScrollViewDelegate
- (void)cycleScrollViewDidSelectIndex:(NSInteger)index
{
    [_delegate cycleScrollViewDidSelectIndex:index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
