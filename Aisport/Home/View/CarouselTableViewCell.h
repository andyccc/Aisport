//
//  CarouselTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarouselTableViewCell : BaseTableViewCell 

@property (nonatomic, copy) void (^tapBlock) (NSInteger index);

@end

NS_ASSUME_NONNULL_END
