//
//  VideoDetailIntroductionCell.h
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import <UIKit/UIKit.h>
#import "VideoDetailInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailIntroductionCell : UITableViewCell

- (void)fillData:(VideoDetailInfoModel *)data;
+ (CGFloat)cellHeight:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
