//
//  TRClassProgressView.m
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import "TRClassProgressView.h"

@implementation TRClassProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - SDProgressViewItemMargin * 0.2;
    
//    // 进度环边框
//    [[UIColor grayColor] set];
//    CGFloat w = radius * 2 + 1;
//    CGFloat h = w;
//    CGFloat x = (rect.size.width - w) * 0.5;
//    CGFloat y = (rect.size.height - h) * 0.5;
//    CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
//    CGContextStrokePath(ctx);
    
    
    // 进度底框
    [[UIColor colorWithHex:@"#dedede"] set];
    CGContextMoveToPoint(ctx, xCenter, yCenter);
    CGContextAddLineToPoint(ctx, xCenter, 0);
    CGFloat end = - M_PI * 0.5 + M_PI * 2 + 0.001; // 初始值
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, end, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    
    // 进度环
    [[UIColor colorWithHex:@"#1BC2B1"] set];
    CGContextMoveToPoint(ctx, xCenter, yCenter);
    CGContextAddLineToPoint(ctx, xCenter, 0);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 初始值
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
//
    
    // 遮罩
    [[UIColor whiteColor] set];
    CGFloat maskW = (radius - 4) * 2;
    CGFloat maskH = maskW;
    CGFloat maskX = (rect.size.width - maskW) * 0.5;
    CGFloat maskY = (rect.size.height - maskH) * 0.5;
    CGContextAddEllipseInRect(ctx, CGRectMake(maskX, maskY, maskW, maskH));
    CGContextFillPath(ctx);
    
//    // 遮罩
//    [SDColorMaker(240, 240, 240, 1) set];
//    CGFloat maskW = (radius - 15) * 2;
//    CGFloat maskH = maskW;
//    CGFloat maskX = (rect.size.width - maskW) * 0.5;
//    CGFloat maskY = (rect.size.height - maskH) * 0.5;
//    CGContextAddEllipseInRect(ctx, CGRectMake(maskX, maskY, maskW, maskH));
//    CGContextFillPath(ctx);
//
//    // 遮罩边框
//    [[UIColor grayColor] set];
//    CGFloat borderW = maskW + 1;
//    CGFloat borderH = borderW;
//    CGFloat borderX = (rect.size.width - borderW) * 0.5;
//    CGFloat borderY = (rect.size.height - borderH) * 0.5;
//    CGContextAddEllipseInRect(ctx, CGRectMake(borderX, borderY, borderW, borderH));
//    CGContextStrokePath(ctx);
    
    // 进度数字
    NSString *progressStr = [NSString stringWithFormat:@"%.0f%s", self.progress * 100, "\%"];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20 * SDProgressViewFontScale];
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [self setCenterProgressText:progressStr withAttributes:attributes];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
