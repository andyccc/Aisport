//
//  GVUserDefaults+PropertyList.h
//  ABroad
//
//  Created by gaojun on 16/8/23.
//  Copyright © 2016年 jesus. All rights reserved.
//

#import <GVUserDefaults/GVUserDefaults.h>

@interface GVUserDefaults (PropertyList)

@property (nonatomic,assign)BOOL version;
@property (nonatomic,assign)long runCount;
@property (nonatomic,assign)long long enterDetailCount;
@property (nonatomic,assign)int firstEnter;  //11 第一次进入
@property (nonatomic,assign)int firstInfoEnter;  //11 第一次账号界面

@property (nonatomic,strong)NSString* uuid;
@property (nonatomic,strong)NSString* user_Id;
@property (nonatomic,strong)NSString* page_Session_Id;

@property (nonatomic,strong)NSString* phone;
@property (nonatomic,strong)NSString* nickName;
@property (nonatomic,strong)NSString* cover;
@property (nonatomic,strong)NSString* sex;
@property (nonatomic,strong)NSString* access_token;  //首次token
@property (nonatomic,strong)NSString* refresh_token;  //token失效，可替换token
@property (nonatomic,strong)NSString* username;
@property (nonatomic,strong)NSString* randomcode;


@property (nonatomic,strong)NSString* total;
@property (nonatomic,strong)NSString* complate;

@property (nonatomic,strong)NSString * expires_in;  //token失效时间


@end
