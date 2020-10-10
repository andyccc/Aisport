//
//  LoginNetWork.m
//  Aisport
//
//  Created by Apple on 2020/10/26.
//

#import "LoginNetWork.h"
#import "InquiryAlertView.h"

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
    [[LoginNetWork share] AFPOSTNetworkWithUrl:@"ai/hidouserinfo/register?" andBody:body andSuccess:successFn andFailer:failerFn];
//    [[LoginNetWork share] AFPOSTdirectBodyNetworkWithUrl:@"ai/hidouserinfo/register" AndIsLogin:NO andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)loginUserWith:(NSMutableDictionary *)body  AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFPOSTdirectBodyNetworkWithUrl:@"auth/mobile/token/sms" AndIsLogin:YES andBody:body andSuccess:successFn andFailer:failerFn];
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

//通过微信获取信息
+(void)getWXTokenWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] OtherGETNetworkWithUrl:@"https://api.weixin.qq.com/sns/oauth2/access_token" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)getWXUserInfoWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] OtherGETNetworkWithUrl:@"https://api.weixin.qq.com/sns/userinfo" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)getWXLoginWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETNetworkWithUrl:@"admin/ma/phonecheckByUnionId" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)getWXbindUnionIdWith:(NSMutableDictionary *)body AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETNetworkWithUrl:@"admin/ma/bindUnionId" andBody:body andSuccess:successFn andFailer:failerFn];
}

+(void)postSaveDeviceWith:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFPOSTNetworkWithUrl:@"admin/device/save" andBody:body WithHeaders:headers andSuccess:successFn andFailer:failerFn];
}

+(void)getCreatePageSessionWith:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETNetworkWithUrl:@"admin/page/createPageSession" andBody:body WithHeaders:headers andSuccess:successFn andFailer:failerFn];
}

+(void)getPageEventWith:(NSMutableDictionary *)body WithHeaders:(NSDictionary *)headers AndSuccessFn:(serverSuccessFn)successFn andFailerFn:(serverFailureFn)failerFn
{
    [[LoginNetWork share] AFGETNetworkWithUrl:@"admin/page/event" andBody:body WithHeaders:headers andSuccess:successFn andFailer:failerFn];
}

+(void)getAppVersion
{
    NSMutableDictionary* body = [NSMutableDictionary dictionaryWithCapacity:0];
    
//    [body setObject:@"1" forKey:@"type"];
//    [body setObject:[GVUserDefaults standardUserDefaults].academyId forKey:@"academyId"];
    
    [[LoginNetWork share] AFGETNetworkWithUrl:@"ai/datadictionary/getVersion" andBody:nil andSuccess:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
        if(ResponseSuccess)
        {
            float vCode = [StringForId(responseAfter) floatValue];
            NSLog(@"appVersion---------%f-------------",vCode);
            if([appVersion_Code floatValue] < vCode)//如果服务器版本大于本地版本 提示更新客户端
            {
                [[InquiryAlertView shareAlertView] showUpdateAppAlertViewWithSure:^{
//                    NSString *url = [responseAfter[0] objectForKey:@"downloadUrl"];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/cn/app/%E5%97%A8%E5%8A%A8ai/id1537049249"]];
                }];
                
            }else if([appVersion_Code floatValue] > vCode)//如果服务器版本小于本地版本 说明正在审核 组装userId 直接登录
            {
//                if (![StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]) {
//                    return;
//                }
                
                NSMutableDictionary *body = [NSMutableDictionary dictionaryWithCapacity:0];
                [body setObject:@"8286" forKey:@"code"];
                [body setObject:[NSString stringWithFormat:@"SMS@%@",@"15395829512"] forKey:@"mobile"];
                [body setObject:@"mobile" forKey:@"grant_type"];
                WS(weakSelf);
                [LoginNetWork loginUserWith:body AndSuccessFn:^(id  _Nonnull responseAfter, id  _Nonnull responseBefore) {
                    if ([StringForId(responseBefore[@"access_token"]) isEqual:@""]) {
                        [SVProgressHUD showInfoWithStatus:@"登陆失败"];
                        return;
                    }
                    [GVUserDefaults standardUserDefaults].access_token = StringForId(responseBefore[@"access_token"]);
                    [GVUserDefaults standardUserDefaults].refresh_token = StringForId(responseBefore[@"refresh_token"]);
                    [GVUserDefaults standardUserDefaults].phone = StringForId(responseBefore[@"user_info"][@"phone"]);
                    [GVUserDefaults standardUserDefaults].cover = StringForId(responseBefore[@"user_info"][@"cover"]);
                    [GVUserDefaults standardUserDefaults].nickName = StringForId(responseBefore[@"user_info"][@"nickName"]);
                    [GVUserDefaults standardUserDefaults].sex = StringForId(responseBefore[@"user_info"][@"sex"]);
                    
                    long long expiresIn = StringForId(responseBefore[@"expires_in"]).longLongValue/1000;
                    NSString *expires_inStr = [DatetimeOpeartion getSecondDataWithSecond:expiresIn];
                    [GVUserDefaults standardUserDefaults].expires_in = expires_inStr;
                    NSLog(@"%@", [GVUserDefaults standardUserDefaults].expires_in);

                    [GVUserDefaults standardUserDefaults].firstEnter = 11;
                    [GVUserDefaults standardUserDefaults].firstInfoEnter = 11;

                } andFailerFn:^(NSError * _Nonnull error) {
                        
                }];
            }else
            {
                //本地版本等于服务器版本
            }
        }
    } andFailer:^(NSError * _Nonnull error) {
        
    }];
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
