//
//  MyVideoListViewCell.h
//  Aisport
//
//  Created by Apple on 2020/11/12.
//

#import <UIKit/UIKit.h>
#import "TrainVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CT_PlayWholeVideoBlcok)(NSString *urlStr);
@interface MyVideoListViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, copy) CT_PlayWholeVideoBlcok playWholeVideoBlcok;


@property (nonatomic, strong) TrainVideoModel *videoModel;

@end

NS_ASSUME_NONNULL_END
