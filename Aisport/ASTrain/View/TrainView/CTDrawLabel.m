//
//  CTDrawLabel.m
//  Aisport
//
//  Created by Apple on 2020/11/19.
//

#import "CTDrawLabel.h"

@implementation CTDrawLabel

- (void)drawTextInRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    // 设置描边宽度
    CGContextSetLineWidth(c, 1);
    CGContextSetLineJoin(c, kCGLineJoinRound);
    CGContextSetTextDrawingMode(c, kCGTextStroke);
    // 描边颜色
    self.textColor = [UIColor colorWithHex:_drawColorStr alpha:1.0];  //#5FE9E5  #1FD22B
    [super drawTextInRect:rect];
    // 文本颜色
    self.textColor = [UIColor whiteColor];
    CGContextSetTextDrawingMode(c, kCGTextFill);
    [super drawTextInRect:rect];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
