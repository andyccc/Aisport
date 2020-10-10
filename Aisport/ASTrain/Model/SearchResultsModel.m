//
//  SearchResultsModel.m
//  Aisport
//
//  Created by 申公安 on 2020/12/24.
//

#import "SearchResultsModel.h"

@implementation SearchResultsModel

- (NSArray *)videoElementListArray
{
    if (self.videoElementList.count > 0) {
        NSArray *listArray = [VideoElementListModel arrayOfModelsFromDictionaries:self.videoElementList error:nil];
        return listArray;
    }
    return nil;
}


@end
