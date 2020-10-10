//
//  AddEmitterView.h
//  Aisport
//
//  Created by Apple on 2020/12/15.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AHIDO,
    ASUPER,
    AGOOD,
    APERFECT,
} ATRActionState;
NS_ASSUME_NONNULL_BEGIN

@interface AddEmitterView : UIView

- (void)makeEmitterWithPositon:(CGPoint)position;

- (void)animationWith:(CGFloat)value;

- (void)reduceEmitter;

- (void)addEmitterWithState:(ATRActionState)state;

- (void)changeEmitterContentWithState:(ATRActionState)state;

@end

NS_ASSUME_NONNULL_END
