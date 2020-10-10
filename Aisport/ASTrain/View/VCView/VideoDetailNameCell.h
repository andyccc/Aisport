//
//  VideoDetailNameCell.h
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class VideoDetailInfoModel;

@interface VideoDetailNameCell : UITableViewCell

@property (nonatomic, copy) void(^showIntroductionBlock)(void);

- (void)fillData:(VideoDetailInfoModel *)data withShowIntroduction:(BOOL)showIntroduction;
+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
