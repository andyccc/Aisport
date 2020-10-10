//
//  VideoDetailGrowthListCell.h
//  Aisport
//
//  Created by 申公安 on 2020/12/26.
//

#import <UIKit/UIKit.h>
#import "VideoDetailGrowthListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StartView : UIView

@end

@interface VideoDetailGrowthListCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *bankLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) StartView *startView;

- (void)fillData:(VideoDetailGrowthListModel *)data;
+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
