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

@end

NS_ASSUME_NONNULL_END
