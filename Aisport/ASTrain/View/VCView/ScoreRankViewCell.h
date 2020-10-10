//
//  ScoreRankViewCell.h
//  Aisport
//
//  Created by Apple on 2020/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoreRankViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *rankImageView;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *scoreLabel;

@property (nonatomic, assign) BOOL isMySelf;

@end

NS_ASSUME_NONNULL_END
