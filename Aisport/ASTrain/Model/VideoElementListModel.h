//
//  VideoElementListData.h
//  Aisport
//
//  Created by 申公安 on 2020/12/24.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoElementListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *code;
@property (nonatomic, strong) NSString<Optional> *cover;
@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSString<Optional> *modelMd5;
@property (nonatomic, strong) NSString<Optional> *url;
@property (nonatomic, strong) NSNumber<Optional> *time;
@property (nonatomic, strong) NSNumber<Optional> *curHighScore;
@property (nonatomic, strong) NSNumber<Optional> *playTotal;
@property (nonatomic, strong) NSString<Optional> *author;
@property (nonatomic, strong) NSNumber<Optional> *lever;

@end

NS_ASSUME_NONNULL_END
