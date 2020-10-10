//
//  MineTitleIconViewCell.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTitleIconViewCell : UITableViewCell

@property (nonatomic,strong)UIView* bodyView,* lineView;

@property (nonatomic,strong)UIImageView* iconView,* arrowImg;

@property (nonatomic,strong)UILabel* titleLab,* subLabel;

@end

NS_ASSUME_NONNULL_END
