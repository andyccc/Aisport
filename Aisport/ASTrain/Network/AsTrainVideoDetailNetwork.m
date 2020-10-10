//
//  AsTrainVideoDetailNetwork.m
//  Aisport
//
//  Created by 申公安 on 2020/12/27.
//

#import "AsTrainVideoDetailNetwork.h"

@implementation AsTrainVideoDetailNetwork

#pragma mark - 获取视频信息
+ (void)getVideoInfo:(NSMutableDictionary * __nullable)body
        AndSuccessFn:(serverSuccessFn)successFn
         andFailerFn:(serverFailureFn)failerFn
{
    [[AsTrainVideoDetailNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/getVideoInfo" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

#pragma mark - 获取视频详情排行榜列表
+ (void)getVideoDetailRank:(NSMutableDictionary * __nullable)body
        AndSuccessFn:(serverSuccessFn)successFn
         andFailerFn:(serverFailureFn)failerFn
{
    [[AsTrainVideoDetailNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/getVideoRank" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

#pragma mark - 获取视频详情成长列表
+ (void)getVideoDetailMyGrowing:(NSMutableDictionary * __nullable)body
        AndSuccessFn:(serverSuccessFn)successFn
         andFailerFn:(serverFailureFn)failerFn
{
    [[AsTrainVideoDetailNetwork share] AFGETHeadTNetworkWithUrl:@"ai/mygrowing/list" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

#pragma mark - 收藏
+ (void)collectionVideo:(NSString *)videoCode
           AndSuccessFn:(serverSuccessFn)successFn
            andFailerFn:(serverFailureFn)failerFn
{
    NSString *url = [NSString stringWithFormat:@"ai/video/collect?videoCode=%@",videoCode];
    [[AsTrainVideoDetailNetwork share] AFPOSTBodyHeadTNetworkWithUrl:url HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:nil andSuccess:successFn andFailer:failerFn];
}

@end
