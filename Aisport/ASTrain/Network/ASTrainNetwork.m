//
//  ASTrainNetwork.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "ASTrainNetwork.h"

@implementation ASTrainNetwork

+(void)getHomeCourseWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/course/page" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)getByCourseCodeDetailWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/course/getByCourseCode" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)postCollectSwitchCourseWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFPOSTHTTPHeadTNetworkWithUrl:@"ai/course/collectSwitch" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)addVideoPlayRecordWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFPOSTBodyHeadTNetworkWithUrl:@"ai/videoplayrecord/record" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)checkVideoPlayResportWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/videoplayrecord/report" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)generateQrCodWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETResponseHeadTNetworkWithUrl:@"ai/qrCode/generateQrCode" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//查询嗨动精选
+(void)getRecommendWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETNetworkWithUrl:@"ai/video/recommend" andBody:body andSuccess:successFn andFailer:failerFn];
//    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/recommend" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//查询嗨动精选 2020-12-27
+(void)getRecommend2With:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETNetworkWithUrl:@"ai/video/featured" andBody:body andSuccess:successFn andFailer:failerFn];
//    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/recommend" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}


//首页banner管理分页查询
+(void)getHomeBannerWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETNetworkWithUrl:@"ai/banner/page" andBody:body andSuccess:successFn andFailer:failerFn];
}

//首页分页查询
//+(void)getHomeVideoPageWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
//{
//    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/page" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
//}


////我的合集-通过视频code查询视频信息
//+(void)getVideoByCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
//{
//    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/getVideoByCode" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
//}

//我的合集-查询视频详情
+(void)getVideoInfoWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/getVideoInfo" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//-------------------------------------------------------------------------------
//首页分页查询
+(void)getHomeVideoPageWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/getVideoByTag" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//大家都在跳
+(void)getHomeWatchingVideoPageWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETNetworkWithUrl:@"ai/video/watching" andBody:body andSuccess:successFn andFailer:failerFn];
//    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/watching" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//视频的缓存数据
+(void)getVideomodelscoreWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFPOSTBodyHeadTNetworkWithUrl:@"ai/modelscore" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

//通过视频配置id查询视频信息集合
+(void)getVideoByVideoConfigIdWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/video/getVideoByVideoConfigId" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

@end
