//
//  CommonNetworkManager.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "CommonNetworkManager.h"
#import "AFNetworking.h"
#import "IphoneDevice.h"
#import "SystemMethods.h"
#import "Aisport-Swift.h"

@implementation CommonNetworkManager{
    AFHTTPSessionManager *manager;
    NSMutableDictionary *sizeDic;
    long long totalSize;
    long long number;
    
    NSURLSessionDownloadTask *videoTask;
    NSURLSessionDownloadTask *imagesTask;
    /** 文件句柄对象 */
    NSFileHandle *videofileHandle;
    NSFileHandle *imagesfileHandle;
}

+(CommonNetworkManager *)share{
    static CommonNetworkManager *obj = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [[CommonNetworkManager alloc] init];
    });
    
    return obj;
}

-(id)init{
    self = [super init];
    if (self != nil) {
        manager = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:Host_Url]];
        
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
//        manager.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.requestSerializer.stringEncoding = kCFStringEncodingUTF8;
        
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:[IphoneDevice deviceVersion] forHTTPHeaderField:@"deviceType"];
        [manager.requestSerializer setValue:[SystemMethods SystemGetSoftVersion] forHTTPHeaderField:@"deviceVersion"];
        [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"loginTerminalType"];
        [manager.requestSerializer setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"deviceId"];
        [manager.requestSerializer setValue:@"UnKnowMacIdAfteriOS7.0" forHTTPHeaderField:@"macUrl"];
        [manager.requestSerializer setValue:[IphoneDevice getTelephonyNetworkInfo] forHTTPHeaderField:@"operator"];
        
        
    }
    return self;
}


-(void)LogSuccessResponse:(id)responseObject
         successFn:(serverSuccessFn)successFn
{
//    DebugLog(@"---rop is--- %@",responseObject);
//    NSLog(@"---rop is--- %@",responseObject);
    
    if([[responseObject objectForKey:@"code"] intValue] == 0)
    {
//        [SVProgressHUD dismiss];
    }else if([[responseObject objectForKey:@"code"] intValue] == 1)
    {
        [SVProgressHUD dismiss];
//        [SVProgressHUD dismiss];
    }else{
        [SVProgressHUD dismiss];
    }

    successFn([responseObject objectForKey:@"data"],responseObject);
    
}

-(void)LogFailerResponse:(NSError*)error
                failerFn:(serverFailureFn)failerFn
{
    if ([StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]) {
        [SVProgressHUD dismiss];
        failerFn(error);
        return;
    }
//    DebugLog(@"---rop is--- %ld --- %@",(long)error.code,error.userInfo);
    if(error.code == -1001)
    {
        [SVProgressHUD showInfoWithStatus:@"服务器繁忙，请稍后再试"];
    }else if (error.code == -1000 || error.code == -1003 || error.code == -1004)
    {
        [SVProgressHUD showInfoWithStatus:@"服务器繁忙，请稍后再试"];
    }else if (error.code == -1009)
    {
        [SVProgressHUD showInfoWithStatus:@"似乎已断开与互联网连接，请检查网络设置"];
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"服务器繁忙，请稍后再试"];
    }
    failerFn(error);
}

-(void)AFGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
    
    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [manager GET:url parameters:body headers:headers progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
    
}

-(void)AFPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
//    [self setRequestSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",@"image/jpeg",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"body--%@,url---%@",body,url);
    
    [manager POST:url parameters:body headers:headers progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
    
//    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@/%@",Host_Url,url] parameters:body error:nil];
//    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];

}


-(void)AFGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
    
    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [manager GET:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
    
}

//直接拼参数
-(void)AFGETAfterBodyHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    if ([DatetimeOpeartion compareWithDate:[GVUserDefaults standardUserDefaults].expires_in] == 1) {
        //过期
        [self checkNetwrokTokenWithSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self AFGETAfterBodyeHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
        }];
    }else{
        [self AFGETAfterBodyeHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
    }
    
}

-(void)AFGETAfterBodyeHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:headValue forHTTPHeaderField:header];
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [manager GET:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *data = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];

}

