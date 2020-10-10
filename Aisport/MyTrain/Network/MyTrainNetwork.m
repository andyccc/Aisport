//
//  MyTrainNetwork.m
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import "MyTrainNetwork.h"

@implementation MyTrainNetwork

//我的合集-今日完成
+(void)getMyTrainTodayTrainingeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/videoplayrecord/todayTraining" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//我的合集-我的合集
+(void)getMyTrainWholePartWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/compcollect/my" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//我的合集-查询合集详情(通过id查询)
+(void)getMyTrainWholeDetailWith:(NSString *)url  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFGETAfterBodyHeadTNetworkWithUrl:url HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:nil andSuccess:successFn andFailer:failerFn];
}

//我的合集-上次播放
+(void)getLastPlayInfoWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/videoplayrecord/lastPlayInfo" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}



//我的合集-收藏合集(意思是添加)
+(void)addCompilationsmanagerWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/compcollect/collect" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//--------------------------------------------------------------------------------------
//我的-视频收藏列表
+(void)getMyVideoCollectListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/my/videoCollectList" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//我的-最近播放列表
+(void)getMyRecentlyPlayedListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/my/recentlyPlayedList" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//我的-我的数据
+(void)getmyDataWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFPOSTHTTPHeadTNetworkWithUrl:@"ai/my/myData" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//我的-我的数据
+(void)getMyCollectInfoWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MyTrainNetwork share] AFPOSTHTTPHeadTNetworkWithUrl:@"ai/my/myCollect" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}




@end
