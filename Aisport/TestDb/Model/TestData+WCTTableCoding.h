//
//  TestData+WCTTableCoding.h
//  Aisport
//
//  Created by yans on 2020/10/29.
//

#import "TestData.h"
#import <WCDB/WCDB.h>


@interface TestData (WCTTableCoding) <WCTTableCoding>

WCDB_PROPERTY(wcdbid);
WCDB_PROPERTY(userId);
WCDB_PROPERTY(userName);
WCDB_PROPERTY(logs);
WCDB_PROPERTY(mark);

@end
