//
//  WholePartVideoViewCell.h
//  Aisport
//
//  Created by Apple on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "WholePartModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WholePartVideoViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
//@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, strong) WholePartModel *model;

@end

NS_ASSUME_NONNULL_END
