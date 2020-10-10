//
//  CarouselTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "CarouselTableViewCell.h"
#import "VideoCoverView2.h"
#import "CWCarousel.h"
#import "CWPageControl.h"


@interface CarouselTableViewCell () <CWCarouselDatasource, CWCarouselDelegate>
@property (nonatomic, strong) CWCarousel *carousel;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) UIView *animationView;

@end

@implementation CarouselTableViewCell

+ (CGFloat)cellHeight
{
    return UIValue(143 + 20 + 10);
}

- (void)dealloc
{
    if(self.carousel) {
        [self.carousel releaseTimer];
        [self.carousel removeFromSuperview];
        self.carousel = nil;
    }
}

- (void)initSelf
{
    CGFloat width = SCR_WIDTH - UIValue(32);

    self.animationView = [[UIView alloc] init];
    self.animationView.width = width;
    self.animationView.left = UIValue(16);
    self.animationView.height = UIValue(143 + 20);
    
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_H_3];
    flowLayout.itemWidth = UIValue(143)/1.3;
    flowLayout.maxScale = 1.2;
    flowLayout.minScale = 0.7;
    
    CWCarousel *carousel = [[CWCarousel alloc] initWithFrame:CGRectZero
                                                    delegate:self
                                                  datasource:self
                                                  flowLayout:flowLayout];
    carousel.translatesAutoresizingMaskIntoConstraints = NO;
    carousel.isAuto = NO;
    carousel.autoTimInterval = 2;
    carousel.endless = YES;
    carousel.backgroundColor = [UIColor whiteColor];
    carousel.pageControl.hidden = YES;
    
    [carousel registerViewClass:[UICollectionViewCell class] identifier:@"cellId-CarouselTableViewCell"];
    
    self.carousel = carousel;
    [self.animationView addSubview:self.carousel];
    NSDictionary *dic = @{@"view" : carousel};
    [self.animationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:dic]];
    [self.animationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:dic]];
    self.animationView.clipsToBounds = YES;

    
    
    [self.contentView addSubview:self.animationView];
    
    
//    [self requestNetworkData];
}

- (void)fillData:(id)data
{
    self.dataList = data[@"data"];
    self.tapBlock = data[@"block"];
}

- (void)tapAction:(UIButton *)btn
{
    !self.tapBlock ?: self.tapBlock(btn.tag);
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
    VideoCoverView2 *imgView = [cell.contentView viewWithTag:kViewTag];
    if(!imgView) {
        CGRect frame = cell.contentView.bounds;
        frame = CGRectMake(0, 0,  UIValue(143 )/1.2,  UIValue(143 + 20) /1.2);

        imgView = [[VideoCoverView2 alloc] initWithFrame:frame];
        imgView.frame = cell.contentView.bounds;
        [imgView layout];
        
        imgView.tag = kViewTag;
        [cell.contentView addSubview:imgView];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 8;
        [imgView.tapBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    imgView.tapBtn.tag = index;
    
//    https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwio8MyTp-DdAhWKM94KHUmEDcAQjRx6BAgBEAU&url=http%3A%2F%2F699pic.com%2Ftupian%2Fchuan.html&psig=AOvVaw20gpsPpW4JcNm0mJi9dYrb&ust=1538313533814128
    
    id data = self.dataList[index];
    NSString *image = data[@"cover"];
    
    [imgView.coverView sd_setImageWithURL:[NSURL URLWithString:image]];
    imgView.titleLabel.text = data[@"name"];
    [imgView setLev:[data[@"lever"] intValue]];
    return cell;
}

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    NSLog(@"...%ld...", (long)index);
//    !self.tapBlock ?: self.tapBlock(index);
}


- (void)CWCarousel:(CWCarousel *)carousel didStartScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
    NSLog(@"开始滑动: %ld", index);
}


- (void)CWCarousel:(CWCarousel *)carousel didEndScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
//    NSLog(@"结束滑动: %ld", index);
}




@end
