//
//  MyTrainNetwork.h
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import "CommonNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTrainNetwork : CommonNetworkManager

//我的合集-今日完成
+(void)getMyTrainTodayTrainingeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的合集-我的合集
+(void)getMyTrainWholePartWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的合集-查询合集详情
+(void)getMyTrainWholeDetailWith:(NSString *)url  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的合集-上次播放
+(void)getLastPlayInfoWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的合集-添加合集
+(void)addCompilationsmanagerWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//--------------------------------------------------------------------------------------
//我的-视频收藏列表
+(void)getMyVideoCollectListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的-最近播放列表
+(void)getMyRecentlyPlayedListWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的-我的数据
+(void)getmyDataWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

//我的-我的战绩数据 + 收藏统计
+(void)getMyCollectInfoWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn;

@end

NS_ASSUME_NONNULL_END
