//
//  JXRefreshHeader.m
//  新能源金服
//
//  Created by admxjx on 2017/3/14.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import "JXRefreshHeader.h"

@implementation JXRefreshHeader

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        //自动改变透明度 （当控件被导航条挡住后不显示）
        self.automaticallyChangeAlpha = YES;
        //隐藏时间
        self.lastUpdatedTimeLabel.hidden = YES;
        
        // 设置各种状态下的刷新文字
        [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        
        
        // 设置字体
        self.stateLabel.font = FontSize(13);
        self.lastUpdatedTimeLabel.font = FontSize(13);
        
        // 设置颜色
        self.stateLabel.textColor = [UIColor grayColor];
        self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
        
//        //初始化时开始刷新
//        [self beginRefreshing];
        
    }
    return self;
}


@end
