//
//  SearchFlowLayout.h
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AlignType) {
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

NS_ASSUME_NONNULL_BEGIN

@interface SearchFlowLayout : UICollectionViewFlowLayout

//两个Cell之间的距离
@property (nonatomic, assign) CGFloat betweenOfCell;

//cell对齐方式
@property (nonatomic, assign) AlignType cellType;

- (instancetype)initWthType:(AlignType)cellType;

//全能初始化方法 其他方式初始化最终都会走到这里
- (instancetype)initWithType:(AlignType)cellType betweenOfCell:(CGFloat)betweenOfCell;

@end

NS_ASSUME_NONNULL_END
