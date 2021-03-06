//
//  DatetimeOpeartion.m
//  NeoPay
//
//  Created by Jesus on 2017/5/18.
//  Copyright © 2017年 Jesus. All rights reserved.
//

#import "DatetimeOpeartion.h"

@implementation DatetimeOpeartion
+(long long)getAWeekTimesWith:(int)days
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a = [date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    
    long long nowDate = [[NSString stringWithFormat:@"%.0f", a] longLongValue];
    
    long long daysTime = nowDate - 24 * 3600 * 1000 * (long long)(days - 1);
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* daysDate = [NSDate dateWithTimeIntervalSince1970:daysTime/1000.0];
    
    NSString* dateString = [formatter stringFromDate:daysDate];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *thatDate = [dateFormatter dateFromString:dateString];
    
    NSTimeInterval b = [thatDate timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    long long rtDate = [[NSString stringWithFormat:@"%.0f", b] longLongValue];
    
    return rtDate;
}

+(long long)getCurrentSeconds
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a = [date timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    
    long long nowDate = [[NSString stringWithFormat:@"%.0f", a] longLongValue];
    
    return nowDate;
}

+(NSString *)getDateStrYYYYMMDDWith:(long long)second
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    // 毫秒值转化为秒
    NSDate* daysDate = [NSDate dateWithTimeIntervalSince1970:second/1000.0];
    
    NSString* dateString = [formatter stringFromDate:daysDate];
    
    return dateString;
}

+(NSString *)getDateStrFormattertWith:(long long)second and:(NSString *)formatter
{
    NSDateFormatter* f = [[NSDateFormatter alloc] init];
    [f setDateFormat:formatter];
    
    // 毫秒值转化为秒
    NSDate* daysDate = [NSDate dateWithTimeIntervalSince1970:second/1000.0];
    
    NSString* dateString = [f stringFromDate:daysDate];
    
    return dateString;
}

+(long long)getSecondWith:(NSString *)dateStr and:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *thatDate = [dateFormatter dateFromString:dateStr];
    
    NSTimeInterval b = [thatDate timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    long long rtDate = [[NSString stringWithFormat:@"%.0f", b] longLongValue];
    
    return rtDate;
}

+(long long)getDateSecondWith:(NSDate *)currentDate and:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
//    NSDate *thatDate = [dateFormatter dateFromString:dateStr];
    
    NSTimeInterval b = [currentDate timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    long long rtDate = [[NSString stringWithFormat:@"%.0f", b] longLongValue];
    
    return rtDate;
}

+(long long)getSecondWith:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *thatDate = [dateFormatter dateFromString:dateStr];
    
    NSTimeInterval b = [thatDate timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
    long long rtDate = [[NSString stringWithFormat:@"%.0f", b] longLongValue];
    
    return rtDate;
}



+(NSString *)getNowYears
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a = [date timeIntervalSince1970]*1000;
    
    // 毫秒值转化为秒
    NSDate* daysDate = [NSDate dateWithTimeIntervalSince1970:a/1000.0];
    
    NSString* dateString = [formatter stringFromDate:daysDate];
    
    return dateString;
}

+(NSString *)getNowTime
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a = [date timeIntervalSince1970]*1000;
    
    // 毫秒值转化为秒
    NSDate* daysDate = [NSDate dateWithTimeIntervalSince1970:a/1000.0];
    
    NSString* dateString = [formatter stringFromDate:daysDate];
    
    return dateString;
}



+ (NSArray*)getDatesWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd";
    NSDate *start = [startDate earlierDate:endDate];
    NSDate *end = [startDate laterDate:endDate];
    
    NSMutableArray *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        [componentAarray addObject:start];
        
        //后一天
        [comps setDay:([comps day]+1)];
        start = [calendar dateFromComponents:comps];
        
        //对比日期大小
        result = [start compare:end];
    }
    return componentAarray;
}

+ (NSArray*)getDatesWithStartDateStr:(NSString *)startDate endDateStr:(NSString *)endDate
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd";
    NSDate *start = [matter dateFromString:startDate];
    NSDate *end = [matter dateFromString:endDate];
    
    NSMutableArray *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        [componentAarray addObject:start];
        
        //后一天
        [comps setDay:([comps day]+1)];
        start = [calendar dateFromComponents:comps];
        
        //对比日期大小
        result = [start compare:end];
    }
    return componentAarray;
}


+ (int)getAgeWithBirthDay:(NSString *)birthDay and:(NSString *)formatter
{
//    NSString  *birthStr = @"1991-07-13";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *birthDate = [dateFormatter dateFromString:birthDay];
    NSTimeInterval dateDiff = -[birthDate timeIntervalSinceNow];
    //计算年龄
//    int age = trun
    int age = trunc(dateDiff/(60*60*24))/365;
    return age;
}

