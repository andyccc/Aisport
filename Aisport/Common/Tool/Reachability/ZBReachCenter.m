//
//  ZBReachCenter.m
//  ZhuangDianBi
//
//  Created by ZDB on 2017/1/11.
//  Copyright © 2017年 CT. All rights reserved.
//

#import "ZBReachCenter.h"
#import "Reachability.h"
//#import "SocketSingleTon.h"
@interface ZBReachCenter ()
@property (nonatomic) Reachability *reach;
@end

@implementation ZBReachCenter

+ (instancetype)defaultZBReachCenter
{
    static ZBReachCenter *reachCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reachCenter = [[ZBReachCenter alloc] init];
        [reachCenter startReachMon];
    });
    return reachCenter;
}

- (void)startReachMon
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.reach = [Reachability reachabilityForInternetConnection];
    [self.reach startNotifier];
}

- (BOOL)reachable{
    NetworkStatus netStatus = [self.reach currentReachabilityStatus];
    if (netStatus != NotReachable) {
        return YES;
    }else{
        return NO;
    }
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability* curReach = [notification object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    self.reach = curReach;
    [[NSNotificationCenter defaultCenter]  postNotificationName:@"ReachabilityContect" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ReachabilityContect" object:nil];
//    if (self.isReachable) {
//        [[SocketSingleTon shareInstance] socketCutOff];
//        [[SocketSingleTon shareInstance] socketConnectHost];
//    }else{
//        [[SocketSingleTon shareInstance] socketCutOff];
//        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"网络连接失败"];
//    }
    
}

@end
