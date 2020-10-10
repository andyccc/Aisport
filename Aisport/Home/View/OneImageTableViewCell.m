//
//  OneImageTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "OneImageTableViewCell.h"

@implementation OneImageTableViewCell
{
    id _data;
}


+ (CGFloat)cellHeight
{
    return UIValue(164 + 34 + 3+ 10 );
}

- (void)initSelf
{
    self.videoView = [[VideoCoverView alloc] initWithFrame:CGRectMake(UIValue(16), 0, SCR_WIDTH - UIValue(32), UIValue(164 + 34 + 3))];
    [self.contentView addSubview:self.videoView];
    self.videoView.coverView.height = UIValue(164);
    [self.videoView layout];
    [self.videoView.tapBtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapAction
{
    !self.tapBlock ?: self.tapBlock(_data);
}

- (void)fillData:(id)data
{
    _data = data[@"data"];
    
    self.tapBlock = data[@"block"];
    
    NSString *cover = _data[@"cover"];
    NSString *playTotal = [_data[@"playTotal"] description];
    NSNumber *curHighScore = _data[@"curHighScore"];

    if ([curHighScore isEqual:[NSNull null]]) {
        curHighScore = @(0);
    }

    NSString *name = _data[@"name"];
    NSNumber *lever = _data[@"lever"];
    
    [self.videoView setLev:[lever intValue]];
    self.videoView.titleLabel.text = name;
    
    [self.videoView.coverView sd_setImageWithURL:[NSURL URLWithString:StringForId(cover)] placeholderImage:nil];

    self.videoView.playLabel.text = [NSString stringWithFormat:@"当前记录：%@", playTotal];
    [self.videoView.hotBtn setTitle:[curHighScore description] forState:UIControlStateNormal];
    self.videoView.hotBtn.right = SCR_WIDTH - UIValue(16);
    

}

@end
