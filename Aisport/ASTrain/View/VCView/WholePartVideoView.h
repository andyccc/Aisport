//
//  WholePartVideoView.h
//  Aisport
//
//  Created by Apple on 2020/11/10.
//

#import <UIKit/UIKit.h>
#import "WholePartModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CT_ClickWholePartVideoBlock)(WholePartModel *model);
@interface WholePartVideoView : UIView

@property (nonatomic, strong) UICollectionView *mainView;

@property (nonatomic, copy) CT_ClickWholePartVideoBlock clickWholePartVideoBlock;
@property (nonatomic, strong) NSMutableArray *dataSoure;

@end

NS_ASSUME_NONNULL_END
