//
//  CardStaticView.h
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardStaticView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *playCountLabel;
@property (nonatomic, strong) UILabel *historyCountLabel;
@property (nonatomic, strong) UILabel *costCountLabel;

@end

NS_ASSUME_NONNULL_END
