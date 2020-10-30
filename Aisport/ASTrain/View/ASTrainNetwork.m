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
    [[ASTrainNetwork share] AFPOSTHTTPHeadTNetworkWithUrl:@"ai/videoplayrecord/record" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)checkVideoPlayResportWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETHeadTNetworkWithUrl:@"ai/videoplayrecord/report" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)generateQrCodWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[ASTrainNetwork share] AFGETResponseHeadTNetworkWithUrl:@"ai/qrCode/generateQrCode" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

@end