//AFHTTPRequestSerializer格式参数
-(void)AFGETResponseHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    if ([DatetimeOpeartion compareWithDate:[GVUserDefaults standardUserDefaults].expires_in] == 1) {
        //过期
        [self checkNetwrokTokenWithSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self AFGETResponseHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
        }];
    }else{
        [self AFGETResponseHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
    }
    
}

-(void)AFGETResponseHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:headValue forHTTPHeaderField:header];
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [manager GET:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *data = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];

}
///////////

-(void)AFGETHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    
//    NSLog(@"%@",[GVUserDefaults standardUserDefaults].expires_in);
    if ([DatetimeOpeartion compareWithDate:[GVUserDefaults standardUserDefaults].expires_in] == 1) {
        //过期
        [self checkNetwrokTokenWithSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self AFGETHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
        }];
    }else{
        [self AFGETHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
    }
    
}

-(void)AFPUTHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    
    NSLog(@"%@",[GVUserDefaults standardUserDefaults].expires_in);
    if ([DatetimeOpeartion compareWithDate:[GVUserDefaults standardUserDefaults].expires_in] == 1) {
        //过期
        [self checkNetwrokTokenWithSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self AFPUTHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
        }];
    }else{
        [self AFPUTHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
    }
    
}


-(void)AFPUTHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",@"image/jpeg",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer setValue:headValue forHTTPHeaderField:header];
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [manager PUT:url parameters:body headers:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];

}


-(void)AFDELETEHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    
    NSLog(@"%@",[GVUserDefaults standardUserDefaults].expires_in);
    if ([DatetimeOpeartion compareWithDate:[GVUserDefaults standardUserDefaults].expires_in] == 1) {
        //过期
        [self checkNetwrokTokenWithSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self AFDELETEHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
        }];
    }else{
        [self AFDELETEHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
    }
    
}

-(void)AFDELETEHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",@"image/jpeg",nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [manager.requestSerializer setValue:headValue forHTTPHeaderField:header];
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [manager DELETE:url parameters:body headers:@{} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
}

-(void)AFGETHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
    
    // filter : 'Bearer (null)'
    if (header && [header isEqualToString:@"authorization"] && [headValue length] > 13) {
        [manager.requestSerializer setValue:headValue forHTTPHeaderField:header];
    }
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    
    [manager GET:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];

}


//post 直接拼参数
-(void)AFPOSTdirectBodyNetworkWithUrl:(NSString *)url AndIsLogin:(BOOL)isLogin andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
//    [self setRequestSerializer];
    NSArray * keys = [body allKeys];
    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
    for (int i = 0; i < keys.count; i++) {
        if (i == 0) {
            urlStr = [NSString stringWithFormat:@"%@?%@=%@",urlStr, keys[i], body[keys[i]]];
        }else{
            urlStr = [NSString stringWithFormat:@"%@&%@=%@",urlStr, keys[i], body[keys[i]]];
        }
    }

    if (isLogin) {
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"Basic cGFtaXI6cGFtaXI=" forHTTPHeaderField:@"Authorization"];//Basic cGFtaXI6cGFtaXI=    Basic dGVzdDp0ZXN0
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
        [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
        [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];
    }
    
    
    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"body--%@,url---%@",body,url);
    
    [manager POST:urlStr parameters:nil headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
    
//    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@/%@",Host_Url,url] parameters:body error:nil];
//    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];

}

///////

-(void)AFPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
//    [self setRequestSerializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",@"image/jpeg",nil];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/octet-stream"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];
    
    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"body--%@,url---%@",body,url);
    
    [manager POST:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
    
//    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@/%@",Host_Url,url] parameters:body error:nil];
//    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];

}

//AFHTTPRequestSerializer格式参数
-(void)AFPOSTBodyTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
//    //post 发送json格式数据的时候加上这两句。
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
//    manager.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"Basic cGFtaXI6cGFtaXI=" forHTTPHeaderField:@"Authorization"];//Basic cGFtaXI6cGFtaXI=    Basic dGVzdDp0ZXN0

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"body--%@,url---%@",body,url);
    [manager POST:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
}


