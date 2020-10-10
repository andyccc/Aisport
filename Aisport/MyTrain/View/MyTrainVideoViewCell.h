//
//  MyTrainVideoViewCell.h
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import <UIKit/UIKit.h>
#import "TrainVideoModel.h"
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTrainVideoViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *difficultLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *autherLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *timeLabel;;

@property (nonatomic, assign) BOOL isHome;
@property (nonatomic, strong) HomeListModel *homeModel;
@property (nonatomic, strong) TrainVideoModel *videoModel;

@end

NS_ASSUME_NONNULL_END
