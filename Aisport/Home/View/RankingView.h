//
//  RankingView.h
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankingView : UIView

@property (nonatomic, strong) UIButton *indexBtn;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nickLabel;
@property (nonatomic, strong) UILabel *eggsLabel;

- (void)setNumber:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
