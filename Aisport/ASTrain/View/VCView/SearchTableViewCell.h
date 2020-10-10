//
//  SearchTableViewCell.h
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import <UIKit/UIKit.h>

@class VideoElementListModel;

NS_ASSUME_NONNULL_BEGIN

@interface SearchTableViewCell : UITableViewCell

- (void)fillCell:(VideoElementListModel *)data;

+ (CGFloat)rowHeight;

@end

NS_ASSUME_NONNULL_END