+ (NSString *)compareCurrentTime:(NSString *)str and:(NSString *)formatter
{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        temp = timeInterval;
        return [NSString stringWithFormat:@"%ld秒前",temp];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}


+ (NSString *)compareCurrentTimeWith:(long long)second {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
//    NSTimeInterval createTime = self.model.tracks.list[row].createdAt/1000;
    // 时间差
    NSTimeInterval time = currentTime - second/1000;
    
    // 秒
    NSInteger seconds = time;
    if (seconds<60) {
        return [NSString stringWithFormat:@"%ld秒前",(long)seconds];
    }
    // 秒转分钟
    NSInteger minute = time/60;
    if (minute<60) {
        return [NSString stringWithFormat:@"%ld分钟前",(long)minute];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",(long)days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",(long)months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",(long)years];
}

+ (NSString *)getTimeHoursMinuteSecondHCurrentTimeWith:(long long)second
{
    if (second<60) {
        return [NSString stringWithFormat:@"00:%02lld",second];
    }
    // 秒转分钟
    NSInteger minute = second/60;
    if (minute<60) {
        return [NSString stringWithFormat:@"%ld:%02lld",(long)minute,second-minute*60];
    }
    // 秒转小时
    NSInteger hours = second/3600;
    NSInteger mihours = (second-hours*3600)/60;
    NSInteger sechours = second-hours*3600-mihours*60;
    return [NSString stringWithFormat:@"%ld:%02ld:%02ld",(long)hours,(long)mihours,(long)sechours];
}


+ (NSString *)getSecondDataWithSecond:(long long)second
{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate = [date  dateByAddingTimeInterval: interval];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setSecond:second];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
    NSDate *minDate = [calender dateByAddingComponents:comps toDate:localDate options:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDateComponents *components = [calender components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:minDate];
    NSInteger thisYear=[components year];
    NSInteger thisMonth=[components month];
    NSInteger thisDay=[components day];
    NSInteger thisHour=[components hour];
    NSInteger thisMinuter=[components minute];
    NSInteger thisSecond=[components second];
    NSString *DateTime = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",(long)thisYear,(long)thisMonth,(long)thisDay,(long)thisHour,(long)thisMinuter,(long)thisSecond];
    return DateTime;
}

+ (NSInteger)compareWithDate:(NSString*)bDate
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *aDate=[formatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*dta = [dateformater dateFromString:aDate];
    NSDate*dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result == NSOrderedDescending) {
        //指定时间 已过期
        return 1;
        
    }else if (result == NSOrderedAscending){
        //指定时间 没过期
        return -1;
    }else{
        //刚好时间一样.
        return 0;
        
    }
    
    
}

+ (NSInteger)compareWithStartDate:(NSString*)startDate AndEndDate:(NSString *)endDate
{
    //创建两个日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *startdate = [dateFormatter dateFromString:startDate];
        NSDate *enddate = [dateFormatter dateFromString:endDate];

        //利用NSCalendar比较日期的差异
        NSCalendar *calendar = [NSCalendar currentCalendar];
        /**
         * 要比较的时间单位,常用如下,可以同时传：
         *    NSCalendarUnitDay : 天
         *    NSCalendarUnitYear : 年
         *    NSCalendarUnitMonth : 月
         *    NSCalendarUnitHour : 时
         *    NSCalendarUnitMinute : 分
         *    NSCalendarUnitSecond : 秒
         */
        NSCalendarUnit unit = NSCalendarUnitDay;//只比较天数差异
        //比较的结果是NSDateComponents类对象
        NSDateComponents *delta = [calendar components:unit fromDate:startdate toDate:enddate options:0];
        //打印
        NSLog(@"%@",delta);
        //获取其中的"天"
        NSLog(@"%ld",delta.day);
    return delta.day;
}

//+ (NSInteger)compareWithDate:(NSString*)bDate{
//
//    //2017-04-24 08:57:29 得到当前时间date
//
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//
//    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//
//    NSString *aDate=[formatter stringFromDate:[NSDate date]];
//
//
//
//    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
//
//    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//
//    
//
//
//
//    dta = [dateformater dateFromString:aDate];
//
//    dtb = [dateformater dateFromString:bDate];
//
//    NSComparisonResult result = [dta compare:dtb];
//
//
//
//    if (result == NSOrderedDescending) {
//
//        //指定时间 已过期
//
//        return 1;
//
//    }
//
//    else if(result == NSOrderedAscending){
//
//        
//
//    }else{
//
//        //刚好时间一样.
//
//        return 0;
//
//    }
//
//
//
//}


@end
