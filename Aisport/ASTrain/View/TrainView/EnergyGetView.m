//
//  EnergyGetView.m
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import "EnergyGetView.h"
#import "LFWave.h"

@interface EnergyGetView ()
{
    LFWave *_wave;
    float _totalScore;
}

@end

@implementation EnergyGetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _totalScore = 0;
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 57, 101)];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor colorWithHex:@"#414141"];
        bgView.layer.cornerRadius = 57.0/2;
        bgView.clipsToBounds = YES;
        
//        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, frame.size.width, 15)];
//        [self addSubview:numberLabel];
//        numberLabel.font = fontBold(19);
//        numberLabel.textColor = [UIColor whiteColor];
//        numberLabel.textAlignment = NSTextAlignmentCenter;
//        numberLabel.text = @"0";
//        _numberLabel = numberLabel;
        
        
//        UIImageView *energyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width/2-10/2, numberLabel.bottom+10, 10, 15)];
//        [self addSubview:energyImageView];
//        energyImageView.image = [UIImage imageNamed:@"train_Energy"];
//        energyImageView.contentMode = UIViewContentModeScaleAspectFill;
//        energyImageView.clipsToBounds = YES;
        
        UIView *currentView = [[UIView alloc] initWithFrame:CGRectMake(0, 101-0, 57, 0)];
        [bgView addSubview:currentView];
        currentView.backgroundColor = [UIColor colorWithHex:@"#1bc2b1"];
//        currentView.layer.cornerRadius = 57.0/2;
//        currentView.clipsToBounds = YES;
        [self setViewBottomCornerWithView:currentView];
        _currentView = currentView;
        
        [self buildLayout];
        
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
        
    }
    return self;
}

- (void)buildLayout {
    
    _wave = [[LFWave alloc] initWithFrame:self.bounds];
    _wave.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    [self addSubview:_wave];
    
    [_wave start];
}

//总长101
- (void)setValue:(float)value
{
    _value = value;
    int value1 = round(value);
    self.numberLabel.text = [NSString stringWithFormat:@"%lld",[self.numberLabel.text longLongValue]+value1];
    _totalScore = [self.numberLabel.text longLongValue]/10000.0;
    
//    CGFloat height = _currentView.frame.size.height;
//    float addHeith = value/1000.0;
////    CGFloat num = 10;
////    CGFloat height = _currentView.frame.size.height+num;
//    [UIView animateWithDuration:0.1 animations:^{
//        self.currentView.frame = CGRectMake(0, 101-height-101.0*addHeith, 57, height+101.0*addHeith);
////        self.currentView.frame = CGRectMake(0, 101-height, 57, height);
//        [self setViewBottomCornerWithView:self.currentView];
//
//        } completion:^(BOOL finished) {
////            self.currentView.frame = CGRectMake(0, 101-height, 57, height);
//
//        }];
    
    _wave.progress = _totalScore;
    
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

#pragma mark -
#pragma mark 功能方法
- (void)start {
    [_wave start];
}

- (void)stop {
    [_wave stop];
}

- (void)dealloc {
    [_wave stop];
    [_wave removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
