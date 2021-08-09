//
//  TestDataService.m
//  Aisport
//
//  Created by andyccc on 2020/10/29.
//

#import "TestDataService.h"
#import "TestData+WCTTableCoding.h"
#import "TestLog+WCTTableCoding.h"
#import "WCDBTableBase+WCDBService.h"

@implementation TestDataService

+ (void)create
{
    {
        TestData *testData = [[TestData alloc] init];
        testData.userId = 1;
        testData.userName = @"小李子1";
        
        NSMutableArray<TestLog *> *logs = [NSMutableArray array];
        {
            TestLog *log  = [[TestLog alloc] init];
            log.createDate = [[NSDate date] timeIntervalSince1970];
            log.content = @"登录";
            [logs addObject:log];
        }
        
        {
            TestLog *log  = [[TestLog alloc] init];
            log.createDate = [[NSDate date] timeIntervalSince1970];
            log.content = @"注册";
            [logs addObject:log];
        }
        
        testData.logs = logs;
        
        BOOL ret = [TestData insertObject:testData];
        
        NSLog(@"create ret : %d", ret);
    }
    
    {
        TestData *testData = [[TestData alloc] init];
        testData.userId = 2;
        testData.userName = @"小李子2";
        
        NSMutableArray<TestLog *> *logs = [NSMutableArray array];
        {
            TestLog *log  = [[TestLog alloc] init];
            log.createDate = [[NSDate date] timeIntervalSince1970];
            log.content = @"登录";
            [logs addObject:log];
        }
        
        {
            TestLog *log  = [[TestLog alloc] init];
            log.createDate = [[NSDate date] timeIntervalSince1970];
            log.content = @"注册";
            [logs addObject:log];
        }
        
        testData.logs = logs;
        
        BOOL ret = [TestData insertObject:testData];
        
        NSLog(@"create ret : %d", ret);
    }
    
}

+ (void)query
{
    NSString *userName = @"小李子";
    int userId = 1;
    
    
    WCTCondition condition = nil;
    condition = (1 == 1);
    if (userName) {
        condition = condition && TestData.userName == userName;
    }

    if (userId > 0) {
        condition = condition || TestData.userId == userId;
    }
    
    NSArray *objs = [TestData getObjectsWhere:condition];

    if (objs) {
        
        NSLog(@"query objs : %@", objs);
        
    }
    
}

+ (void)update
{
    int userId = 2;

    WCTCondition condition = nil;
    condition = (1 == 1);
    if (userId > 0) {
        condition = condition && TestData.userId == userId;
    }

    
    TestData *testData = [TestData getOneObjectWhere:condition];
    if (testData) {
        BOOL ret = [TestData runWithTransactionBlock:^BOOL(WCTDatabase *wcdb) {
            testData.mark = @"tsetes";
            return [testData updateRowsOnProperty:TestData.mark where:condition];
        }];
        
        NSLog(@"update ret : %d", ret);
    }
}

+ (void)delete
{
    int userId = 2;
    
    WCTCondition condition = nil;
    condition = (1 == 1);
    if (userId > 0) {
        condition = condition && TestData.userId == userId;
    }
    
    BOOL ret =[TestData runWithTransactionBlock:^BOOL(WCTDatabase *wcdb) {
        return [TestData deleteObjectsWhere:condition];
    }];
    
    NSLog(@"delete ret : %d", ret);
}

+ (void)deleteAll
{
    BOOL ret =[TestData runWithTransactionBlock:^BOOL(WCTDatabase *wcdb) {
        return [TestData deleteAllObjects];
    }];
    
    NSLog(@"deleteAll ret : %d", ret);
}

+ (void)startTest
{
    [self deleteAll];
    
    [self create];
    [self update];
    [self query];
    [self delete];
    
    [self deleteAll];
}

#if DEBUG
+ (void)load
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [TestDataService startTest];
       
        
        
    });
}
#endif

@end
