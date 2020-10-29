//
//  TestLog+WCTTableCoding.h
//  Aisport
//
//  Created by yans on 2020/10/29.
//

#import <WCDB/WCDB.h>
#import "TestLog.h"

@interface TestLog (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(wcdbid);
WCDB_PROPERTY(createDate);
WCDB_PROPERTY(content);

@end
