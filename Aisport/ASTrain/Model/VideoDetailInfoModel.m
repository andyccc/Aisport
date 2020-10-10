//
//  VideoDetailInfoModel.m
//  Aisport
//
//  Created by 申公安 on 2020/12/27.
//

#import "VideoDetailInfoModel.h"

@implementation VideoDetailInfoModel

- (NSString *)strengthStr
{
    if (self.strength.intValue == 1) {
        return @"低";
    } else if (self.strength.intValue == 2) {
        return @"中";
    } else if (self.strength.intValue == 3) {
        return @"高";
    }
    return @"低";
}

- (NSString *)leaveStr
{
    if (self.lever.intValue == 1) {
        return @"简单";
    } else if (self.lever.intValue == 2) {
        return @"中等";
    } else if (self.lever.intValue == 3) {
        return @"困难";
    }
    return @"简单";
}


@end