//AFJSONResponseSerializer格式参数
-(void)AFPOSTBodyHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    if ([DatetimeOpeartion compareWithDate:[GVUserDefaults standardUserDefaults].expires_in] == 1) {
        //过期
        [self checkNetwrokTokenWithSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self AFPOSTBodyHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
        }];
    }else{
        [self AFPOSTBodyHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
    }
    
}

-(void)AFPOSTBodyHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"application/octet-stream", nil];
    //post 发送json格式数据的时候加上这两句。
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager.requestSerializer setValue:headValue forHTTPHeaderField:header];
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    NSLog(@"body--%@,url---%@",body,url);
    [manager POST:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
}

//AFHTTPRequestSerializer格式参数，带token
-(void)AFPOSTHTTPHeadTNetworkWithUrl:(NSString *)url HeaderToken:(NSString *)headerToken andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    if ([DatetimeOpeartion compareWithDate:[GVUserDefaults standardUserDefaults].expires_in] == 1) {
        //过期
        [self checkNetwrokTokenWithSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
            [self AFPOSTHTTPHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
        }];
    }else{
        [self AFPOSTHTTPHeadTNetworkWithUrl:url Header:@"authorization" HeaderValue:[NSString stringWithFormat:@"Bearer %@",headerToken] andBody:body andSuccess:successFn andFailer:failerFn];
    }
    
}

-(void)AFPOSTHTTPHeadTNetworkWithUrl:(NSString *)url Header:(NSString *)header HeaderValue:(NSString *)headValue andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
//    manager.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:headValue forHTTPHeaderField:header];
    
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].user_Id forHTTPHeaderField:@"User-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].page_Session_Id forHTTPHeaderField:@"Page-Session-Id"];
    [manager.requestSerializer setValue:[GVUserDefaults standardUserDefaults].uuid forHTTPHeaderField:@"Device-Id"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lld",[DatetimeOpeartion getCurrentSeconds]] forHTTPHeaderField:@"Event-Time"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    NSLog(@"body--%@,url---%@",body,url);
    [manager POST:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull uploadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
}


-(void)AFUPIMAGENetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andData:(NSData*)data andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    if([url isEqualToString:@"trade/execute_barcode_trade"])
    {
        manager.requestSerializer.timeoutInterval = 20.f;
    }else
    {
        manager.requestSerializer.timeoutInterval = 10.f;
    }
    
//    [manager.requestSerializer
//     setValue:@"application/x-www-form-urlencoded;charset=utf-8"
//     forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:[IphoneDevice deviceVersion] forHTTPHeaderField:@"deviceType"];
//    [manager.requestSerializer setValue:[SystemMethods SystemGetSoftVersion] forHTTPHeaderField:@"deviceVersion"];
//    [manager.requestSerializer setValue:@"2" forHTTPHeaderField:@"loginTerminalType"];
//    [manager.requestSerializer setValue:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forHTTPHeaderField:@"deviceId"];

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:body headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"xxx.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
    
//    [manager POST:url parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:@"file" fileName:@"xxx.jpeg" mimeType:@"image/jpeg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];

    //    [manager POST:url parameters:body headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:@"file" fileName:@"xxx.jpeg" mimeType:@"image/jpeg"];
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//        }];
    
}

-(void)OtherGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    
    AFHTTPSessionManager* otherMa = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:@""]];
    
    otherMa.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
    otherMa.requestSerializer.stringEncoding = kCFStringEncodingUTF8;
//    otherMa.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
    otherMa.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [otherMa GET:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];

}

