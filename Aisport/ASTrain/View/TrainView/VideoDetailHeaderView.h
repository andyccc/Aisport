//
//  VideoDetailHeaderView.h
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class VideoDetailInfoModel;

@interface VideoDetailHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImageView *videoImageView;

- (void)fillData:(VideoDetailInfoModel *)data;

+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
