//
//  NSString+cheekContent.m
//  NeoPay
//
//  Created by Jesus on 2017/5/15.
//  Copyright © 2017年 Jesus. All rights reserved.
//

#import "NSString+cheekContent.h"

@implementation NSString (cheekContent)

- (BOOL)isValidateByRegex:(NSString *)regex
{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
}

- (BOOL)cheekMobile
{
    if (self.length != 11)
    {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)simpleVerifyIdentityCardNum
{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self isValidateByRegex:regex2];
}

-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}

- (BOOL)cheekPassword
{
    BOOL result = false;
    if ([self length] >= 8){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:self];
    }
    return result;
}

- (BOOL)cheekPayPassword
{
    NSString * regex = @"(^-?[1-9]\\d*$)";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    if (isMatch && self.length == 6) {
        return YES;
    }else{
        return NO;
    }
}
+ (NSString *)stringForId:(id)object {
    NSString *str = (NSString *)object;
    
    if (str == nil) return @"";
    if (str == NULL) return @"";
    if ([str isKindOfClass:[NSNull class]]) return @"";
    if ([str isEqual:[NSNull null]]) {
        return @"";
    }
    str = [NSString stringWithFormat:@"%@",str];
    return str;
}

//ios 11之后从电话簿复制粘贴会出现特殊不可见字符 需要处理
+ (NSString *)getSeparatedPhoneNumberWithString:(NSString *)phoneString
{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    NSString * string = phoneString;
    //invertedSet方法是去反字符,把所有的除了characterSet里的字符都找出来(包含去空格功能)
    NSCharacterSet *specCharacterSet = [characterSet invertedSet];
    NSArray * strArr = [string componentsSeparatedByCharactersInSet:specCharacterSet];
    
    return [strArr componentsJoinedByString:@""];
    
}


@end
