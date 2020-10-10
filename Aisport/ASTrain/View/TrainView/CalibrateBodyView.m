//
//  CalibrateBodyView.m
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import "CalibrateBodyView.h"

@implementation CalibrateBodyView

- (instancetype)initWithFrame:(CGRect)frame IsTV:(BOOL)isTV
{
    if (self = [super initWithFrame:frame]) {
        [self setMainViewWithIsTV:isTV];
    }
    return self;
}

- (void)setMainViewWithIsTV:(BOOL)isTV
{
    CGFloat max = MAX(SCR_WIDTH, SCR_HIGHT);
    CGFloat min = MIN(SCR_WIDTH, SCR_HIGHT);
    
    //WithFrame:CGRectMake(max/2-385.0/4, min/2-678.0/4, 385.0/2, 678/2)
    UIImageView *picImageView = [[UIImageView alloc] init];
    if (!isTV) {
        picImageView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
        picImageView.image = [UIImage imageNamed:@"train_veribody"];//train_shoujibody
    }else{
        picImageView.frame = CGRectMake(max/2-385.0/4, min/2-678.0/4, 385.0/2, 678/2);
        picImageView.image = [UIImage imageNamed:@"train_body"];
    }
    [self addSubview:picImageView];
    picImageView.contentMode = UIViewContentModeScaleAspectFill;
    picImageView.clipsToBounds = YES;
//    picImageView.image = [UIImage imageNamed:@"train_body"];
    _picImageView = picImageView;
    
    //WithFrame:CGRectMake(0, 0, max, min)
    UIView *coverView = [[UIView alloc] init];
    if (!isTV) {
        coverView.frame = CGRectMake(0, 0, SCR_WIDTH, SCR_HIGHT);
    }else{
        coverView.frame = CGRectMake(0, 0, max, min);
    }
    [self addSubview:coverView];
    coverView.backgroundColor = [UIColor colorWithHex:@"#ffc1c1" alpha:0.79];
    
    UIBezierPath* bpath = [UIBezierPath bezierPathWithRect:coverView.frame];
//    if (!isTV) {
//        CGRect covRect = CGRectMake(max/2-678.0/4, min/2-385.0/4, 678.0/2, 385.0/2);
//    }else{
//        CGRect covRect = CGRectMake(max/2-385.0/4, min/2-678.0/4, 385.0/2, 678/2);
//    }
    //CGRectMake(max/2-385.0/4, min/2-678.0/4, 385.0/2, 678/2)
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:picImageView.frame cornerRadius:15];
    [bpath appendPath:path];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    shapeLayer.path = bpath.CGPath;
        //添加图层蒙板
    coverView.layer.mask = shapeLayer;
    
    _coverView = coverView;
    
    
    
    
    
    UILabel *botoomTiLab = [[UILabel alloc] initWithFrame:CGRectMake(picImageView.left, picImageView.bottom-40, picImageView.width, 13)];
    [self addSubview:botoomTiLab];
    botoomTiLab.textColor = [UIColor whiteColor];
    botoomTiLab.font = fontApp(13);
    botoomTiLab.textAlignment = NSTextAlignmentCenter;
    botoomTiLab.text = @"调整身体到虚线框内";
    _botoomTiLab = botoomTiLab;
    if (!isTV) {
        botoomTiLab.hidden = YES;
    }else{
//        coverView.frame = CGRectMake(0, 0, max, min);
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
