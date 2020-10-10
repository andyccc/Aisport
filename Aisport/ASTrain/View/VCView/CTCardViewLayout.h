//
//  CTCardViewLayout.h
//  Aisport
//
//  Created by Apple on 2020/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CTCardlSlideIndexBlock)(NSInteger index);
@interface CTCardViewLayout : UICollectionViewLayout

@property (nonatomic, copy) CTCardlSlideIndexBlock cardlSlideIndexBlock;

@property (nonatomic) NSInteger visibleCount;

@property (nonatomic) CGSize itemSize;

@end

NS_ASSUME_NONNULL_END