//
//-(void)AFUPVIDEONetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andfilePath:(NSString*)filePath andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
//{
//    [self setRequestSerializer];
//
//    if([url isEqualToString:@"trade/execute_barcode_trade"])
//    {
//        manager.requestSerializer.timeoutInterval = 20.f;
//    }else
//    {
//        manager.requestSerializer.timeoutInterval = 10.f;
//    }
//
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [manager POST:url parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"xxx.mp4" mimeType:@"application/octet-stream" error:nil];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[ABNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        [[ABNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];
//}
//
//-(void)OtherGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
//{
//
//    AFHTTPSessionManager* otherMa = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:@""]];
//
//    otherMa.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
//    otherMa.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
//    otherMa.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//
//    [otherMa GET:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[ABNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[ABNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];
//}
//
//-(void)OtherPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
//{
//    AFHTTPSessionManager* otherMa = [[AFHTTPSessionManager manager] initWithBaseURL:[NSURL URLWithString:@""]];
//
//    otherMa.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
//    otherMa.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
//    otherMa.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//
//    [otherMa POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[ABNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[ABNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];
//}
//
//
//-(void)AFPOSTJSONNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
//{
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//
//    if([url isEqualToString:@"trade/execute_barcode_trade"])
//    {
//        manager.requestSerializer.timeoutInterval = 20.f;
//    }else
//    {
//        manager.requestSerializer.timeoutInterval = 10.f;
//    }
//
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//
//    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[ABNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        [[ABNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];
//}


- (void)setRequestSerializer
{
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",@"image/jpeg",nil];
//    manager.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
}

#pragma mark - 6.1 下载进度
- (void)getVideoByCourseWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn andProgress:(serverProgressFn)progressFn
{
    
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@",StringForId([GVUserDefaults standardUserDefaults].access_token)] forHTTPHeaderField:@"authorization"];
    
    number = 0;

    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    sizeDic = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [manager GET:url parameters:body headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//        [self handleResourceDownLoad:responseObject WithCourseId:StringForId(body[@"code"]) andProgress:progressFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//        [self handleResourceDownLoad:error WithCourseId:StringForId(body[@"code"]) andProgress:progressFn];
    }];
    
    /*
     size = "2441.42";
     time = 32;
     totalSize = "2606.42";
     */
}

- (void)goToDownloadResourceWith:(DownLoadModel *)downLoadModel WithCourseId:(NSString *)courseId AndSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn andProgress:(serverProgressFn)progressFn
{
    sizeDic = [NSMutableDictionary dictionaryWithCapacity:0];
    [self cancleDownLoad];
    //获取Document文件
    NSString * docsdir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * rarFilePath = [docsdir stringByAppendingPathComponent:courseId];//将需要创建的串拼接到后面
//        NSString * dataFilePath = [docsdir stringByAppendingPathComponent:@"AnnouncementData"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
//        BOOL dataIsDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
//        BOOL dataExisted = [fileManager fileExistsAtPath:dataFilePath isDirectory:&dataIsDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    long long total = (long long)[StringForId(downLoadModel.totalSize) doubleValue];
//    long long total = 234894201;
    [GVUserDefaults standardUserDefaults].total = [NSString stringWithFormat:@"%lld",total];
    self->totalSize = total;
    
    if (![StringForId(downLoadModel.url) isEqual:@""]) {
//    NSString *vedioUrlStr = @"http://192.168.10.77:9000/hdai/ai-video/66188e799779434dad45a245d708f132.mp4";
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *extention = @"mp4";
        NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",StringForId(downLoadModel.name),extention];
        NSString  *fullPath = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, courseId, mediaUrl];
        NSInteger currentLength = [self fileLengthForPath:fullPath];
//        [sizeDic setObject:[NSString stringWithFormat:@"%lld",(long long)currentLength] forKey:StringForId(downLoadModel.name)];
        [sizeDic setObject:@"0" forKey:StringForId(downLoadModel.name)];

        NSString *vedioUrlStr = StringForId(downLoadModel.url);
        self->number += 1;
        [self downLoadVideoAndAudioWithUrl:vedioUrlStr UrlName:StringForId(downLoadModel.name) andProgress:progressFn IsVideo:YES WithCourseId:courseId Password:StringForId(downLoadModel.unzipPassword) andFailure:^(NSURLSessionDownloadTask * _Nullable task, NSError * _Nonnull error) {
            if (self->imagesTask.error.code == NSURLErrorCancelled) {
                    // 取消了请求
            } else {
                [self->imagesTask cancel];
                self->imagesTask = nil;
            }
            
            failerFn(error);
        }];
        
    }

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource",cachesPath,courseId];
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![[NSFileManager defaultManager] fileExistsAtPath:pathString]) {
        [fileManager createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    NSString *path = [pathString stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",StringForId(downLoadModel.modelName)]];
    NSInteger currentLength = [self fileLengthForPath:path];
//    [sizeDic setObject:[NSString stringWithFormat:@"%lld",(long long)currentLength] forKey:@"images"];
    [sizeDic setObject:@"0" forKey:@"images"];
    
//    NSString *imageUrlStr = @"https://pub-1302721296.cos.ap-shanghai.myqcloud.com/video_pack/1606198995.zip";
    NSString *imageUrlStr = StringForId(downLoadModel.modelAddress);
//    dispatch_semaphore_t dispatch_semaphore_create(long value);

    self->number += 1;
    [self downLoadVideoAndAudioWithUrl:imageUrlStr UrlName:@"images" andProgress:progressFn IsVideo:NO WithCourseId:courseId Password:StringForId(downLoadModel.unzipPassword) andFailure:^(NSURLSessionDownloadTask * _Nullable task, NSError * _Nonnull error) {
        if (self->videoTask.error.code == NSURLErrorCancelled) {
                // 取消了请求
        } else {
            [self->videoTask cancel];
            self->videoTask = nil;
        }
        
        failerFn(error);
    }];
    

}



- (void)downLoadVideoAndAudioWithUrl:(NSString *)urlStr UrlName:(NSString *)urlName andProgress:(serverProgressFn)progressFn IsVideo:(BOOL)isVideo WithCourseId:(NSString *)courseId Password:(NSString *)password andFailure:(nullable void (^)(NSURLSessionDownloadTask * _Nullable, NSError * _Nonnull))failure
{
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:urlName];
//    [sizeDic setObject:@"0" forKey:urlName];
 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:];
    
    // 设置HTTP请求头中的Range
    NSString *range = [NSString stringWithFormat:@"bytes=%zd-",[sizeDic[urlName] integerValue]];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"totalUnitCount----%lld",downloadProgress.totalUnitCount);
        NSLog(@"completedUnitCount--%lld",downloadProgress.completedUnitCount);
