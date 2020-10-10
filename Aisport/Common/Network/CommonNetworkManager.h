//
//  CommonNetworkManager.h
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import <Foundation/Foundation.h>
#import <SSZipArchive.h>
#import "DownLoadModel.h"

#define Host_Url  @"https://dev-gateway.hidbb.com/"
//#define Host_Url  @"http://pamir-gateway:9999/"
//#define Host_Url  @"https://uat-gateway.hidbb.com/"   //预发
//#define Host_Url  @"https://gateway.hidbb.com/" //线上

//H5界面主地址
//#define Host_Url_Web @"https://uat-aih5.hidbb.com/"
//#define Host_Url_Web @"https://ai-h5.local.hidbb.com/"
//#define Host_Url_Web @"https://uat-aih5.hidbb.com/"  //预发
#define Host_Url_Web @"https://ai-h5.hidbb.com/"  //线上

#define appVersion_Code  @"1.31"

#define ResponseSuccess [[responseBefore objectForKey:@"code"] intValue] == 0
#define ResponseNoData [[responseBefore objectForKey:@"msg"] intValue] == -4

NS_ASSUME_NONNULL_BEGIN

typedef void (^serverSuccessFn)(id responseAfter, id responseBefore);
typedef void (^serverFailureFn)(NSError* error);

typedef void (^serverProgressFn)(double value);

@interface CommonNetworkManager : NSObject<SSZipArchiveDelegate>

+(CommonNetworkManager *)share;

-(void)AFDELETEHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPUTHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;


-(void)AFGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFGETAfterBodyHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFGETResponseHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

//token
-(void)AFGETHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFGETHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

//post 直接拼参数
-(void)AFPOSTdirectBodyNetworkWithUrl:(NSString *)url AndIsLogin:(BOOL)isLogin andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTBodyTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

//token
-(void)AFPOSTBodyHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFPOSTBodyHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

//AFHTTPRequestSerializer格式参数，带token
-(void)AFPOSTHTTPHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)AFUPIMAGENetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andData:(NSData*)data andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

-(void)OtherGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn;

+ (void)upLoadingUTmpPicWithImage:(UIImage *)image
                     SuccessBlock:(void (^)(BOOL Success,NSDictionary *resultDictionary))successBlock;

- (void)postWithUrl:(NSString *)url body:(NSData *)body  success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure;


#pragma mark - 6.1 下载进度
- (void)getVideoByCourseWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn andProgress:(serverProgressFn)progressFn;

- (void)goToDownloadResourceWith:(DownLoadModel *)downLoadModel WithCourseId:(NSString *)courseId AndSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn andProgress:(serverProgressFn)progressFn;

- (void)cancleDownLoad;

- (void)StopDownLoad;

@end

NS_ASSUME_NONNULL_END
