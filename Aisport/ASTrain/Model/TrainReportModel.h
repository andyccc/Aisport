//
//  TrainReportModel.h
//  Aisport
//
//  Created by Apple on 2020/11/4.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainReportModel : JSONModel

@property (nonatomic, strong) NSString <Optional>* courseCode;
@property (nonatomic, strong) NSString <Optional>* creatorId;

@property (nonatomic, strong) NSString <Optional>* medalRecordId;
@property (nonatomic, strong) NSString <Optional>* delFlag;
@property (nonatomic, strong) NSString <Optional>* startTime;
@property (nonatomic, strong) NSString <Optional>* updateTime;
@property (nonatomic, strong) NSString <Optional>* userId;
@property (nonatomic, strong) NSString <Optional>* videoCode;
@property (nonatomic, strong) NSString <Optional>* videoVersion;

@property (nonatomic, strong) NSString <Optional>* beatRate;
@property (nonatomic, strong) NSString <Optional>* calorie;
@property (nonatomic, strong) NSString <Optional>* calorieTotal;
@property (nonatomic, strong) NSString <Optional>* completeness; //0.未完成(视频中途退出)  1.一般  2.良好  3.极佳
@property (nonatomic, strong) NSString <Optional>* completenessStr; 
@property (nonatomic, strong) NSString <Optional>* effortNumber;
@property (nonatomic, strong) NSString <Optional>* endTime;
@property (nonatomic, strong) NSString <Optional>* perfectNumber;
@property (nonatomic, strong) NSString <Optional>* score;

@property (nonatomic, strong) NSString <Optional>* courseName;
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* level;
@property (nonatomic, strong) NSString <Optional>* image;
@property (nonatomic, strong) NSString <Optional>* id;
@property (nonatomic, strong) NSString <Optional>* createTime;



@end

NS_ASSUME_NONNULL_END
