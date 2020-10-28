//
//  DatetimeOpeartion.h
//  NeoPay
//
//  Created by Jesus on 2017/5/18.
//  Copyright © 2017年 Jesus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatetimeOpeartion : NSObject

+(long long)getAWeekTimesWith:(int)days;//获取近几天的时间戳

+(long long)getCurrentSeconds;//获取当前的时间戳

+(NSString*)getDateStrYYYYMMDDWith:(long long)second;//根据时间戳获取年月日

+(NSString*)getDateStrFormattertWith:(long long)second and:(NSString*)formatter;//根据时间戳获取年月日

+(long long)getSecondWith:(NSString *)dateStr and:(NSString *)formatter;  //根据根据时间获取时间戳

+(long long)getDateSecondWith:(NSDate *)currentDate and:(NSString *)formatter;        //根据根据时间获取时间戳

+(long long)getSecondWith:(NSString*)dateStr;//根据根据年月日获取时间戳

+(NSString*)getNowYears;//获取当前年份

+ (NSArray*)getDatesWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;  //获取时间段间的时间

+ (NSArray*)getDatesWithStartDateStr:(NSString *)startDate endDateStr:(NSString *)endDate;  //获取时间段间的时间

//根据生日计算年龄
+ (int)getAgeWithBirthDay:(NSString *)birthDay and:(NSString *)formatter;

//根据给的格式为formatter获取实现几天前，几小时前，几分钟前
+ (NSString *)compareCurrentTime:(NSString *)str and:(NSString *)formatter;

//根据给的时间戳获取实现几天前，几小时前，几分钟前
+ (NSString *)compareCurrentTimeWith:(long long)second;
@end
