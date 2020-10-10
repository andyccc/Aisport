//
//  HomeNetworkManager.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "HomeNetworkManager.h"

@implementation HomeNetworkManager

+ (void)getVideosWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[HomeNetworkManager share] AFGETHeadTNetworkWithUrl:@"ai/video/listVideoByTag" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+ (void)getActivityWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[HomeNetworkManager share] AFGETHeadTNetworkWithUrl:@"ai/activity/getActivity" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

// 排行榜
+ (void)getRankingListWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[HomeNetworkManager share] AFGETHeadTNetworkWithUrl:@"ai/rank" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

// 近期上新
+ (void)getRecentlyWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[HomeNetworkManager share] AFGETHeadTNetworkWithUrl:@"ai/video/recently" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}


@end
