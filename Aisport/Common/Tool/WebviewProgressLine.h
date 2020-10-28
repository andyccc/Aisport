//
//  WebviewProgressLine.h
//  EliteHeadlines
//
//  Created by 田桔 on 2018/9/25.
//  Copyright © 2018年 GJesus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebviewProgressLine : UIView

//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;

@end
