//
//  StopTrainView.h
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContinuePlayVideoBlock)(void);
typedef void(^BackPlayVideoBlock)(void);
@interface StopTrainView : UIView

@property (nonatomic, copy) ContinuePlayVideoBlock continuePlayVideoBlock;
@property (nonatomic, copy) BackPlayVideoBlock backPlayVideoBlock;

- (instancetype)initWithFrame:(CGRect)frame IsTV:(BOOL)isTV;

@end

NS_ASSUME_NONNULL_END
