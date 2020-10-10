//
//  SearchCollectionViewCell.h
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *contentLabel;

- (void)fillData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
