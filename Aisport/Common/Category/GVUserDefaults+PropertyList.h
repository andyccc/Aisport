//
//  GVUserDefaults+PropertyList.h
//  ABroad
//
//  Created by gaojun on 16/8/23.
//  Copyright © 2016年 jesus. All rights reserved.
//

#import <GVUserDefaults/GVUserDefaults.h>

@interface GVUserDefaults (PropertyList)

@property (nonatomic,strong)NSString* phone;
@property (nonatomic,strong)NSString* nickName;
@property (nonatomic,strong)NSString* cover;
@property (nonatomic,strong)NSString* sex;
@property (nonatomic,strong)NSString* access_token;  //首次token
@property (nonatomic,strong)NSString* refresh_token;  //token失效，可替换token
@property (nonatomic,strong)NSString* username;


@property (nonatomic,strong)NSString* total;
@property (nonatomic,strong)NSString* complate;

@end
