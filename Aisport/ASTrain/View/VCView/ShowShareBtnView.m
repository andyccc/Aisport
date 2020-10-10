//
//  ShowShareBtnView.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "ShowShareBtnView.h"

@implementation ShowShareBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
        
        CAShapeLayer *mask=[CAShapeLayer layer];
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft  cornerRadii:CGSizeMake(18,18)];
        mask.path = path.CGPath;
        mask.frame = self.bounds;
        
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        borderLayer.path = path.CGPath;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        //        borderLayer.strokeColor = [UIColor colorWithHex:@"#FDAB00"].CGColor;
        //        borderLayer.lineWidth = 1;
        borderLayer.frame = self.bounds;
        self.layer.mask = mask;
        [self.layer addSublayer:borderLayer];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-100, 18, 200, 15)];
        [self addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = fontBold(15);
        titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        titleLabel.text = @"分享给好友";
        
//        NSArray *btnTiArr = @[@"保存到相册",@"微信好友",@"微信朋友圈"];
//        NSArray *btnImageArr = @[@"download",@"wechat",@"pengyouquan"];
        NSArray *btnTiArr = @[@"微信好友",@"微信朋友圈"];
        NSArray *btnImageArr = @[@"wechat",@"pengyouquan"];
        CGFloat btnW = SCR_WIDTH/btnImageArr.count;
        for (int i = 0; i < btnTiArr.count; i++) {
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(btnW*i, 62, btnW, 35+9+10)];
            [self addSubview:button];
            button.tag = i;
            [button setTitle:btnTiArr[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHex:@"#333333"] forState:UIControlStateNormal];
            button.titleLabel.font = fontApp(10);
            [button setImage:[UIImage imageNamed:btnImageArr[i]] forState:UIControlStateNormal];
            [button layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleTop imageTitleSpace:9];
            button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            [button addTarget:self action:@selector(ClickShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return self;
}

- (void)ClickShareBtn:(UIButton *)sender
{
    if (self.clickShareBlock) {
        self.clickShareBlock(sender.tag);
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
