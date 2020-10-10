//
//  MyWholeTrainLIstViewCell.h
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import <UIKit/UIKit.h>
#import "MyWholeVideoListModel.h"
#import "TrainVideoModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickTrainVideoBlock)(TrainVideoModel *model);
typedef void(^ClickSelectedVideoBlock)(TrainVideoModel *model);
@interface MyWholeTrainLIstViewCell : UITableViewCell

@property (nonatomic, strong) MyWholeVideoListModel *listModel;

@property (nonatomic, copy) ClickTrainVideoBlock clickTrainVideoBlock;
@property (nonatomic, copy) ClickSelectedVideoBlock clickSelectedVideoBlock;

@end

NS_ASSUME_NONNULL_END
