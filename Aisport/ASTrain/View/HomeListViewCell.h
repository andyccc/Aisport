//
//  HomeListViewCell.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^HomeCellJumpBlock)(void);
@interface HomeListViewCell : UITableViewCell

@property (nonatomic, copy) HomeCellJumpBlock homeCellJumpBlock;

@property (nonatomic, strong) HomeListModel *model;

@end

NS_ASSUME_NONNULL_END
