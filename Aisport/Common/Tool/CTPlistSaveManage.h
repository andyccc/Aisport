//
//  CTPlistSaveManage.h
//  Aisport
//
//  Created by Apple on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTPlistSaveManage : NSObject

+ (instancetype)shareManage;

- (void)insertToPlist:(NSDictionary *)dictionary nickName:(NSString *)nickName;

//2.读取plist（代码创建的plist文件）
- (NSMutableDictionary *)getPlistDictionary:(NSString *)nickName;

//替换
- (void)replacePlist:(NSDictionary *)dictionary NickName:(NSString *)nickName;

@end

NS_ASSUME_NONNULL_END
