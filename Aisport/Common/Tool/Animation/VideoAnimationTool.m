//
//  VideoAnimationTool.m
//  Aisport
//
//  Created by Apple on 2020/12/2.
//

#import "VideoAnimationTool.h"

@implementation VideoAnimationTool

#pragma mark - 水波纹动画
+ (void)addWaveAnimationToLayer:(CALayer *)layer BelowLayer:(CALayer *)belowLayer Posion:(CGPoint)posion Bounds:(CGRect)bounds
{
    CAShapeLayer *waveLayer = [CAShapeLayer layer];
//    waveLayer.bounds = CGRectMake(0, 0, SCR_WIDTH-220, SCR_WIDTH-220);
    waveLayer.bounds = CGRectMake(0, 0, 194, 194);
    
    waveLayer.position = posion;
    waveLayer.cornerRadius = (194)/2;
    waveLayer.borderColor = [UIColor colorWithHex:@"#FFFFFF" alpha:0.09].CGColor;
    waveLayer.borderWidth = 0;
//    waveLayer.backgroundColor = [UIColor colorWithHex:@"#FFFFFF" alpha:1.0].CGColor;
    [layer insertSublayer:waveLayer atIndex:1];
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    [CATransaction setCompletionBlock:^{
        [waveLayer removeFromSuperlayer];
    }];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 3;
    scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    float fromScale = belowLayer.bounds.size.width/(194);
    scaleAnimation.fromValue = [NSNumber numberWithFloat:fromScale];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.f];
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    
    [waveLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    alphaAnimation.duration = 3;
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    alphaAnimation.fromValue = (__bridge id _Nullable)([UIColor colorWithHex:@"#FFFFFF" alpha:0.09].CGColor);
    alphaAnimation.toValue = (__bridge id _Nullable)([UIColor colorWithHex:@"#FFFFFF" alpha:0.06].CGColor);
    alphaAnimation.fillMode = kCAFillModeForwards;
    alphaAnimation.removedOnCompletion = NO;
    
    [waveLayer addAnimation:alphaAnimation forKey:@"backgroundColor"];
    
    [CATransaction commit];
}

+ (void)animationStateTextViewWithLayer:(CALayer *)layer WithScale:(float)scal
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[[NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:scal],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:0.8]];
    animation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                            [NSNumber numberWithFloat:0.05],
                            [NSNumber numberWithFloat:0.15],
                            [NSNumber numberWithFloat:1.0]];
    animation.repeatCount = 1;
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation1.values = @[[NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:0.8],
                          [NSNumber numberWithFloat:0.0]];
    animation1.keyTimes = @[[NSNumber numberWithFloat:0.0],
                            [NSNumber numberWithFloat:0.1],
                            [NSNumber numberWithFloat:0.3],
                            [NSNumber numberWithFloat:0.7],
                            [NSNumber numberWithFloat:1.0]];
    animation1.repeatCount = 1;
    
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation,animation1];
    animationGroup.duration = 1.0f;
    animationGroup.removedOnCompletion = NO;
    animationGroup.beginTime = CACurrentMediaTime() + 0.1;
    [animationGroup setValue:@"textOpacity" forKey:@"AnimationKey"];

    // 添加动画
    [layer addAnimation:animationGroup forKey:@"text-Opacity"];
}

+ (void)animationStateImageBGViewWithLayer:(CALayer *)layer
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.values = @[[NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:1.5],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:1.0]];
    animation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                            [NSNumber numberWithFloat:0.1],
                            [NSNumber numberWithFloat:0.3],
                            [NSNumber numberWithFloat:0.7],
                            [NSNumber numberWithFloat:1.0]];
    animation.repeatCount = 1;
    
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation1.values = @[[NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:1.0],
                          [NSNumber numberWithFloat:0.8],
                          [NSNumber numberWithFloat:0.0]];
    animation1.keyTimes = @[[NSNumber numberWithFloat:0.0],
                            [NSNumber numberWithFloat:0.1],
                            [NSNumber numberWithFloat:0.3],
                            [NSNumber numberWithFloat:0.7],
                            [NSNumber numberWithFloat:1.0]];
    animation1.repeatCount = 1;
    
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[animation,animation1];
    animationGroup.duration = 0.5f;
    animationGroup.beginTime = CACurrentMediaTime() + 0.1;
    animationGroup.removedOnCompletion = NO;
    [animationGroup setValue:@"imageBgOpacity" forKey:@"AnimationKey"];

    // 添加动画
    [layer addAnimation:animationGroup forKey:@"imageBg-Opacity"];
}


