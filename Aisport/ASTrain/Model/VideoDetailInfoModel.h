//
//  VideoDetailInfoModel.h
//  Aisport
//
//  Created by 申公安 on 2020/12/27.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailInfoModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *id;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSNumber<Optional> *version;
@property (nonatomic, strong) NSString<Optional> *url;
@property (nonatomic, strong) NSString<Optional> *detailUrl;
@property (nonatomic, strong) NSString<Optional> *detailSize;
@property (nonatomic, strong) NSString<Optional> *detailMd5;
@property (nonatomic, strong) NSNumber<Optional> *lever;
@property (nonatomic, strong) NSString<Optional> *tagIds;
@property (nonatomic, strong) NSString<Optional> *tags;
@property (nonatomic, strong) NSNumber<Optional> *downloadNumber;
@property (nonatomic, strong) NSNumber<Optional> *time;
@property (nonatomic, strong) NSNumber<Optional> *size;
@property (nonatomic, strong) NSNumber<Optional> *creatorId;
@property (nonatomic, strong) NSString<Optional> *createTime;
@property (nonatomic, strong) NSString<Optional> *delFlag;
@property (nonatomic, strong) NSString<Optional> *updateTime;
@property (nonatomic, strong) NSNumber<Optional> *status;
@property (nonatomic, strong) NSString<Optional> *hashValue;
@property (nonatomic, strong) NSString<Optional> *code;
@property (nonatomic, strong) NSNumber<Optional> *calorie;
@property (nonatomic, strong) NSString<Optional> *voiceIds;
@property (nonatomic, strong) NSString<Optional> *cover;
@property (nonatomic, strong) NSString<Optional> *detailCover;
@property (nonatomic, strong) NSString<Optional> *uploadTime;
@property (nonatomic, strong) NSString<Optional> *beforeClass;
@property (nonatomic, strong) NSString<Optional> *content;
@property (nonatomic, strong) NSNumber<Optional> *modelVideoId;
@property (nonatomic, strong) NSNumber<Optional> *strength;
@property (nonatomic, strong) NSString<Optional> *song;
@property (nonatomic, strong) NSString<Optional> *author;
@property (nonatomic, strong) NSNumber<Optional> *playTotal;
@property (nonatomic, strong) NSNumber<Optional> *highScore;
@property (nonatomic, strong) NSString<Optional> *modelUrl;
@property (nonatomic, strong) NSArray<Optional> *historyList;
@property (nonatomic, strong) NSNumber<Optional> *isCollected;

- (NSString *)strengthStr;
- (NSString *)leaveStr;

@end

NS_ASSUME_NONNULL_END
