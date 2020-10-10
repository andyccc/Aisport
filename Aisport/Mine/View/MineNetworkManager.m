//
//  MineNetworkManager.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "MineNetworkManager.h"

@implementation MineNetworkManager

//我的收获地址
+ (void)getMyAddressListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MineNetworkManager share] AFGETHeadTNetworkWithUrl:@"ai/address/getList" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

// 添加地址
+ (void)createAddressWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MineNetworkManager share] AFPOSTBodyHeadTNetworkWithUrl:@"ai/address" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

// 更新地址
+ (void)updateAddressWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MineNetworkManager share] AFPUTHeadTNetworkWithUrl:@"ai/address" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

// 删除地址
+ (void)deleteAddressWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    NSString *dataId = body[@"id"];
    NSString *url = [NSString stringWithFormat:@"ai/address/%@", dataId];
    [[MineNetworkManager share] AFDELETEHeadTNetworkWithUrl:url HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

/// pid : 0
+ (void)getRegionListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MineNetworkManager share] AFGETHeadTNetworkWithUrl:@"ai/region/list" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

// 邀请码
+ (void)inviteCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    NSString *cipher = body[@"cipher"];
    NSString *url = [NSString stringWithFormat:@"ai/koc/kocCipher?cipher=%@", cipher];
    
    [[MineNetworkManager share] AFPOSTBodyHeadTNetworkWithUrl:url HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+ (void)getMyBagListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MineNetworkManager share] AFGETHeadTNetworkWithUrl:@"ai/backpack" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+ (void)useMyBagWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    NSNumber *propsId = body[@"propsId"];
    NSString *url = [NSString stringWithFormat:@"ai/backpack/use?propsId=%@",propsId];
    
    [[MineNetworkManager share] AFPOSTBodyHeadTNetworkWithUrl:url HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:nil andSuccess:successFn andFailer:failerFn];
}


// 反馈建议
+ (void)feedContentWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[MineNetworkManager share] AFPOSTBodyHeadTNetworkWithUrl:@"ai/feedback" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}



@end
