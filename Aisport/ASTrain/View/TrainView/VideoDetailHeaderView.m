//
//  VideoDetailHeaderView.m
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import "VideoDetailHeaderView.h"
#import "VideoDetailInfoModel.h"

#define View_Height  UIValue(210)

@implementation VideoDetailHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.videoImageView];
    }
    return self;
}

- (void)fillData:(VideoDetailInfoModel *)data
{
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:data.detailCover]];
}

- (UIImageView *)videoImageView
{
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, View_Height)];
        _videoImageView.backgroundColor = [UIColor blackColor];
    }
    return _videoImageView;
}

+ (CGFloat)cellHeight
{
    return View_Height;
}

@end
