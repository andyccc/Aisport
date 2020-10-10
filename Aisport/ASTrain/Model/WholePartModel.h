//
//  WholePartModel.h
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WholePartModel : JSONModel

@property (nonatomic, strong) NSString <Optional>* id;
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* cover;
@property (nonatomic, strong) NSString <Optional>* detailCover;
@property (nonatomic, strong) NSString <Optional>* status;
@property (nonatomic, strong) NSString <Optional>* creatorId;
@property (nonatomic, strong) NSString <Optional>* createTime;
@property (nonatomic, strong) NSString <Optional>* updateTime;
@property (nonatomic, strong) NSString <Optional>* delFlag;
@property (nonatomic, strong) NSString <Optional>* introduce;

@end

/*
 {
         "id": 17,
         "name": "Auto-HJ_1111145655",
         "cover": "https://pub.hidbb.com/ai-dev/ai/b34d4dbe14464754a2fa5c8e7a73c9f2.png",
         "detailCover": "https://pub.hidbb.com/ai-dev/ai/6347dafd4d60499888618b494decaca5.jpg",
         "status": 1,
         "creatorId": 442,
         "createTime": "2020-11-11 14:56:56",
         "updateTime": "2020-11-11 15:06:05",
         "delFlag": "0",
         "introduce": "introduce-introduce-introduce-introduce-introduce-introduce_edit"
     }
 */

NS_ASSUME_NONNULL_END
