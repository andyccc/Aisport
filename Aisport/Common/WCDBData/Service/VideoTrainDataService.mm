//
//  VideoTrainDataService.m
//  Aisport
//
//  Created by Apple on 2020/11/30.
//

#import "VideoTrainDataService.h"
#import "VideoTrainData+WCTTableCoding.h"
#import "ActionTrainData+WCTTableCoding.h"
#import "WCDBTableBase+WCDBService.h"

@implementation VideoTrainDataService

+(void)setDBName:(NSString *)name
{
    [WCDBService setDBName:name];
}

+ (void)insertObjectWithVideoData:(VideoTrainData *)videoData
{
    [VideoTrainData insertObject:videoData];
}

+ (void)insertObjectWithTrainData:(ActionTrainData *)trainData
{
    [ActionTrainData insertObject:trainData];
}


+ (NSArray *)queryWithVideoCode:(NSString *)videoCode
{
//    NSString *userName = @"小李子";
//    int userId = 1;
    
    
    WCTCondition condition = nil;
    condition = (1 == 1);
    if (videoCode) {
        condition = condition && VideoTrainData.videoCode == videoCode;
    }

//    if (userId > 0) {
//        condition = condition || TestData.userId == userId;
//    }
    
    NSArray *objs = [VideoTrainData getObjectsWhere:condition];

    if (objs) {
        
//        NSLog(@"query objs : %@", objs);
        
    }
    return objs;
    
}

+ (void)updateUploadStateWithVideoCode:(NSString *)videoCode
{
//    int userId = 2;

    WCTCondition condition = nil;
    condition = (1 == 1);
    if (videoCode) {
        condition = condition && VideoTrainData.videoCode == videoCode;
    }

    
    VideoTrainData *trainData = [VideoTrainData getOneObjectWhere:condition];
    if (trainData) {
        BOOL ret = [VideoTrainData runWithTransactionBlock:^BOOL(WCTDatabase *wcdb) {
            trainData.isUpload = 1;
            return [trainData updateRowsOnProperty:VideoTrainData.isUpload where:condition];
        }];
        
        NSLog(@"update ret : %d", ret);
    }
}

+ (void)deleteWithVideoCode:(NSString *)videoCode
{
//    int userId = 2;
    
    WCTCondition condition = nil;
    condition = (1 == 1);
    if (videoCode) {
        condition = condition && VideoTrainData.videoCode == videoCode;
    }
    
    BOOL ret =[VideoTrainData runWithTransactionBlock:^BOOL(WCTDatabase *wcdb) {
        return [VideoTrainData deleteObjectsWhere:condition];
    }];
    
    NSLog(@"delete ret : %d", ret);
}

//+ (void)deleteAll
//{
//    BOOL ret =[TestData runWithTransactionBlock:^BOOL(WCTDatabase *wcdb) {
//        return [TestData deleteAllObjects];
//    }];
//    
//    NSLog(@"deleteAll ret : %d", ret);
//}

@end