//        NSLog(@"-----completedUnitCount--%lld",[[[NSUserDefaults standardUserDefaults] objectForKey:urlName] longLongValue]);
        
//        long long completedUnitCount = [[[NSUserDefaults standardUserDefaults] objectForKey:urlName] longLongValue];
        long long completedUnitCount = 0;
        
        
        for (NSString *sizeStr in [self->sizeDic allValues]) {
            completedUnitCount += [sizeStr longLongValue];
        }
        NSLog(@"添加的completedUnitCount--%lld",completedUnitCount);
        NSLog(@"总的的completedUnitCount--%lld",self->totalSize);
//        double value = ((double)completedUnitCount)/((double)[[GVUserDefaults standardUserDefaults].total longLongValue]);
        
        double value = ((double)completedUnitCount)/((double)self->totalSize);
        
//        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%lld",downloadProgress.completedUnitCount] forKey:urlName];
        [self->sizeDic setObject:[NSString stringWithFormat:@"%lld",downloadProgress.completedUnitCount] forKey:urlName];

        progressFn(value);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        if (!isVideo) {
//            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *cachesPath = [paths objectAtIndex:0];
            NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource",cachesPath,courseId];
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            if (![[NSFileManager defaultManager] fileExistsAtPath:pathString]) {
                [fileManager createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
            } else {
                NSLog(@"FileDir is exists.");
            }
            NSString *path = [pathString stringByAppendingPathComponent:response.suggestedFilename];
            return [NSURL fileURLWithPath:path];
        }else{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *extention = @"mp4";
            NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
            NSString  *fullPath = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, courseId, mediaUrl];
            NSLog(@"%@",fullPath);
            return [NSURL fileURLWithPath:fullPath];
        }
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                self->number -= 1;
                failure(task ,error);
                return;
            }
        }
        self->number -= 1;
        NSString *zipFilePath = [filePath path];// 将NSURL转成NSString
        if (![zipFilePath hasSuffix:@".mp4"]) {
//            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//            NSString *pathString = [NSString stringWithFormat:@"%@/ImageResource",cachesPath];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *cachesPath = [paths objectAtIndex:0];
            NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource",cachesPath,courseId];
            [self releaseZipFileWithZipPath:zipFilePath ReleasePath:pathString Password:password ReleaseResult:^(BOOL release) {
                if (release) {

                }else{
                    [SVProgressHUD showInfoWithStatus:@"解压失败..."];

                }
                
            }];
//            progressFn(1);
        }
        if (self->number == 0) {
            self->videoTask = nil;
            self->imagesTask = nil;
            progressFn(1);
//            _progressHUD.label.text = @"正在解压...";
            // filePath就是你下载文件的位置，你可以解压，也可以直接拿来使用
            
        }
        
    }];
    
    if (isVideo) {
        videoTask = task;
    }else{
        imagesTask = task;
    }
    
    
    [manager setDataTaskDidReceiveResponseBlock:^NSURLSessionResponseDisposition(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSURLResponse * _Nonnull response) {
        if (!isVideo) {
//            NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *cachesPath = [paths objectAtIndex:0];
            NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource",cachesPath,courseId];
            NSFileManager *fileManager = [[NSFileManager alloc] init];
            if (![[NSFileManager defaultManager] fileExistsAtPath:pathString]) {
                [fileManager createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:nil];
            } else {
                NSLog(@"FileDir is exists.");
            }
            NSString *path = [pathString stringByAppendingPathComponent:response.suggestedFilename];
//            return [NSURL fileURLWithPath:path];
            imagesfileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        }else{
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *extention = @"mp4";
            NSString *mediaUrl = [NSString stringWithFormat:@"%@.%@",urlName,extention];
            NSString  *fullPath = [NSString stringWithFormat:@"%@/%@/%@", documentsDirectory, courseId, mediaUrl];
            NSLog(@"%@",fullPath);
//            return [NSURL fileURLWithPath:fullPath];
            videofileHandle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
        }
        
        // 允许处理服务器的响应，才会继续接收服务器返回的数据
        return NSURLSessionResponseAllow;
    }];
    
    [manager setDataTaskDidReceiveDataBlock:^(NSURLSession * _Nonnull session, NSURLSessionDataTask * _Nonnull dataTask, NSData * _Nonnull data) {
        NSLog(@"setDataTaskDidReceiveDataBlock");
        
        if (!isVideo)
        {
            [imagesfileHandle seekToEndOfFile];
            [imagesfileHandle writeData:data];
        }else{
            [videofileHandle seekToEndOfFile];
            [videofileHandle writeData:data];
        }
//        // 指定数据的写入位置 -- 文件内容的最后面
//        [weakSelf.fileHandle seekToEndOfFile];
//
//        // 向沙盒写入数据
//        [weakSelf.fileHandle writeData:data];
        
//        // 拼接文件总长度
//        weakSelf.currentLength += data.length;
    }];
    
    
    [task resume];
}

