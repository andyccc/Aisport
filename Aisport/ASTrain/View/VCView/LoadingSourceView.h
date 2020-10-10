//
//  LoadingSourceView.h
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import <UIKit/UIKit.h>
#import "TRClassProgressView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancleLoadingBlock)(void);
@interface LoadingSourceView : UIView

@property (nonatomic, strong) TRClassProgressView *progressView;
@property (nonatomic, copy) CancleLoadingBlock cancleLoadingBlock;

@end

NS_ASSUME_NONNULL_END
