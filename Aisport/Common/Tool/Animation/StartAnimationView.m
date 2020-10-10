//
//  StartAnimationView.m
//  Aisport
//
//  Created by Apple on 2020/11/17.
//

#import "StartAnimationView.h"

@implementation StartAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *ligntImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:ligntImageView];
        ligntImageView.image = [UIImage imageNamed:@"train_light"];
        ligntImageView.contentMode = UIViewContentModeScaleAspectFill;
        ligntImageView.clipsToBounds = YES;
        _ligntImageView = ligntImageView;
        
        [self animationScaleWithLayer:_ligntImageView.layer];
        
//        UIImageView *flowLightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self addSubview:flowLightImageView];
//        flowLightImageView.image = [UIImage imageNamed:@"train_light"];
//        flowLightImageView.contentMode = UIViewContentModeScaleAspectFill;
//        flowLightImageView.clipsToBounds = YES;
//        
//        CALayer *maskLayer = [CALayer layer];
//        maskLayer.frame = flowLightImageView.bounds;
//        UIImage *maskImage = [UIImage imageNamed:@"btnLightMask.jpg"];
//        maskLayer.contents = (__bridge id)maskImage.CGImage;
//        flowLightImageView.layer.mask = maskLayer;
        
//        CABasicAnimation *flowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//        flowAnimation.fromValue = [NSNumber numberWithFloat:-79.0];
//        flowAnimation.toValue = [NSNumber numberWithFloat:168.0];
//        flowAnimation.duration = 2.0;
//        flowAnimation.repeatCount = FLT_MAX;
//        flowAnimation.removedOnCompletion = NO;
//        flowAnimation.fillMode = kCAFillModeForwards;
//        [maskLayer addAnimation:flowAnimation forKey:@"transform.translation.x"];
        
    }
    return self;
}

//抖动动画
- (void)animationScaleWithLayer:(CALayer *)layer
{
    CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    transformAnimation.beginTime = 2.0;
    transformAnimation.fromValue = [NSNumber numberWithFloat:0.9];
    transformAnimation.toValue = [NSNumber numberWithFloat:1.1];
    transformAnimation.duration = 0.5;
    transformAnimation.repeatCount = MAXFLOAT;
    transformAnimation.beginTime = CACurrentMediaTime()+2;
    [layer addAnimation:transformAnimation forKey:@"scale-layer1"];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
