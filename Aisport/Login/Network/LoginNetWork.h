//
//  LoginNetWork.h
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "CommonNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginNetWork : CommonNetworkManager

+(void)checkUserIdWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getGetCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getPostCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)registerUserWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)loginUserWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)completeUserInfoWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)fixUserInfoWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getUserInfoWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//通过微信获取信息
+(void)getWXTokenWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getWXUserInfoWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getWXLoginWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getWXbindUnionIdWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)postSaveDeviceWith:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getCreatePageSessionWith:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getPageEventWith:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+(void)getAppVersion;

@end

NS_ASSUME_NONNULL_END
