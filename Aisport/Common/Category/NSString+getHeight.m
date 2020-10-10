//
//  NSString+getHeight.m
//  EliteHeadlines
//
//  Created by 田桔 on 2018/6/4.
//  Copyright © 2018年 GJesus. All rights reserved.
//

#import "NSString+getHeight.h"

@implementation NSString (getHeight)

+ (CGFloat)getHeightWithText:(NSString *)text andWithWidth:(CGFloat)width andWithFont:(UIFont *)font
{
    return [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{ NSFontAttributeName : font} context:nil ].size.height;//NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
}

@end
