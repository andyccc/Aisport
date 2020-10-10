//
//  HomeBannerView.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import <UIKit/UIKit.h>
#import "CWCarousel.h"
#import "CWPageControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeBannerView : UIView

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) CWCarousel *carousel;

@property (nonatomic, copy) void (^selectBlock) (NSInteger index, id data);
- (void)fillData:(id)data;

@end

NS_ASSUME_NONNULL_END
