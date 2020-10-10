//
//  RecourceDownLoadTool.h
//  Aisport
//
//  Created by Apple on 2020/12/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecourceDownLoadTool : NSObject

//- (AFURLSessionManager *)manager;

- (void)goToDownloadResourceWith:(NSMutableArray *)downLoadModels AndSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn andProgress:(serverProgressFn)progressFn;

- (void)cancleDownLoad;

@end

NS_ASSUME_NONNULL_END
