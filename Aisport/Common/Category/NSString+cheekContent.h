//
//  NSString+cheekContent.h
//  NeoPay
//
//  Created by Jesus on 2017/5/15.
//  Copyright © 2017年 Jesus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (cheekContent)

- (BOOL)cheekMobile;
- (BOOL)simpleVerifyIdentityCardNum;
- (BOOL)cheekPassword;
- (BOOL)cheekPayPassword;
- (BOOL)isValidateEmail;
+ (NSString *)getSeparatedPhoneNumberWithString:(NSString *)phoneString;
+ (NSString *)stringForId:(id)object;

@end
