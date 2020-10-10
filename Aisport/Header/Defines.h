//
//  Defines.h
//  UniversalProject
//
//  Created by PureRuins on 15/1/26.
//  Copyright (c) 2015年 PureRuins. All rights reserved.
//


//#ifndef UniversalProject_Defines_h
#define UniversalProject_Defines_h

////H5界面主地址
////#define Host_Url_Web @"https://uat-aih5.hidbb.com/"
////#define Host_Url_Web @"https://ai-h5.local.hidbb.com/"
//#define Host_Url_Web @"https://uat-aih5.hidbb.com/"  //预发
////#define Host_Url_Web @"https://ai-h5.hidbb.com/"  //线上


//网络
#define ZBREACH [ZBReachCenter defaultZBReachCenter]

//设备类型
#define DEVICETYPE_IPHONE 0
#define DEVICETYPE_IPHONE5 1
#define DEVICETYPE_IPAD 2

//程序总委托
#define appDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//日志调试
#ifdef DEBUG
#define DebugLog(format,...)    NSLog(@"{%s,%d}" format, __FUNCTION__,__LINE__,##__VA_ARGS__)
#else
#define DebugLog(format,...)
#endif

#define WS(weakSelf)            __weak __typeof(&*self)weakSelf = self;
#define WEAK(obj)               __weak typeof(obj) weak_##obj = obj



//是否为Retina屏幕
#ifndef isRetina
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#endif

//设备屏幕高度
#ifndef UIScreenHeight
#define UIScreenHeight    [UIScreen mainScreen].bounds.size.height
#endif


//设备屏幕宽度
#ifndef UIScreenWidth
#define UIScreenWidth    [UIScreen mainScreen].bounds.size.width
#endif

#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


//判断是否是ipad
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断是否是iPhone
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone12 mini
#define IS_IPHONE_12_mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone12
#define IS_IPHONE_12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
//判断iPhone12_Pro_Max
#define IS_IPHONE_12_Pro_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)


//iPhoneX系列
//#define Height_StatusBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.0 : 20.0)
//#define Height_NavBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.0 : 64.0)
//#define Height_TabBar ((IS_IPHONE_X==YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.0)

#define SCREEN_MAX_LENGTH   (MAX(SCR_WIDTH, SCR_HIGHT))
#define iPhoneXBottomHeight  ((IS_IPHONE && SCREEN_MAX_LENGTH >= 812) ? 34 : 0)



//设备屏幕宽度
#define SCR_WIDTH    UIScreenWidth
//设备屏幕高度
#define SCR_HIGHT    UIScreenHeight


#define SafeAreaTopHeight (kDevice_Is_iPhoneX == YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE_12_mini== YES || IS_IPHONE_12== YES || IS_IPHONE_12_Pro_Max== YES ? 88 : 64)
#define SafeAreaBottomHeight (kDevice_Is_iPhoneX == YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE_12_mini== YES || IS_IPHONE_12== YES || IS_IPHONE_12_Pro_Max== YES ? 83 : 49)

#define StatusHeight (kDevice_Is_iPhoneX == YES || IS_IPHONE_Xr ==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES || IS_IPHONE_12_mini== YES || IS_IPHONE_12== YES || IS_IPHONE_12_Pro_Max== YES ? 44 : 20)

//#define itemWidth (SCR_WIDTH - 30 - 20)/3

#define Screen_Scale UIScreenWidth/750.0
#define Screen_Scale_height UIScreenHeight/1334.0

#define UIValue(x) ceilf((x)*Screen_Scale*2)

#define SCR_max MAX(SCR_WIDTH, SCR_HIGHT)
#define SCR_min MIN(SCR_WIDTH, SCR_HIGHT)


//APP的字体 暂且为系统字体
#define fontApp(size)   [UIFont systemFontOfSize:size]
#define fontBold(size)   [UIFont boldSystemFontOfSize:size]
#define FontSize(size)  [UIFont systemFontOfSize:size]
#define fontNumApp(a)  [UIFont boldSystemFontOfSize:a-1]




//是否为iOS9
#ifndef IOS9
#define IOS9              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)
#endif

#ifndef IOS11
#define IOS11              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES : NO)
#endif

#ifndef IOS13
#define IOS13              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 13.0 ? YES : NO)
#endif



//数字转字符串
#define StringFromNSInteger(num) [NSString stringWithFormat:@"%zi",num]
#define StringFromNSDouble(num) [NSString stringWithFormat:@"%lf",num]

//线条
#define addLine(view,y) \
UIView* defLine = [[UIView alloc]initWithFrame:CGRectMake(0, y , view.frame.size.width, 1)];\
defLine.backgroundColor = textColor_E8E9EB;\
[view addSubview:defLine];\

#define addYLine(view,x) \
UIView* defYLine = [[UIView alloc]initWithFrame:CGRectMake(x, 0 , 1, view.frame.size.height)];\
defYLine.backgroundColor = textColor_E8E9EB;\
[view addSubview:defYLine];\

#define addXYLine(view,x,y) \
UIView* defXYLine = [[UIView alloc]initWithFrame:CGRectMake(x, y, SCR_WIDTH, 1)];\
defXYLine.backgroundColor = textColor_E8E9EB;\
[view addSubview:defXYLine];\


#define ISNULL(x)               ((x) == nil || [x isEqual:[NSNull null]] ? @"" : (x))

#define StringForId(x)               [NSString stringForId:x]
#define StringNumForId(x,num)            [StringForId(x) isEqualToString:@""]?num:StringForId(x)

#define placeHolderImg [UIImage imageNamed:@"placeHolderImg"]


//#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//iPhone6 屏幕尺寸
#define K6_WIDTH 375.0
#define K6_HEIGHT 667.0

#pragma mark - == ratio ==
#define ratio_scale (IS_IPAD ? (SCR_WIDTH / K6_WIDTH) * 0.8 : (SCR_WIDTH / K6_WIDTH))
#define ratio_scale_pad (IS_IPAD ? (SCR_WIDTH / K6_WIDTH) : (SCR_WIDTH / K6_WIDTH))

//#define UIValue(x) floor((x)*ratio_scale)
#define UIV(x) ceilf((x)*ratio_scale)
//#define UIV(x) ceilf((x)*Screen_Scale)
#define uiv(x) UIV(x)

#define PUIV(x) ceilf((x)*ratio_scale_pad)

#define Font_Sys_Bold(x)    [UIFont boldSystemFontOfSize:x]
#define Font_Sys(x)         [UIFont systemFontOfSize:x]
#define Font(x)             Font_Sys((x))

#define ratio_fontScale (ratio_scale) //
#define FontBoldR(x)    Font_Sys_Bold(floorf(ratio_fontScale*(x)))
#define FontR(x)        Font_Sys(floorf(ratio_fontScale*(x)))

#define IS_LOGINED ![StringForId([GVUserDefaults standardUserDefaults].access_token) isEqual:@""]


// 检查是否需要登录
#define CHECK_LOGIN() \
    if (!IS_LOGINED) { \
        [appDelegate showLogin];  \
        return; \
    }


//#endif
