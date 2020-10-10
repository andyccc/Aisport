//
//  TrainVideoModel.h
//  Aisport
//
//  Created by Apple on 2020/11/12.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrainVideoModel : JSONModel

@property (nonatomic, strong) NSString <Optional>* cover;
@property (nonatomic, strong) NSString <Optional>* lever;
@property (nonatomic, strong) NSString <Optional>* leverVStr;
@property (nonatomic, strong) NSString <Optional>* name;
@property (nonatomic, strong) NSString <Optional>* author;
@property (nonatomic, strong) NSString <Optional>* lastScore;
@property (nonatomic, strong) NSString <Optional>* curHighScore;
@property (nonatomic, strong) NSString <Optional>* playTotal;
@property (nonatomic, strong) NSString <Optional>* code;
@property (nonatomic, strong) NSString <Optional>* url;
@property (nonatomic, strong) NSString <Optional>* modelMd5;


@property (nonatomic, strong) NSString <Optional>* time;



@end

NS_ASSUME_NONNULL_END

/*
 {
beforeClass = "<null>";
calorie = 1570;
code = 402010290;
content = "<null>";
cover = "https://pub.hidbb.com/customer-dev/ai/4af80f5719774fe0919c7dc9d90f0f72.jpg";
createTime = "2020-10-30 11:25:39";
creatorId = 360;
delFlag = 0;
detailCover = "<null>";
downloadNumber = "<null>";
hashValue = "<null>";
id = 17;
lever = 1;
name = "jm\U7684\U6d4b\U8bd5\U89c6\U9891\U554a\U554a\U554a";
size = 0;
status = 1;
time = 32;
updateTime = "2020-10-30 11:37:52";
uploadTime = "2020-10-29 17:41:28";
url = "https://pub.hidbb.com/action/video/7faab3b258c846368ee238bd23041873_360.mp4";
version = 2;
voiceIds = "3,2,1";
}
 */
