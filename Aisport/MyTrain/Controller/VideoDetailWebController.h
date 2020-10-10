//
//  VideoDetailWebController.h
//  Aisport
//
//  Created by Apple on 2020/11/25.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailWebController : BaseViewController

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *codeId;
@property (nonatomic, strong) NSString *modelMd5;
@property (nonatomic, strong) CourseModel *videoTRModel;

@property (nonatomic, assign) int fromType; //1 跳转到详情。 2 跳转到搜素  3 跳到结果页

@end

NS_ASSUME_NONNULL_END
