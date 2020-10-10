//
//  TrainVideoModel.m
//  Aisport
//
//  Created by Apple on 2020/11/12.
//

#import "TrainVideoModel.h"

@implementation TrainVideoModel

- (void)setLever:(NSString<Optional> *)lever
{
    _lever = lever;
    if ([StringForId(lever) isEqual:@"1"]) {
        _leverVStr = @"入门";
    }else if ([StringForId(lever) isEqual:@"2"]){
        _leverVStr = @"进阶";
    }else if ([StringForId(lever) isEqual:@"3"]){
        _leverVStr = @"专业";
    }else if ([StringForId(lever) isEqual:@"4"]){
        _leverVStr = @"极限";
    }
}

@end
