//
//  LoginNetWork.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "LoginNetWork.h"

@implementation LoginNetWork

+(void)checkUserIdWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETNetworkWithUrl:@"ai/hidouserinfo/getStatus" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)getGetCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETNetworkWithUrl:@"admin/mobile/sendLogin" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)getPostCodeWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETNetworkWithUrl:@"admin/mobile/sendRegist" andBody:body andSuccess:successFn andFailer:failerFn];
}


+(void)registerUserWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFPOSTNetworkWithUrl:@"ai/hidouserinfo/register" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)loginUserWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFPOSTBodyTNetworkWithUrl:@"auth/mobile/token/sms" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)completeUserInfoWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
//    [[LoginNetWork share] AFPOSTBodyTNetworkWithUrl:@"ai/hidouserinfo/complete" andBody:body andSuccess:successFn andFailer:failerFn];
    
    [[LoginNetWork share] AFPOSTBodyHeadTNetworkWithUrl:@"ai/hidouserinfo/complete" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];

}

+(void)fixUserInfoWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    
    [[LoginNetWork share] AFPOSTBodyHeadTNetworkWithUrl:@"ai/hidouserinfo/editInfo" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];

}

+(void)getUserInfoWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETHeadTNetworkWithUrl:@"ai/hidouserinfo/getInfo" HeaderToken:[GVUserDefaults standardUserDefaults].access_token andBody:body andSuccess:successFn andFailer:failerFn];
}

+ (void)smsCodeNetworkWithValue:(NSString *)value
{
    // 1.创建url
        // 请求一个网页
    NSString *urlString = [NSString stringWithFormat:@"http://dev-gateway.hidbb.com/admin/mobile/%@",value];

    // 一些特殊字符编码
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:urlString];
        
        // 2.创建请求 并：设置缓存策略为每次都从网络加载 超时时间30秒
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];

        // 3.采用苹果提供的共享session
        NSURLSession *sharedSession = [NSURLSession sharedSession];
        
        // 4.由系统直接返回一个dataTask任务
        NSURLSessionDataTask *dataTask = [sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 网络请求完成之后就会执行，NSURLSession自动实现多线程
            NSLog(@"%@",[NSThread currentThread]);
            if (data && (error == nil)) {
                // 网络访问成功
                NSLog(@"data=%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            } else {
                // 网络访问失败
                NSLog(@"error=%@",error);
            }
        }];
        
        // 5.每一个任务默认都是挂起的，需要调用 resume 方法
        [dataTask resume];
    
}

@end
