//
//  JXRefreshFooter.m
//  新能源金服
//
//  Created by admxjx on 2017/3/14.
//  Copyright © 2017年 玖远投资. All rights reserved.
//

#import "JXRefreshFooter.h"

@implementation JXRefreshFooter

-(instancetype)init
{
    self = [super init];
    if (self) {
        //自动改变透明度 （当控件被导航条挡住后不显示）
        self.automaticallyChangeAlpha = YES;
        
        // 设置各种状态下的刷新文字
        [self setTitle:@"上拉可以刷新" forState:MJRefreshStateIdle];
        [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        [self setTitle:@"---没有更多内容啦---" forState:MJRefreshStateNoMoreData];
        
        // 设置字体
        self.stateLabel.font = FontSize(13);

        // 设置颜色
        self.stateLabel.textColor = [UIColor grayColor];
        
//        //初始化时开始刷新
//        [self beginRefreshing];
    }
    return self;
}

@end
