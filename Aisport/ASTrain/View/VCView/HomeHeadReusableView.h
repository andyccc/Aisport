//
//  HomeHeadReusableView.h
//  Aisport
//
//  Created by Apple on 2020/11/16.
//

#import <UIKit/UIKit.h>
#import "BannerModel.h"

@class HomeListModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^CT_HomeSearchBlcok)(void);
typedef void(^CT_HomeBannerClickBlcok)(NSInteger index);
typedef void(^CT_HomeHeadCellClickBlcok)(HomeListModel *model);
@interface HomeHeadReusableView : UICollectionReusableView

@property (nonatomic, copy) CT_HomeSearchBlcok homeSearchBlcok;
@property (nonatomic, copy) CT_HomeBannerClickBlcok homeBannerClickBlcok;
@property (nonatomic, copy) CT_HomeHeadCellClickBlcok homeHeadCellClickBlcok;

@property (nonatomic, strong) NSMutableArray *videoList;

- (void)setBanners:(NSArray *)banner;

@end

NS_ASSUME_NONNULL_END
