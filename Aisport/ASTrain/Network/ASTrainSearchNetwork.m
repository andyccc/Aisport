//
//  ASTrainSearchNetwork.m
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import "ASTrainSearchNetwork.h"

@implementation ASTrainSearchNetwork

+(void)getHotSearch:(NSMutableDictionary * __nullable)body
       AndSuccessFn:(serverSuccessFn)successFn
        andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainSearchNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/getHot" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

#pragma mark - 关键字搜索
+ (void)keyWordSearch:(NSMutableDictionary *)body
         AndSuccessFn:(serverSuccessFn)successFn
          andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainSearchNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/search" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

@end