- (void)cancleDownLoad

{
    if (videoTask) {
        [videoTask cancel];
        videoTask = nil;
    }
    if (imagesTask) {
        [imagesTask cancel];
        imagesTask = nil;
    }
}

- (void)StopDownLoad

{
    if (videoTask) {
        [videoTask suspend];
//        videoTask = nil;
    }
    if (imagesTask) {
        [imagesTask suspend];
//        imagesTask = nil;
    }
}

/**
 * 获取已下载的文件大小
 */
- (NSInteger)fileLengthForPath:(NSString *)path {
    NSInteger fileLength = 0;
    NSFileManager *fileManager = [[NSFileManager alloc] init]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileLength = [fileDict fileSize];
        }
    }
    return fileLength;
}

#pragma mark - 解压zip文件
- (void)releaseZipFileWithZipPath:(NSString *)zipPath ReleasePath:(NSString *)releasePath Password:(NSString *)password ReleaseResult:(void (^)(BOOL release))releaseResult
{
    NSError *error = nil;
    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:releasePath overwrite:YES password:password error:&error delegate:self]) {
        NSLog(@"解压成功 -- %@",releasePath);
        
        NSError *error = nil;
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *cachesPath = [paths objectAtIndex:0];
//        NSString *pathString = [NSString stringWithFormat:@"%@/%@/ImageResource/%@",cachesPath,_codeID,StringForId(dict[_codeID][@"modelName"])];
        if ([self isFileExitsAtPath:zipPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:zipPath error:&error];
        }
    
        releaseResult(YES);
        
    }else{
        releaseResult(NO);
        NSLog(@"%@",error);
    }
}

