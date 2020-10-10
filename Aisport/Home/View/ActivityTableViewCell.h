//
//  ActivityTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActivityTableViewCell : BaseTableViewCell

@property (nonatomic, strong) UIButton *countDownView;
@property (nonatomic, strong) UIImageView *timeBgView;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, copy) void (^btnBlock) (NSInteger type);

- (void)btnAction:(UIButton *)btn;
- (NSMutableAttributedString *)createAttributedString:(NSString *)title info:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
