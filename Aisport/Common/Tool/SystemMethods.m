//
//  SystemMethods.m
//  UniversalProject
//
//  Created by Pure Ruins on 14-3-16.
//  Copyright (c) 2014年 Pure Ruins. All rights reserved.
//

#import "SystemMethods.h"
@implementation SystemMethods

//获取设备类型
+(DeviceType)SystemGetDeviceTpe{
    if(UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad)
    {
        //iPad
        if([UIScreen instancesRespondToSelector:@selector(currentMode)]){
            if(CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size)){
                return DeviceTypeiPad_Retina;
            }else{
                return DeviceTypeiPad_NotRetina;
            }
        }else{
            return DeviceTypeiPad_NotRetina;
        }
    }
    else
    {
        //非ipad
        if([UIScreen instancesRespondToSelector:@selector(currentMode)]){
            if(CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)){
                return DeviceTypeiPhone_3_5inch;
            }else if(CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)){
                return DeviceTypeiPhone_4inch;
            }else{
                return DeviceTypeiPhone_NotRetina;
            }
        }else{
            return DeviceTypeiPhone_NotRetina;
        }
    }
    
    return DeviceTypeUnkown;
}

//获取设备是否是模拟器
+(BOOL)SystemDeviceIsSimulatorNoNot{
    NSString *modelname = [[UIDevice currentDevice]model];
    if ([modelname isEqualToString:@"iPhone Simulator"]||[modelname isEqualToString:@"iPad Simulator"]) {
        //Simulator
        return YES;
    }else{
        return NO;
    }
}

//获取设备系统版本
+(CGFloat)SystemGetSystemVersion{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

//获取软件版本
+(NSString *)SystemGetSoftVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

//打开网页
+(void)ShareOpenWeb:(NSString *)webUrl{
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:webUrl]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:webUrl]];
    }else{
//        [MBProgressHelper ShowNoticeWithTitle:@"打不开该网页，请检查地址" Detail:nil];
    }
}

//拨打电话
+(void)ShareMakeACall:(NSString *)phoneNumber{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"]){
//        [MBProgressHelper ShowNoticeWithTitle:@"抱歉，您的设备不支持电话功能" Detail:nil];
    }else{
        if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
        }else{
//            [MBProgressHelper ShowNoticeWithTitle:@"无法拨打电话，请检查号码" Detail:nil];
        }
    }
}

@end
