//
//  CalibrateBodyView.h
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalibrateBodyView : UIView

@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UILabel *botoomTiLab;
@property (nonatomic, strong) UIImageView *picImageView;

- (instancetype)initWithFrame:(CGRect)frame IsTV:(BOOL)isTV;

@end

NS_ASSUME_NONNULL_END
