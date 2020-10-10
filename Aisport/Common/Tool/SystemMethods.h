//
//  SystemMethods.h
//  UniversalProject
//
//  Created by Pure Ruins on 14-3-16.
//  Copyright (c) 2014年 Pure Ruins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef enum{
    DeviceTypeUnkown           = 0,
    DeviceTypeiPhone_NotRetina = 1,
    DeviceTypeiPhone_3_5inch   = 2,
    DeviceTypeiPhone_4inch     = 3,
    DeviceTypeiPad_NotRetina   = 4,
    DeviceTypeiPad_Retina      = 5
}DeviceType;

@interface SystemMethods : NSObject

//获取设备类型
+(DeviceType)SystemGetDeviceTpe;

//获取设备是否是模拟器
+(BOOL)SystemDeviceIsSimulatorNoNot;

//获取设备系统版本
+(CGFloat)SystemGetSystemVersion;

//获取软件版本
+(NSString *)SystemGetSoftVersion;

//打开网页
+(void)ShareOpenWeb:(NSString *)webUrl;

//拨打电话
+(void)ShareMakeACall:(NSString *)phoneNumber;

@end
