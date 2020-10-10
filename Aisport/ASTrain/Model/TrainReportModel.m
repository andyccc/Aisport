//
//  TrainReportModel.m
//  Aisport
//
//  Created by Apple on 2020/11/4.
//

#import "TrainReportModel.h"

@implementation TrainReportModel

- (void)setCompleteness:(NSString<Optional> *)completeness
{
    //0.未完成(视频中途退出)  1.一般  2.良好  3.极佳
    if ([StringForId(completeness) isEqual:@"0"]) {
        _completenessStr = @"未完成";
    }else if ([StringForId(completeness) isEqual:@"1"]){
        _completenessStr = @"一般";
    }else if ([StringForId(completeness) isEqual:@"2"]){
        _completenessStr = @"良好";
    }else if ([StringForId(completeness) isEqual:@"3"]){
        _completenessStr = @"极佳";
    }
}

@end
