//
//  NSString+getHeight.h
//  EliteHeadlines
//
//  Created by 田桔 on 2018/6/4.
//  Copyright © 2018年 GJesus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (getHeight)

+ (CGFloat)getHeightWithText:(NSString *)text andWithWidth:(CGFloat)width andWithFont:(UIFont *)font;

@end
