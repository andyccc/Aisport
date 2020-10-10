//
//  HomeVideoViewCell.h
//  Aisport
//
//  Created by Apple on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CT_PlayVideoBlcok)(NSString *urlStr);
@interface HomeVideoViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *difficultLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *autherLabel;
@property (nonatomic, strong) UILabel *recordLabel;
@property (nonatomic, strong) NSMutableArray *rankViewArr;
@property (nonatomic, copy) CT_PlayVideoBlcok playVideoBlcok;

@property (nonatomic, strong) HomeListModel *model;

@end

NS_ASSUME_NONNULL_END
