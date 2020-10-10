//
//  HomeNetworkManager.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "CommonNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeNetworkManager : CommonNetworkManager

+ (void)getVideosWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)getActivityWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)getRankingListWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)getRecentlyWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

@end

NS_ASSUME_NONNULL_END
