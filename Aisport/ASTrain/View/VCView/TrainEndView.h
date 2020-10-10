//
//  TrainEndView.h
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import <UIKit/UIKit.h>
#import "TrainReportModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClicSureBtnBlock)(void);
@interface TrainEndView : UIView

//@property (nonatomic, strong) TrainReportModel *reportModel;
@property (nonatomic, copy) ClicSureBtnBlock clicSureBtnBlock;

- (instancetype)initWithFrame:(CGRect)frame AndModel:(TrainReportModel *)model;

@end

NS_ASSUME_NONNULL_END
