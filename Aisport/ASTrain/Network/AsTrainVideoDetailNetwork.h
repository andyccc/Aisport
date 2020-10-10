//
//  AsTrainVideoDetailNetwork.h
//  Aisport
//
//  Created by 申公安 on 2020/12/27.
//

#import "CommonNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AsTrainVideoDetailNetwork : CommonNetworkManager

#pragma mark - 获取视频信息
+ (void)getVideoInfo:(NSMutableDictionary * __nullable)body
        AndSuccessFn:(serverSuccessFn)successFn
         andFailerFn:(serverFailureFn)failerFn;

#pragma mark - 获取视频详情排行榜列表
+ (void)getVideoDetailRank:(NSMutableDictionary * __nullable)body
              AndSuccessFn:(serverSuccessFn)successFn
               andFailerFn:(serverFailureFn)failerFn;

#pragma mark - 获取视频详情成长列表
+ (void)getVideoDetailMyGrowing:(NSMutableDictionary * __nullable)body
                   AndSuccessFn:(serverSuccessFn)successFn
                    andFailerFn:(serverFailureFn)failerFn;

#pragma mark - 收藏
+ (void)collectionVideo:(NSString *)videoCode
           AndSuccessFn:(serverSuccessFn)successFn
            andFailerFn:(serverFailureFn)failerFn;

@end

NS_ASSUME_NONNULL_END
