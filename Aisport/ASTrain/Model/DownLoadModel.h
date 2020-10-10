//
//  DownLoadModel.h
//  Aisport
//
//  Created by Apple on 2020/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownLoadModel : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *hashValue;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *modelAddress;
@property (nonatomic, strong) NSString *modelMd5;
@property (nonatomic, strong) NSString *unzipPassword;
@property (nonatomic, strong) NSString *totalSize;

@property (nonatomic, assign) NSInteger downType;



@end

NS_ASSUME_NONNULL_END
