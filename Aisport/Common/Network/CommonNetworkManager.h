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

@interface CommonNetworkManager : NSObject

+(CommonNetworkManager *)share;

-(void)AFGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFUPIMAGENetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andData:(NSData*)data andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

+ (void)upLoadingUTmpPicWithImage:(UIImage *)image
                     SuccessBlock:(void (^)(BOOL Success,NSDictionary *resultDictionary))successBlock;

- (void)postWithUrl:(NSString *)url body:(NSData *)body  success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
