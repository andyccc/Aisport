//
//  IphoneDevice.h
//  HROA
//
//  Created by 🔥尔查 on 15/12/20.
//  Copyright © 2015年 PureRuins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface IphoneDevice : NSObject

//获取设备机型
+ (NSString*)deviceVersion;

//获取设备当前运营商
+ (NSString*)getTelephonyNetworkInfo;
@end
