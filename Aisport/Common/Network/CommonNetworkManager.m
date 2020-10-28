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

#define Host_Url  @"https://dev-gateway.hidbb.com/"
//#define Host_Url  @"http://pamir-gateway:9999"

@implementation CommonNetworkManager{
    AFHTTPSessionManager *manager;
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
        manager.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        
        [manager.requestSerializer
         setValue:@"application/x-www-form-urlencoded;charset=utf-8"
         forHTTPHeaderField:@"Content-Type"];
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
    DebugLog(@"---rop is--- %@",responseObject);
    if([[responseObject objectForKey:@"code"] intValue] == 0)
    {
        [SVProgressHUD dismiss];
//        if([responseObject objectForKey:@"msg"] && ![[responseObject objectForKey:@"msg"] isEqualToString:@"1"])
//        {
//            [SVProgressHUD showInfoWithStatus:[responseObject objectForKey:@"msg"]];
//        }
    }else if([[responseObject objectForKey:@"code"] intValue] == 1)
    {
//        if (![[GVUserDefaults standardUserDefaults].userId isEqualToString:@"31"]) {
//            [SVProgressHUD showInfoWithStatus:@"请登录账号"];
//            [GVUserDefaults standardUserDefaults].userId = nil;
//            appDelegate.baseTabbar.selectedIndex = 0;
//            [appDelegate.baseTabbar presentViewController:appDelegate.loginNav animated:YES completion:nil];
//        }
    }
//    else if([[responseObject objectForKey:@"success"] intValue] == -29999)
//    {
//        [SVProgressHUD showInfoWithStatus:@"账号或密码不正确，请重新输入"];
//    }else if([[responseObject objectForKey:@"success"] intValue] == -49999)
//    {
////        [SVProgressHUD showInfoWithStatus:@"暂无数据"];
//    }else if([[responseObject objectForKey:@"success"] intValue] == 39999)
//    {
//
//    }else
//    {
//        if([responseObject isKindOfClass:[NSNull class]] && [responseObject objectForKey:@"data"] && ![[responseObject objectForKey:@"data"] isEqualToString:@""])
//        {
//            [SVProgressHUD showInfoWithStatus:[responseObject objectForKey:@"data"]];
//        }
//    }
    
    successFn([responseObject objectForKey:@"data"],responseObject);
    
}

-(void)LogFailerResponse:(NSError*)error
                failerFn:(serverFailureFn)failerFn
{
    DebugLog(@"---rop is--- %ld --- %@",(long)error.code,error.userInfo);
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

-(void)AFGETNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
    [self setRequestSerializer];
    
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    
    [manager GET:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
    
    
}

-(void)AFPOSTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
{
//    [self setRequestSerializer];
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
    
//    [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@/%@",Host_Url,url] parameters:body error:nil];
    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];

}

//-(void)AFPOSHTTPResponseTNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
//{
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    if([url isEqualToString:@"trade/execute_barcode_trade"])
//    {
//        manager.requestSerializer.timeoutInterval = 20.f;
//    }else
//    {
//        manager.requestSerializer.timeoutInterval = 10.f;
//    }
//
//    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
//    NSLog(@"body--%@,url---%@",body,url);
//    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[ABNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
//        [[ABNetworkManager share] LogFailerResponse:error failerFn:failerFn];
//    }];
//}
//
//-(void)AFUPLOADNetworkWithUrl:(NSString *)url andBody:(NSMutableDictionary *)body andfilePath:(NSString*)filePath andSuccess:(serverSuccessFn)successFn andFailer:(serverFailureFn)failerFn
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
////    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//
//    [manager POST:url parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"file" fileName:@"xxx.mp3" mimeType:@"application/octet-stream" error:nil];
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

    [manager POST:url parameters:body constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"xxx.jpeg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[CommonNetworkManager share] LogSuccessResponse:responseObject successFn:successFn];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [[CommonNetworkManager share] LogFailerResponse:error failerFn:failerFn];
    }];
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
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html",@"application/x-www-form-urlencoded",@"application/octet-stream",nil];
    manager.responseSerializer.stringEncoding = kCFStringEncodingUTF8;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
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
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
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
//        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"网络错误"];
    }];
    
}

//#pragma mark - 6.2 上传永久图片
//+ (void)upLoadingUPicWithImage:(UIImage *)image
//                  SuccessBlock:(void (^)(BOOL Success,NSDictionary *resultDictionary))successBlock
//{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
////    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
////    NSTimeInterval timeInterVal = [date timeIntervalSince1970]*1000;
////    NSNumber *numStage = [NSNumber numberWithDouble:timeInterVal];
////    NSString *numString = [NSString stringWithFormat:@"%0.0f",[numStage doubleValue]];
////    NSString *md5String = [NSString stringWithFormat:@"zbda12ddcc%@",numString];
////    NSString *MD5Str = [BCBaseObject MD5Hash:md5String];
//    NSDictionary *param = @{@"123":@""};
//    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    NSString *url = [NSString stringWithFormat:@"%@/sys/uPic",Main_Image_URL];
//    [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:imageData name:@"file" fileName:@"test.png" mimeType:@"image/png"];//name必填file否则报错：参数缺失
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
//        if ([code isEqualToString:@"0"]) {
//            successBlock(YES,responseObject);
//        }else{
//            [[DMCAlertCenter defaultCenter] postAlertWithMessage:responseObject[@"msg"]];
//            successBlock(NO,nil);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"网络错误"];;
//    }];
//}

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

@end
