//
//  EnergyGetView.m
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import "EnergyGetView.h"

@implementation EnergyGetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 57, 101)];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor colorWithHex:@"#414141"];
        bgView.layer.cornerRadius = 57.0/2;
        bgView.clipsToBounds = YES;
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, frame.size.width, 15)];
        [self addSubview:numberLabel];
        numberLabel.font = fontBold(19);
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.text = @"0";
        _numberLabel = numberLabel;
        
        
        UIImageView *energyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-10/2, numberLabel.bottom+10, 10, 15)];
        [self addSubview:energyImageView];
        energyImageView.image = [UIImage imageNamed:@"train_Energy"];
        energyImageView.contentMode = UIViewContentModeScaleAspectFill;
        energyImageView.clipsToBounds = YES;
        
        UIView *currentView = [[UIView alloc] initWithFrame:CGRectMake(0, 101-0, 57, 0)];
        [bgView addSubview:currentView];
        currentView.backgroundColor = [UIColor colorWithHex:@"#1bc2b1"];
//        currentView.layer.cornerRadius = 57.0/2;
//        currentView.clipsToBounds = YES;
        [self setViewBottomCornerWithView:currentView];
        _currentView = currentView;
        
        
        
    }
    return self;
}

//总长101
- (void)setValue:(long)value
{
    _value = value;
    self.numberLabel.text = [NSString stringWithFormat:@"%lld",[self.numberLabel.text longLongValue]+value];
    CGFloat height = _currentView.frame.size.height;
    float addHeith = value/1000.0;
//    CGFloat num = 10;
//    CGFloat height = _currentView.frame.size.height+num;
    [UIView animateWithDuration:0.1 animations:^{
        self.currentView.frame = CGRectMake(0, 101-height-101.0*addHeith, 57, height+101.0*addHeith);
//        self.currentView.frame = CGRectMake(0, 101-height, 57, height);
        [self setViewBottomCornerWithView:self.currentView];
        
        } completion:^(BOOL finished) {
//            self.currentView.frame = CGRectMake(0, 101-height, 57, height);
            
        }];
    
}

- (void)setViewBottomCornerWithView:(UIView *)cornerView
{
    CAShapeLayer *mask=[CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.currentView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight  cornerRadii:CGSizeMake(57.0/2,57.0/2)];
    mask.path = path.CGPath;
    mask.frame = self.currentView.bounds;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = path.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    //        borderLayer.strokeColor = [UIColor colorWithHex:@"#FDAB00"].CGColor;
    //        borderLayer.lineWidth = 1;
    borderLayer.frame = self.currentView.bounds;
    self.currentView.layer.mask = mask;
    [self.currentView.layer addSublayer:borderLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
