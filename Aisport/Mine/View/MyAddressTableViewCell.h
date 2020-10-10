//
//  MyAddressTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyAddressTableViewCell : BaseTableViewCell

/// type 0 select 1 edit 2 delete
@property (nonatomic, copy) void (^actionBlock) (int type);

@end

NS_ASSUME_NONNULL_END
