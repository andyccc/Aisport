//
//  MineNetworkManager.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "CommonNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineNetworkManager : CommonNetworkManager


+(void)getMyAddressListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

// 添加地址
+ (void)createAddressWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)updateAddressWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;


+ (void)deleteAddressWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)getRegionListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)inviteCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)getMyBagListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)useMyBagWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

+ (void)feedContentWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

@end

NS_ASSUME_NONNULL_END
