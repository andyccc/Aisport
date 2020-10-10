//
//  MyTrainHViewCell.h
//  Aisport
//
//  Created by Apple on 2020/11/25.
//

#import <UIKit/UIKit.h>
#import "TrainVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CT_PlayMyVideoBlcok)(NSString *urlStr);
@interface MyTrainHViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) NSMutableArray *rankViewArr;
@property (nonatomic, copy) CT_PlayMyVideoBlcok playMyVideoBlcok;

@property (nonatomic, strong) TrainVideoModel *model;

@end

NS_ASSUME_NONNULL_END
