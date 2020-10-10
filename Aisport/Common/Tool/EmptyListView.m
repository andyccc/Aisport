//
//  EmptyListView.m
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import "EmptyListView.h"
#import "NSString+getHeight.h"

@implementation EmptyListView

- (instancetype)initWithFrame:(CGRect)frame AndType:(EmptyViewStyle)style
{
    if (self = [super initWithFrame:frame]) {
        NSArray *titles = @[@"还没有添加合集哦，\n从“合集推荐”中挑选一个吧~",@"收藏内空空如也~",@"暂无数据"];
        NSArray *icons = @[@"nothing_hejilist",@"nothing_shoucang",@"nothing_hejilist"];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-134*Screen_Scale, 0, 134*2*Screen_Scale, 88*2*Screen_Scale)];
        [self addSubview:iconImageView];
        iconImageView.image = [UIImage imageNamed:icons[style]];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.clipsToBounds = YES;
        
        
        CGFloat titleH = [NSString getHeightWithText:titles[style] andWithWidth:frame.size.width-26*2 andWithFont:fontApp(11)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, iconImageView.bottom+24, frame.size.width-26*2, titleH)];
        [self addSubview:titleLabel];
        titleLabel.textColor = [UIColor colorWithHex:@"#999999"];
        titleLabel.font = fontApp(11);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.text = titles[style];
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
