//
//  ASTrainSearchNetwork.h
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import "CommonNetworkManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASTrainSearchNetwork : CommonNetworkManager

#pragma mark - 获取热门搜索
+ (void)getHotSearch:(NSMutableDictionary * __nullable)body
        AndSuccessFn:(serverSuccessFn)successFn
         andFailerFn:(serverFailureFn)failerFn;

#pragma mark - 关键字搜索
+ (void)keyWordSearch:(NSMutableDictionary *)body
         AndSuccessFn:(serverSuccessFn)successFn
          andFailerFn:(serverFailureFn)failerFn;


@end

NS_ASSUME_NONNULL_END
