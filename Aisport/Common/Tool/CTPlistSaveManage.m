//
//  CTPlistSaveManage.m
//  Aisport
//
//  Created by Apple on 2020/12/2.
//

#import "CTPlistSaveManage.h"

@implementation CTPlistSaveManage

+ (instancetype)shareManage
{
    static CTPlistSaveManage *saveMange = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        saveMange = [[CTPlistSaveManage alloc] init];
    });
    return saveMange;
}

- (void)insertToPlist:(NSDictionary *)dictionary nickName:(NSString *)nickName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *extention = @"mp4";
//    NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@.plist", documentsDirectory, @"trainRecord"];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    //下边if判断很重要，不然会写入失败.
    if (!userDict) {
        userDict = [[NSMutableDictionary alloc] init];
    }
    //设置属性值
    [userDict setObject:dictionary forKey:nickName];
    //写入文件
    [userDict writeToFile:plistPath atomically:YES];
}

//注意：如果想每次都替换数据，把上边的[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath]改成：[[NSMutableDictionary alloc] init]，if语句三行代码去掉即可


//2.读取plist（代码创建的plist文件）
- (NSMutableDictionary *)getPlistDictionary:(NSString *)nickName
{
//    NSString *plistPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"chatRoom.plist"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@.plist", documentsDirectory, nickName];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc ]initWithContentsOfFile:plistPath];
    return userDict;
    //userDict[nickName]就是上边方法存入的字典,取出来就可以进行相应的赋值操作啦
}

//替换
- (void)replacePlist:(NSDictionary *)dictionary NickName:(NSString *)nickName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *extention = @"mp4";
//    NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
    NSString  *plistPath = [NSString stringWithFormat:@"%@/%@.plist", documentsDirectory, nickName];
    NSMutableDictionary *userDict = [[NSMutableDictionary alloc] init];
//    //下边if判断很重要，不然会写入失败.
//    if (!userDict) {
//        userDict = [[NSMutableDictionary alloc] init];
//    }
    //设置属性值
    [userDict setDictionary:dictionary];
    //写入文件
    [userDict writeToFile:plistPath atomically:YES];
}

@end
