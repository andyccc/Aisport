//
//  MyWholeVideoListModel.h
//  Aisport
//
//  Created by Apple on 2020/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyWholeVideoListModel : NSObject

@property (nonatomic, strong) NSString * cid;
@property (nonatomic, strong) NSString *cname;
@property (nonatomic, strong) NSDictionary *lastPlayInfo;
@property (nonatomic, strong) NSArray *videoList;

@end

NS_ASSUME_NONNULL_END

/*
 {
cname = "Auto-HJ_1112101736";
lastPlayInfo = "<null>";
videoList =             (
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
);
}
 */



/*
 lastPlayInfo =             {
     beforeClass = "[\"\U591a\U4f11\U606f\"]";
     calorie = 200;
     code = 4020103014;
     content = "\U89c6\U9891\U4ecb\U7ecd";
     cover = "https://pub.hidbb.com/ai-dev/ai/0dcb3fc155a14af3ba3185981faae1e7.png";
     createTime = "2020-11-13 10:56:32";
     creatorId = 360;
     delFlag = 0;
     detailCover = "<null>";
     downloadNumber = "<null>";
     hashValue = 2b1b9ad61d1373a4558dab738b8cfc7;
     id = 63;
     lever = 1;
     name = "\U5e15\U6885\U62c9\U6709\U6c27\U64cd";
     size = 44131121;
     status = 1;
     time = 851;
     updateTime = "2020-11-13 11:15:54";
     uploadTime = "2020-10-30 15:08:43";
     url = "https://pub.hidbb.com/ai-dev/ai-video/84d670d261bc4947b780ce5be42e703a.mp4";
     version = "2.2";
     voiceIds = "146,145,144,142,141,139,126,124,129,131,133,134,135,137,138";
 }
 */
