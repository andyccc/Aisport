//
//  TrainReportShareView.h
//  Aisport
//
//  Created by Apple on 2020/10/29.
//

#import <UIKit/UIKit.h>
#import "TrainReportModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancleReportBtnClickBlock)(void);
@interface TrainReportShareView : UIView

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *backBgImageView;
@property (nonatomic, copy) CancleReportBtnClickBlock cancleReportBtnClickBlock;


- (instancetype)initWithFrame:(CGRect)frame AndModel:(TrainReportModel *)model WithImage:(UIImage *)coverImage;;

@end

NS_ASSUME_NONNULL_END
