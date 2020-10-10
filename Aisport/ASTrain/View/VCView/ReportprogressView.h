//
//  ReportprogressView.h
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReportprogressView : UIView

@property (nonatomic, strong) UILabel *upTitleLabel;
@property (nonatomic, strong) UIView *upView;
@property (nonatomic, strong) UILabel *stateTitleLabel;
@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, assign) float value;

@end

NS_ASSUME_NONNULL_END
