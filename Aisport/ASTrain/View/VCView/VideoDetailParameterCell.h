//
//  VideoDetailParameterCell.h
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import <UIKit/UIKit.h>
#import "VideoDetailInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailParameterCell : UITableViewCell

- (void)fillData:(VideoDetailInfoModel *)data;
+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
