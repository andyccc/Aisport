//
//  HomeSectionTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeSectionTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, copy) void (^btnBlock) (void);

@end

NS_ASSUME_NONNULL_END
