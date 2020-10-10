//
//  VideoTrainData.m
//  Aisport
//
//  Created by Apple on 2020/11/30.
//

#import "VideoTrainData+WCTTableCoding.h"

AUTO_REGISTER_TABLE_CLASS_LAZY(VideoTrainData);


@implementation VideoTrainData

- (BOOL)isAutoIncrement
{
    return YES; //是否自增 必须要有 否则 deleteObject 方法无法成功调用
}


WCDB_IMPLEMENTATION(VideoTrainData);
WCDB_PRIMARY_AUTO_INCREMENT(VideoTrainData, wcdbid);
WCDB_INDEX(VideoTrainData, "_index", wcdbid);

WCDB_SYNTHESIZE(VideoTrainData, wcdbid);
WCDB_SYNTHESIZE(VideoTrainData, videoCode);
WCDB_SYNTHESIZE(VideoTrainData, name);
WCDB_SYNTHESIZE(VideoTrainData, actionScoreLogs);
WCDB_SYNTHESIZE(VideoTrainData, startTime);
WCDB_SYNTHESIZE(VideoTrainData, endTime);
WCDB_SYNTHESIZE(VideoTrainData, isUpload);



@end
