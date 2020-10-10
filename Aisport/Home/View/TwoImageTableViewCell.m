//
//  TwoImageTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "TwoImageTableViewCell.h"

@implementation TwoImageTableViewCell
{
    NSArray *_list;
}

+ (CGFloat)cellHeight
{
    return UIValue(164 + 34 + 3+ 10 );
}

- (void)initSelf
{
    
    CGFloat width = (SCR_WIDTH - UIValue(16*3)) /2.0;
    self.videoView1 = [[VideoCoverView alloc] initWithFrame:CGRectMake(UIValue(16), 0, width, UIValue(164 + 34 + 3))];
    [self.videoView1 layout];
    [self.contentView addSubview:self.videoView1];
    [self.videoView1.tapBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];

    self.videoView2 = [[VideoCoverView alloc] initWithFrame:CGRectMake(UIValue(16), 0, width, UIValue(164 + 34 + 3))];
    [self.videoView2 layout];
    self.videoView2.left = self.videoView1.right + UIValue(16);
    [self.contentView addSubview:self.videoView2];
    self.videoView2.tapBtn.tag = 1;
    [self.videoView2.tapBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)fillData:(id)data
{
    NSArray *list = data[@"data"];
    _list = list;

    self.tapBlock = data[@"block"];
    
    if ([list count] > 0) {
        [self setViewData:list[0] view:self.videoView1];
    }
    
    if ([list count] > 1) {
        self.videoView2.hidden = NO;
        [self setViewData:list[1] view:self.videoView2];
    } else {
        self.videoView2.hidden = YES;
    }
}

- (void)setViewData:(id)data view:(VideoCoverView *)view
{
    NSString *cover = data[@"cover"];
    NSString *playTotal = [data[@"playTotal"] description];
    NSNumber *curHighScore = data[@"curHighScore"];

    if ([curHighScore isEqual:[NSNull null]]) {
        curHighScore = @(0);
    }
    
    NSString *name = data[@"name"];
    NSNumber *lever = data[@"lever"];
    
    [view setLev:[lever intValue]];
    
    view.titleLabel.text = name;
    
    [view.coverView sd_setImageWithURL:[NSURL URLWithString:StringForId(cover)] placeholderImage:nil];

    view.playLabel.text = [NSString stringWithFormat:@"当前记录：%@", playTotal];
    [view.hotBtn setTitle:[curHighScore description] forState:UIControlStateNormal];
    
}

- (void)tapAction:(UIButton *)btn
{
    !self.tapBlock ?: self.tapBlock(_list[btn.tag]);
}


@end
