//
//  Defines.h
//  UniversalProject
//
//  Created by PureRuins on 15/1/26.
//  Copyright (c) 2015年 PureRuins. All rights reserved.
//


//#ifndef UniversalProject_Defines_h
#define UniversalProject_Defines_h

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


#define iPhoneXBottomHeight  (UIScreenHeight==812?34:0)



//设备屏幕宽度
#define SCR_WIDTH    UIScreenWidth
//设备屏幕高度
#define SCR_HIGHT    UIScreenHeight

#define SafeAreaTopHeight (kDevice_Is_iPhoneX == YES ? 88 : 64)
#define SafeAreaBottomHeight (kDevice_Is_iPhoneX == YES ? 83 : 49)

#define StatusHeight (kDevice_Is_iPhoneX == YES ? 44 : 20)

#define itemWidth (SCR_WIDTH - 30 - 20)/3

#define Screen_Scale UIScreenWidth/750.0
#define Screen_Scale_height UIScreenHeight/1334.0

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


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//iPhone6 屏幕尺寸
#define K6_WIDTH 375.0
#define K6_HEIGHT 667.0

#pragma mark - == ratio ==
#define ratio_scale (IS_IPAD ? (SCR_WIDTH / K6_WIDTH) * 0.8 : (SCR_WIDTH / K6_WIDTH))
#define ratio_scale_pad (IS_IPAD ? (SCR_WIDTH / K6_WIDTH) : (SCR_WIDTH / K6_WIDTH))

//#define UIValue(x) floor((x)*ratio_scale)
#define UIV(x) ceilf((x)*ratio_scale)
#define PUIV(x) ceilf((x)*ratio_scale_pad)

//#endif
