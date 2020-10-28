//
//  TrainEndView.m
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import "TrainEndView.h"

@implementation TrainEndView

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
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 248, 324)];
    whiteView.backgroundColor = [UIColor colorWithHex:@"#564E6B"];
    whiteView.layer.cornerRadius = 5;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    whiteView.center = CGPointMake(SCR_WIDTH/2, SCR_HIGHT/2);
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, whiteView.width, 17)];
    [whiteView addSubview:titleLabel];
    titleLabel.textColor = [UIColor colorWithHex:@"#FFFFFF"];
    titleLabel.font = fontBold(17);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"恭喜您获得勋章";
    
    UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.bottom+25, whiteView.width, 17)];
    [whiteView addSubview:rankLabel];
    rankLabel.textColor = [UIColor colorWithHex:@"#1BC2B1"];
    rankLabel.font = fontBold(17);
    rankLabel.textAlignment = NSTextAlignmentCenter;
    rankLabel.text = @"帕梅拉初级挑战者";
    
    UIImageView *rankImageView = [[UIImageView alloc] initWithFrame:CGRectMake(whiteView.width/2-111.0/2, rankLabel.bottom+17, 111, 126)];
    [whiteView addSubview:rankImageView];
    rankImageView.image = [UIImage imageNamed:@"train_rank"];
    rankImageView.contentMode = UIViewContentModeScaleAspectFill;
    rankImageView.clipsToBounds = YES;
    
    UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(whiteView.width/2-181.0/2, whiteView.height-23-44, 181, 44)];
    [whiteView addSubview:sureButton];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
    sureButton.titleLabel.font = fontBold(17);
    sureButton.layer.cornerRadius = 44.0/2;
    sureButton.clipsToBounds = YES;
    [sureButton addTarget:self action:@selector(clicSureButton) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)clicSureButton
{
    if (self.clicSureBtnBlock) {
        self.clicSureBtnBlock();
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
