//
//  HomeBannerView.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "HomeBannerView.h"

@interface HomeBannerView () <CWCarouselDatasource, CWCarouselDelegate>

@end

@implementation HomeBannerView

- (void)dealloc
{
    if(self.carousel) {
        [self.carousel releaseTimer];
        [self.carousel removeFromSuperview];
        self.carousel = nil;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_Normal];
    flowLayout.itemWidth = self.width;
    
    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:CGRectZero
                                                    delegate:self
                                                  datasource:self
                                                  flowLayout:flowLayout];
    carousel.translatesAutoresizingMaskIntoConstraints = NO;
    carousel.isAuto = YES;
    carousel.autoTimInterval = 2;
    carousel.endless = YES;
    carousel.backgroundColor = [UIColor whiteColor];
    
    [carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId-CarouselTableViewCell"];
    
    self.carousel = carousel;
    [self addSubview:self.carousel];
    NSDictionary *dic = @{@"view" : carousel};
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:dic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:dic]];
    self.clipsToBounds = YES;

    
    
    
    
//    [self requestNetworkData];
}

- (void)fillData:(id)data
{
    self.dataList = data;
    [self.carousel freshCarousel];
}

#pragma mark - 网络层
- (void)requestNetworkData {
    // 模拟网络请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *arr = [NSMutableArray array];
        NSString *imgName = @"";
        for (int i = 0; i < 5; i++) {
            imgName = [NSString stringWithFormat:@"%02d.jpg", i + 1];
            imgName = @"home_banner";
            [arr addObject:imgName];
        }
        self.dataList = arr;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.carousel freshCarousel];
        });
    });
}

- (NSInteger)numbersForCarousel {
//    return kCount;
    return self.dataList.count;
}

- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    UICollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId-CarouselTableViewCell" forIndexPath:indexPath];

    int kViewTag = 100;
    UIImageView *imgView = [cell.contentView viewWithTag:kViewTag];
    if(!imgView) {
        CGRect frame = cell.contentView.bounds;

        imgView = [[UIImageView alloc] initWithFrame:frame];

        imgView.tag = kViewTag;
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 8;
    }
//    https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwio8MyTp-DdAhWKM94KHUmEDcAQjRx6BAgBEAU&url=http%3A%2F%2F699pic.com%2Ftupian%2Fchuan.html&psig=AOvVaw20gpsPpW4JcNm0mJi9dYrb&ust=1538313533814128
    
//    NSString *name = [NSString stringWithFormat:@"%02ld.jpg", index + 1];
    id data = self.dataList[index];
    NSString *image = data[@"image"];
    
    if ([image hasPrefix:@"http"]) {
        [imgView sd_setImageWithURL:[NSURL URLWithString:image]];
    } else {
        
        static NSMutableDictionary *cacDic = nil;
        if (!cacDic) {
            cacDic = [NSMutableDictionary dictionary];
        }
        
        NSString *name = [NSString stringWithFormat:@"%@@3x", image];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        if (!path) {
            return cell;
        }
        UIImage *img = cacDic[path];
        if (!img) {
            img = [UIImage imageWithContentsOfFile:path];
            cacDic[path] = img;
        }
        
        imgView.image = img;
    }
    
    return cell;
}

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"...%ld...", (long)index);
    id data = [self.dataList objectAtIndex:index];
    !self.selectBlock ?: self.selectBlock(index, data);
}


- (void)CWCarousel:(CWCarousel *)carousel didStartScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
    NSLog(@"开始滑动: %ld", index);
}


- (void)CWCarousel:(CWCarousel *)carousel didEndScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
//    NSLog(@"结束滑动: %ld", index);
}


@end