+ (void)addSnowEmitterLayerToLayer:(CALayer *)layer WithIsTV:(BOOL)isTV
{
    CGFloat downW = SCR_WIDTH;
    if (isTV) {
        downW = SCR_max;
    }
    
    CAEmitterLayer *parentLayer = [CAEmitterLayer layer];
    parentLayer.emitterPosition = CGPointMake(downW / 2.0, -30);
    parentLayer.emitterSize        = CGSizeMake(downW * 2.0, 0);;
    parentLayer.emitterMode        = kCAEmitterLayerOutline;
    parentLayer.emitterShape    = kCAEmitterLayerLine;
//    parentLayer.shadowOpacity = 1.0;
//    parentLayer.shadowRadius  = 0.0;
//    parentLayer.shadowOffset  = CGSizeMake(0.0, 1.0);
//    parentLayer.shadowColor   = [[UIColor whiteColor] CGColor];
    parentLayer.seed = (arc4random()%100)+1;
    

    
    CAEmitterCell * smoke = [CAEmitterCell emitterCell];
    smoke.birthRate=50;
    smoke.lifetime=7.0;
    smoke.lifetimeRange=3;
    smoke.scale = 0.3;
    smoke.scaleRange = 0.1;
    smoke.color=[UIColor colorWithRed:255 green:0 blue:0 alpha:1.0].CGColor;
//    smoke.alphaRange = 1;
//    smoke.redRange =1.5;
    smoke.blueRange = 1.5;
    smoke.greenRange = 225;
    smoke.contents=(id)[[UIImage imageNamed:@"result_Paper"]CGImage];
    [smoke setName:@"smoke"];
    
    smoke.velocity=70;
    smoke.velocityRange=20;
    smoke.emissionLongitude=M_PI+M_PI_4;
    smoke.emissionRange=M_PI_2;
    smoke.spin = M_PI_2;
    smoke.spinRange = M_PI_2;
    
    parentLayer.emitterCells=[NSArray arrayWithObjects:smoke,nil];
    [layer addSublayer:parentLayer];
}




//+ (void)addFlowerEmitterLayerToLayer:(CAEmitterLayer *)emitterLayer Count:(long)count
//{
//    emitterLayer.birthRate += 1;
//
//    if (!emitterLayer.emitterCells.count) {
//        CAEmitterCell *newFlowerCell = [CAEmitterCell emitterCell];
//        //粒子产生率
//        newFlowerCell.birthRate = 1.f;
//        //粒子生命周期
//        newFlowerCell.lifetime = 10.f;
//        //速度值
//        newFlowerCell.velocity = 50.f;
//        //速度值的微调值
//        newFlowerCell.velocityRange = 10.f;
//        //y轴加速度
//        newFlowerCell.yAcceleration = 100.f;
//        //发射角度
//        newFlowerCell.emissionRange = 0.5 *M_PI;
//        newFlowerCell.spinRange = 0.25 * M_PI;
//        //设置粒子颜色
//        //    cell.color = [UIColor blueColor].CGColor;
//
//        newFlowerCell.contents = (__bridge id _Nullable)([UIImage nhwcImaheWithName:@"NHWC_Flower_Ani"].CGImage);
//        newFlowerCell.scale = 0.3;
//        newFlowerCell.scaleRange = 0.3;
//        //让CAEmitterCell与CAEmitterLayer产生关系
//        emitterLayer.emitterCells = @[newFlowerCell];
//    }
//    __block CAEmitterLayer *layer = emitterLayer;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        layer.birthRate -= 1;
//    });
//}


@end
