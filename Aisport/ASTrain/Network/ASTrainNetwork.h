//
//  ASTrainNetwork.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "CommonNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASTrainNetwork : CommonNetworkManager

+(void)getHomeCourseWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getByCourseCodeDetailWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)postCollectSwitchCourseWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)addVideoPlayRecordWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)checkVideoPlayResportWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)generateQrCodWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//首页查询合集推荐
+(void)getRecommendWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//首页banner管理分页查询
+(void)getHomeBannerWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//首页分页查询
//+(void)getHomeVideoPageWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

////我的合集-通过视频code查询视频信息
//+(void)getVideoByCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的合集-查询视频详情
+(void)getVideoInfoWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//-------------------------------------------------------------------------------
//首页分页查询
+(void)getHomeVideoPageWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//大家都在跳
+(void)getHomeWatchingVideoPageWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//视频的缓存数据
+(void)getVideomodelscoreWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//通过视频配置id查询视频信息集合
+(void)getVideoByVideoConfigIdWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getRecommend2With:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

@end

NS_ASSUME_NONNULL_END
