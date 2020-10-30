//
//  CommonNetworkManager.h
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import <Foundation/Foundation.h>

#define ResponseSuccess [[responseBefore objectForKey:@"code"] intValue] == 0
#define ResponseNoData [[responseBefore objectForKey:@"msg"] intValue] == -4

NS_ASSUME_NONNULL_BEGIN

typedef void (^serverSuccessFn)(id responseAfter, id responseBefore);
typedef void (^serverFailureFn)(NSError* error);

typedef void (^serverProgressFn)(double value);

@interface CommonNetworkManager : NSObject

+(CommonNetworkManager *)share;

-(void)AFGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFGETResponseHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

//token
-(void)AFGETHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFGETHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTBodyTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

//token
-(void)AFPOSTBodyHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTBodyHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

//AFHTTPRequestSerializer格式参数，带token
-(void)AFPOSTHTTPHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFUPIMAGENetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andData:(NSData*)data andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

+ (void)upLoadingUTmpPicWithImage:(UIImage *)image
                     SuccessBlock:(void (^)(BOOL Success,NSDictionary *resultDictionary))successBlock;

- (void)postWithUrl:(NSString *)url body:(NSData *)body  success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

#pragma mark - 6.1 下载进度
- (void)getVideoByCourseWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn andProgress:(serverProgressFn)progressFn;

@end

NS_ASSUME_NONNULL_END
