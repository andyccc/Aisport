//
//  VideoDetailGrowthListModel.h
//  Aisport
//
//  Created by 申公安 on 2020/12/27.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailGrowthListModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *id;
@property (nonatomic, strong) NSNumber<Optional> *userId;
@property (nonatomic, strong) NSString<Optional> *videoCode;
@property (nonatomic, strong) NSNumber<Optional> *score;
@property (nonatomic, strong) NSNumber<Optional> *star;
@property (nonatomic, strong) NSNumber<Optional> *rank;
@property (nonatomic, strong) NSNumber<Optional> *rid;
@property (nonatomic, strong) NSString<Optional> *createTime;
@property (nonatomic, strong) NSString<Optional> *updateTime;
@property (nonatomic, strong) NSNumber<Optional> *isNew;

@end

NS_ASSUME_NONNULL_END
