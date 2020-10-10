//
//  ThreeSlideTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreeSlideTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) void (^tapBlock) (NSInteger index);

@end

NS_ASSUME_NONNULL_END
