//
//  CourseModel.h
//  Aisport
//
//  Created by Apple on 2020/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CourseModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *modelName;
@property (nonatomic, strong) NSString *modelMd5;
@property (nonatomic, strong) NSString *curHighScore;

@end

NS_ASSUME_NONNULL_END
