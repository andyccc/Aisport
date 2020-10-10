//
//  BannerModel.h
//  Aisport
//
//  Created by Apple on 2020/12/9.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BannerModel : JSONModel

@property (nonatomic, strong) NSString <Optional>* image;
@property (nonatomic, strong) NSString <Optional>* url;
@property (nonatomic, strong) NSString <Optional>* id;

@end

NS_ASSUME_NONNULL_END
