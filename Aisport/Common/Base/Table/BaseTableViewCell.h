//
//  BaseTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewCell : UITableViewCell

+ (id)dequeueReusableWith:(UITableView *)tableView;

+ (CGFloat)cellHeight;
+ (CGFloat)cellHeight:(id)data;

- (void)initSelf;
- (void)fillData:(id)data;


@end

NS_ASSUME_NONNULL_END
