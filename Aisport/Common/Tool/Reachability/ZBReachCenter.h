//
//  ZBReachCenter.h
//  ZhuangDianBi
//
//  Created by ZDB on 2017/1/11.
//  Copyright © 2017年 CT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZBReachCenter : NSObject

+ (instancetype)defaultZBReachCenter;

@property (assign ,nonatomic ,getter=reachable) BOOL isReachable;


@end
