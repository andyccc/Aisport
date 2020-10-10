//
//  SearchResultsModel.h
//  Aisport
//
//  Created by 申公安 on 2020/12/24.
//

#import "JSONModel.h"
#import "VideoElementListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultsModel : JSONModel

@property (nonatomic, strong) NSNumber<Optional> *videoElementNum;
@property (nonatomic, strong) NSArray<Optional> *videoElementList;
@property (nonatomic, strong) NSNumber<Optional> *compilationsElementNum;
@property (nonatomic, strong) NSArray<Optional> *compilationsElementList;

- (NSArray<Optional> *)videoElementListArray;

@end

NS_ASSUME_NONNULL_END
