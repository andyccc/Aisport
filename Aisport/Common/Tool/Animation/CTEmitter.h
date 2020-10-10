//
//  CTEmitter.h
//  CTEmitterAnimation
//
//  Created by Apple on 2020/11/3.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HIDO,
    SUPER,
    GOOD,
    PERFECT,
} TRActionState;

NS_ASSUME_NONNULL_BEGIN

@interface CTEmitter : UIView

@property (nonatomic, strong)UILabel *label;
@property (nonatomic,strong) UIColor * showColor;

- (void)makeEmitter;

- (void)animationWith:(CGFloat)value;

- (void)reduceEmitter;

- (void)addEmitterWithState:(TRActionState)state;

- (void)changeEmitterContentWithState:(TRActionState)state;

- (void)initFireworks;


@end

NS_ASSUME_NONNULL_END
