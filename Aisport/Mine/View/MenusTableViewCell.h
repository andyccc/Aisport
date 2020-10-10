//
//  MenusTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenusTableViewCell : BaseTableViewCell

@property (nonatomic, copy) void (^btnBlock) (NSInteger index);

@end

NS_ASSUME_NONNULL_END
