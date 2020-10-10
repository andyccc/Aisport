//
//  ActionTrainData+WCTTableCoding.h
//  Aisport
//
//  Created by Apple on 2020/11/30.
//

#import "ActionTrainData.h"
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActionTrainData (WCTTableCoding)<WCTTableCoding>

WCDB_PROPERTY(wcdbid);
WCDB_PROPERTY(uid)
WCDB_PROPERTY(time);
WCDB_PROPERTY(createTime);
WCDB_PROPERTY(modelScore);
WCDB_PROPERTY(keyFrameId);
WCDB_PROPERTY(videoCode);
WCDB_PROPERTY(json);



@end

NS_ASSUME_NONNULL_END
