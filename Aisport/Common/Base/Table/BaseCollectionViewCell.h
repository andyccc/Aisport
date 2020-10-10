//
//  BaseCollectionViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewCell : UICollectionViewCell

+ (id)dequeueReusableCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
+ (NSString *)reuseIdentifier;
+ (CGSize)sizeForItemCell;

- (void)fillData:(id)data;

@end

NS_ASSUME_NONNULL_END
