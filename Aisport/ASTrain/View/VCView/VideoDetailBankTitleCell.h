//
//  VideoDetailBankTitleCell.h
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import <UIKit/UIKit.h>
#import "VideoDetailInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailBankTitleCell : UITableViewCell

@property (nonatomic, strong) void(^showBankListBlock)(BOOL isBank);

- (void)fillData:(id)data isBankList:(BOOL)isBankList;
+ (CGFloat)cellHeight;

@end

NS_ASSUME_NONNULL_END
