//
//  VideoTrainData+WCTTableCoding.h
//  Aisport
//
//  Created by Apple on 2020/11/30.
//

#import "VideoTrainData.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoTrainData (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(wcdbid);
WCDB_PROPERTY(videoCode);
WCDB_PROPERTY(name);
WCDB_PROPERTY(actionScoreLogs);
WCDB_PROPERTY(startTime);
WCDB_PROPERTY(endTime);
WCDB_PROPERTY(isUpload);


@end

NS_ASSUME_NONNULL_END
