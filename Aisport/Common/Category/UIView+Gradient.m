//
//  UIView+Gradient.m
//  AZCategory
//
//  Created by Alfred Zhang on 2017/6/29.
//  Copyright © 2017年 Alfred Zhang. All rights reserved.
//

#import "UIView+Gradient.h"
#import <objc/runtime.h>

@implementation UIView (Gradient)


+ (Class)layerClass {
    return [CAGradientLayer class];
}

+ (UIView *)gradientViewWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIView *view = [[self alloc] init];
    [view setGradientBackgroundWithColors:colors locations:locations startPoint:startPoint endPoint:endPoint];
    return view;
}

- (void)setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    self.colors = [colorsM copy];
    self.locations = locations;
    self.startPoint = startPoint;
    self.endPoint = endPoint;
}

- (void)setMainGradientBackgroundColors
{
    NSMutableArray *colorsM = [NSMutableArray array];
    
    NSArray* colors = @[[UIColor colorForHex:@"FFB75B"],[UIColor colorForHex:@"FEA043"]];
    
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    self.colors = [colorsM copy];
    self.locations = nil;
    self.startPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(1, 0);
}

-(void)setUnableGradientBackgroundColors
{
    NSMutableArray *colorsM = [NSMutableArray array];
    
    NSArray* colors = @[[UIColor colorForHex:@"CCCCCC"],[UIColor colorForHex:@"CCCCCC"]];
    
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    self.colors = [colorsM copy];
    self.locations = nil;
    self.startPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(1, 0);
}

-(void)setBgGradientBackgroundColors
{
    NSMutableArray *colorsM = [NSMutableArray array];
    
    NSArray* colors = @[[UIColor colorWithHex:@"#000000" alpha:0.29],[UIColor colorWithHex:@"#000000" alpha:0.0]];
    
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    self.colors = [colorsM copy];
    self.locations = nil;
    self.startPoint = CGPointMake(0.5, 1);
    self.endPoint = CGPointMake(0.5, 0);
}

-(void)setPupGradientBackgroundColors
{
    NSMutableArray *colorsM = [NSMutableArray array];
    
    NSArray* colors = @[[UIColor colorForHex:@"A433E1"],[UIColor colorForHex:@"C62173"]];
    
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    self.colors = [colorsM copy];
    self.locations = nil;
    self.startPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(1, 0);
}

-(void)setTagGradientBackgroundColors
{
    NSMutableArray *colorsM = [NSMutableArray array];
    
    NSArray* colors = @[[UIColor colorForHex:@"DA6031"],[UIColor colorWithHex:@"FB8B36" alpha:0]];
    
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    self.colors = [colorsM copy];
    self.locations = nil;
    self.startPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(1, 0);
}

-(void)setYellowBackgroundColors
{
    NSMutableArray *colorsM = [NSMutableArray array];
    
    NSArray* colors = @[[UIColor colorForHex:@"F6906D"],[UIColor colorForHex:@"FAB72D"]];
    
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    self.colors = [colorsM copy];
    self.locations = nil;
    self.startPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(1, 0);
}

-(void)setResumeBackgroundColors
{
    NSMutableArray *colorsM = [NSMutableArray array];
    
    NSArray* colors = @[[UIColor colorForHex:@"1145AF"],[UIColor colorForHex:@"3A70DF"]];
    
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    
    self.colors = [colorsM copy];
    self.locations = nil;
    self.startPoint = CGPointMake(0, 0);
    self.endPoint = CGPointMake(1, 0);
}

#pragma mark- Getter&Setter

- (NSArray *)colors {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setColors:(NSArray *)colors {
    objc_setAssociatedObject(self, @selector(colors), colors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setColors:self.colors];
    }
}

- (NSArray<NSNumber *> *)locations {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLocations:(NSArray<NSNumber *> *)locations {
    objc_setAssociatedObject(self, @selector(locations), locations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setLocations:self.locations];
    }
}

- (CGPoint)startPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setStartPoint:(CGPoint)startPoint {
    objc_setAssociatedObject(self, @selector(startPoint), [NSValue valueWithCGPoint:startPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setStartPoint:self.startPoint];
    }
}

- (CGPoint)endPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setEndPoint:(CGPoint)endPoint {
    objc_setAssociatedObject(self, @selector(endPoint), [NSValue valueWithCGPoint:endPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setEndPoint:self.endPoint];
    }
}


@end

@implementation UILabel (Gradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end


