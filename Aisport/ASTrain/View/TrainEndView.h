//
//  TrainEndView.h
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClicSureBtnBlock)(void);
@interface TrainEndView : UIView

@property (nonatomic, copy) ClicSureBtnBlock clicSureBtnBlock;

@end

NS_ASSUME_NONNULL_END
