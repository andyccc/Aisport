//
//  VideoAnimationTool.h
//  Aisport
//
//  Created by Apple on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoAnimationTool : NSObject

+ (void)addWaveAnimationToLayer:(CALayer *)layer BelowLayer:(CALayer *)belowLayer Posion:(CGPoint)posion Bounds:(CGRect)bounds;

+ (void)addSnowEmitterLayerToLayer:(CALayer *)layer WithIsTV:(BOOL)isTV;

+ (void)animationStateTextViewWithLayer:(CALayer *)layer WithScale:(float)scal;

+ (void)animationStateImageBGViewWithLayer:(CALayer *)layer;

@end

NS_ASSUME_NONNULL_END
