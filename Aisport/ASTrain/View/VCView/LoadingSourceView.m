//
//  LoadingSourceView.m
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import "LoadingSourceView.h"

@implementation LoadingSourceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setMainView];
    }
    return self;
}

- (void)setMainView
{
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 269, 239)];
    whiteView.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
    whiteView.layer.cornerRadius = 5;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    whiteView.center = CGPointMake(SCR_WIDTH/2, SCR_HIGHT/2);
    
    
    UILabel * loadTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, whiteView.width, 23)];
    loadTitleLabel.text = @"正在加载资源";
    loadTitleLabel.textColor = [UIColor colorWithHex:@"#000000"];
    loadTitleLabel.textAlignment = NSTextAlignmentCenter;
    loadTitleLabel.font = fontBold(18);
    [whiteView addSubview:loadTitleLabel];
    
    TRClassProgressView *progressView = [[TRClassProgressView alloc] initWithFrame:CGRectMake(whiteView.width/2-86/2, 71, 86, 86)];
    [whiteView addSubview:progressView];
    _progressView = progressView;
    
    UIButton *cancleBtn = [[UIButton alloc] initWithFrame:CGRectMake(whiteView.width/2-100/2, whiteView.height-34-28, 100, 34)];
    [whiteView addSubview:cancleBtn];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
    cancleBtn.layer.cornerRadius = 34/2;
    cancleBtn.layer.borderWidth = 1;
    cancleBtn.layer.borderColor = [[UIColor colorWithHex:@"#999999"] CGColor];
    [cancleBtn addTarget:self action:@selector(cancleLoadingSource) forControlEvents:UIControlEventTouchUpInside];
}


- (void)cancleLoadingSource
{
    if (self.cancleLoadingBlock) {
        self.cancleLoadingBlock();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
