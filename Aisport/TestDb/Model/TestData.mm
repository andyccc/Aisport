//
//  TestData.m
//  Aisport
//
//  Created by andyccc on 2020/10/29.
//

#import "TestData+WCTTableCoding.h"

AUTO_REGISTER_TABLE_CLASS_LAZY(TestData);

@implementation TestData

- (BOOL)isAutoIncrement
{
    return YES; //是否自增 必须要有 否则 deleteObject 方法无法成功调用
}


WCDB_IMPLEMENTATION(TestData);
WCDB_PRIMARY_AUTO_INCREMENT(TestData, wcdbid); // 主键自增
WCDB_INDEX(TestData, "_index", wcdbid);

WCDB_SYNTHESIZE(TestData, wcdbid);
WCDB_SYNTHESIZE(TestData, userId);
WCDB_SYNTHESIZE(TestData, userName);
WCDB_SYNTHESIZE(TestData, logs);
WCDB_SYNTHESIZE(TestData, mark);

@end
