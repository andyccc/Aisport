//
//  VideoDetailRankListModel.h
//  Aisport
//
//  Created by 申公安 on 2020/12/27.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailRankListModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *cover;
@property (nonatomic, strong) NSString<Optional> *nickName;
@property (nonatomic, strong) NSNumber<Optional> *rankNum;
@property (nonatomic, strong) NSNumber<Optional> *score;
@property (nonatomic, strong) NSArray<Optional> *list;

@end

NS_ASSUME_NONNULL_END
