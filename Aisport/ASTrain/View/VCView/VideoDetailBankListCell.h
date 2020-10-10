//
//  VideoDetailBankListCell.h
//  Aisport
//
//  Created by 申公安 on 2020/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailBankListCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UIImageView *avtarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *countLabel;

- (void)fillData:(NSDictionary *)data withIndex:(NSInteger)index;
+ (CGFloat)cellHeihgt;

@end

NS_ASSUME_NONNULL_END
