//
//  HomeListModel.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListModel : JSONModel


//可能废弃参数
@property (nonatomic, strong) NSString <Optional>* courseCode;
//@property (nonatomic, strong) NSString <Optional>* code;

//@property (nonatomic, strong) NSString <Optional>* name;
//@property (nonatomic, strong) NSString <Optional>* playTotal;
@property (nonatomic, strong) NSString <Optional>* highScore;
@property (nonatomic, strong) NSString <Optional>* minute;
@property (nonatomic, strong) NSString <Optional>* calorieTotal;
//@property (nonatomic, strong) NSString <Optional>* cover;
@property (nonatomic, strong) NSString <Optional>* descriptionStr;  //description
@property (nonatomic, strong) NSString <Optional>* createTime;

@property (nonatomic, strong) NSString <Optional>* content;
@property (nonatomic, strong) NSString <Optional>* detailCover;
@property (nonatomic, strong) NSString <Optional>* isCollect;
@property (nonatomic, strong) NSString <Optional>* videoUrlStr;  //videoUrl
@property (nonatomic, strong) NSString <Optional>* beforeClass;
@property (nonatomic, strong) NSString <Optional>* leverStr;
@property (nonatomic, strong) NSString <Optional>* courseCalorie;

@property (nonatomic, strong) NSString <Optional>* time;
@property (nonatomic, strong) NSString <Optional>* calorie;
//新接口参数
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* author;
@property (nonatomic, strong) NSString <Optional>* curHighScore;
@property (nonatomic, strong) NSString <Optional>* playTotal;
@property (nonatomic, strong) NSString <Optional>* cover;
@property (nonatomic, strong) NSString <Optional>* leverVStr;
@property (nonatomic, strong) NSString <Optional>* lever;
@property (nonatomic, strong) NSString <Optional>* code;
@property (nonatomic, strong) NSString <Optional>* url;
@property (nonatomic, strong) NSString <Optional>* modelMd5;


@end

NS_ASSUME_NONNULL_END
