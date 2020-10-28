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

@end

NS_ASSUME_NONNULL_END