- (void)zipArchiveProgressEvent:(unsigned long long)loaded total:(unsigned long long)total
{
    float totalSize = total;
//    _progressHUD.progress = (float)loaded/totalSize;
    NSLog(@"loaded -- %lld  total -- %lld",loaded,total);
}



- (BOOL)isFileExitsAtPath:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath isDirectory:NULL]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - 6.1 上传零时图片
+ (void)upLoadingUTmpPicWithImage:(UIImage *)image
                     SuccessBlock:(void (^)(BOOL Success,NSDictionary *resultDictionary))successBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval timeInterVal = [date timeIntervalSince1970]*1000;
//    NSNumber *numStage = [NSNumber numberWithDouble:timeInterVal];
//    NSString *numString = [NSString stringWithFormat:@"%0.0f",[numStage doubleValue]];
//    NSString *md5String = [NSString stringWithFormat:@"zbda12ddcc%@",numString];
//    NSString *MD5Str = [BCBaseObject MD5Hash:md5String];
    NSMutableDictionary* body = [NSMutableDictionary dictionaryWithCapacity:0];
    [body setObject:@"123" forKey:@"file"];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    NSString *url = [NSString stringWithFormat:@"%@/upload/uploadImage",Host_Url];
    
    [manager POST:url parameters:nil headers:@{} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"test.png" mimeType:@"image/png"];//name必填file否则报错：参数缺失
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"0"]) {
            successBlock(YES,responseObject);
        }else{
            //            [[DMCAlertCenter defaultCenter] postAlertWithMessage:responseObject[@"msg"]];
            successBlock(NO,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        successBlock(NO,nil);
    }];
    
}


- (void)postWithUrl:(NSString *)url body:(NSData *)body  success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure

{

    NSString *requestUrl = [NSString stringWithFormat:@"%@%@",Host_Url,url];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    //如果你不需要将通过body传 那就参数放入parameters里面

    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];

    NSLog(@"requestURL:%@",requestUrl);

    request.timeoutInterval= 10;

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    // 设置body 在这里将参数放入到body

    [request setHTTPBody:body];

    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];

    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"text/plain",nil];

    manager.responseSerializer = responseSerializer;

    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse *response,id responseObject,NSError *error){

    if(responseObject!=nil){

    success(responseObject);

    }

    if (error) {

        
       failure(error);

    }

    }]resume];

}

- (void)checkNetwrokTokenWithSuccess:(serverSuccessFn)successFn
{
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setObject:[GVUserDefaults standardUserDefaults].refresh_token forKey:@"refresh_token"];
    [body setObject:@"refresh_token" forKey:@"grant_type"];
    [body setObject:@"pamir" forKey:@"client_id"];
    [body setObject:@"pamir" forKey:@"client_secret"];
    [self AFGETNetworkWithUrl:@"auth/oauth/token" andBody:body andSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        
        [GVUserDefaults standardUserDefaults].access_token = StringForId(responseBefore[@"access_token"]);
        [GVUserDefaults standardUserDefaults].refresh_token = StringForId(responseBefore[@"refresh_token"]);
        long long expiresIn = StringForId(responseBefore[@"expires_in"]).longLongValue;
        NSString *expires_inStr = [DatetimeOpeartion getSecondDataWithSecond:expiresIn];
        [GVUserDefaults standardUserDefaults].expires_in = expires_inStr;
        successFn(responseAfter,responseBefore);
        
    } andFailer:^(NSError * _Nonnull error) {
        
//        [GVUserDefaults standardUserDefaults].phone = @"";
//        [GVUserDefaults standardUserDefaults].access_token = @"";
//
//        appDelegate.loginNav.modalPresentationStyle = 0;
//        [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:NO completion:nil];
//        [self.navigationController popToRootViewControllerAnimated:NO];
//        appDelegate.baseTabbar.selectedIndex = 0;
        
    }];
}

@end
