//
//  CTEmitter.m
//  CTEmitterAnimation
//
//  Created by Apple on 2020/11/3.
//

#import "CTEmitter.h"
#import <QuartzCore/CoreAnimation.h>

@interface CTEmitter ()

@property (nonatomic,strong) CAEmitterLayer *ringEmitter;

@property (nonatomic,strong) CAEmitterLayer *outherringEmitter;

@property (nonatomic,strong) CAEmitterLayer *threeringEmitter;
@property (nonatomic,strong) CAEmitterLayer *fourringEmitter;

@end

@implementation CTEmitter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor blackColor];
        // Initialization code
//        [self makeEmitter];
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        [self addSubview:label];
//        label.text = @"PERFECT";
//        label.font = fontApp(31);
//        label.textAlignment = NSTextAlignmentCenter;
//        label.hidden = YES;
//        _label = label;
    }
    return self;
}

//- (void)make

- (void)makeEmitter
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
    emitterLayer.position        = CGPointMake((98+40)/2, (98+40)/2);
    emitterLayer.emitterPosition = CGPointMake(-98/2, -20);
//    emitterLayer.emitterPosition = CGPointMake(0, -20);
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerCircle; //发射器形状
    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
//    emitterLayer.seed = 20;
//    emitterLayer.spin = 3.0;
    
    CAEmitterCell *emitterCell              = [CAEmitterCell emitterCell];
//    emitterCell.scale = 0.3;
//    emitterCell.scaleRange = 0.1;
    [emitterCell setName:@"emitterCell"];
    emitterCell.contents         = (__bridge id)[UIImage imageNamed:@"shanyao"].CGImage;
    emitterCell.birthRate        = 1;       //出生率
    emitterCell.lifetime         = 0.8;            //生存时间
    emitterCell.velocity         = 30;          //发射速度
    emitterCell.velocityRange    = 0;    //发射的范围
//    emitterCell.alphaSpeed       = -0.4;  //透明度递增速度
    emitterCell.emissionRange    = M_PI *2.0; //发射角度
    emitterLayer.emitterCells    = [NSArray arrayWithObject:emitterCell];

    CAEmitterCell *emitterCell1              = [CAEmitterCell emitterCell];
    emitterCell1.scale = 0.8;
//    emitterCell1.scaleRange = 0.05;
    [emitterCell1 setName:@"emitterCell"];
    emitterCell1.beginTime = 0.4;
    emitterCell1.contents         = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
    emitterCell1.birthRate        = 1;       //出生率
    emitterCell1.lifetime         = 0.7;            //生存时间
    emitterCell1.velocity         = 35;          //发射速度
    emitterCell1.velocityRange    = 35;    //发射的范围
    emitterCell.alphaSpeed       = -0.4;  //透明度递增速度
    emitterCell1.emissionLongitude    = M_PI*2.0; //发射角度
//    emitterCell.emitterCells    = [NSArray arrayWithObject:emitterCell1];
    
    
    
    
    
//    CAEmitterCell *emitterCell1              = [CAEmitterCell emitterCell];
//    emitterCell1.scale = 0.2;
//    [emitterCell1 setName:@"emitterCell1"];
//    emitterCell1.contents         = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
//    emitterCell1.birthRate        = 10;       //出生率
//    emitterCell1.lifetime         = 5;            //生存时间
//    emitterCell1.velocity         = 70;          //发射速度
//    emitterCell1.velocityRange    = 10;    //发射的范围
//    emitterCell1.alphaSpeed       = -0.4;  //透明度递增速度
//    emitterCell1.emissionRange    = M_PI *2.0; //发射角度
//    emitterLayer.emitterCells    = [NSArray arrayWithObject:emitterCell];
    
//    emitterLayer.emitterCells = [NSArray arrayWithObjects:emitterCell,emitterCell, nil];
    [self.layer addSublayer:emitterLayer];
    _ringEmitter = emitterLayer;
    
    [self makeEmitter1];
    [self makeEmitter2];
    [self makeEmitter3];
}


- (void)makeEmitter1
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
    emitterLayer.position        = CGPointMake((98+40)/2, (98+40)/2);
    emitterLayer.emitterPosition = CGPointMake(98/2, -20);
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerCircle; //发射器形状
    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
//    emitterLayer.seed = 20;
//    emitterLayer.spin = 3.0;
    
    CAEmitterCell *emitterCell              = [CAEmitterCell emitterCell];
//    emitterCell.scale = 0.3;
//    emitterCell.scaleRange = 0.1;
    [emitterCell setName:@"otheremitterCell"];
    emitterCell.contents         = (__bridge id)[UIImage imageNamed:@"shanyao"].CGImage;
    emitterCell.birthRate        = 1;       //出生率
    emitterCell.lifetime         = 0.8;            //生存时间
    emitterCell.velocity         = 30;          //发射速度
    emitterCell.velocityRange    = 0;    //发射的范围
//    emitterCell.alphaSpeed       = -0.4;  //透明度递增速度
    emitterCell.emissionRange    = M_PI *2.0; //发射角度
    emitterLayer.emitterCells    = [NSArray arrayWithObject:emitterCell];

    CAEmitterCell *emitterCell1              = [CAEmitterCell emitterCell];
//    emitterCell1.scale = 0.8;
//    emitterCell1.scaleRange = 0.05;
    [emitterCell1 setName:@"emitterCell"];
    emitterCell1.beginTime = 0.4;
    emitterCell1.contents         = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
    emitterCell1.birthRate        = 1;       //出生率
    emitterCell1.lifetime         = 0.7;            //生存时间
    emitterCell1.velocity         = 35;          //发射速度
    emitterCell1.velocityRange    = 35;    //发射的范围
    emitterCell.alphaSpeed       = -0.4;  //透明度递增速度
    emitterCell1.emissionLongitude    = M_PI*2.0; //发射角度
//    emitterCell.emitterCells    = [NSArray arrayWithObject:emitterCell1];
    
    
    
    
    
//    CAEmitterCell *emitterCell1              = [CAEmitterCell emitterCell];
//    emitterCell1.scale = 0.2;
//    [emitterCell1 setName:@"emitterCell1"];
//    emitterCell1.contents         = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
//    emitterCell1.birthRate        = 10;       //出生率
//    emitterCell1.lifetime         = 5;            //生存时间
//    emitterCell1.velocity         = 70;          //发射速度
//    emitterCell1.velocityRange    = 10;    //发射的范围
//    emitterCell1.alphaSpeed       = -0.4;  //透明度递增速度
//    emitterCell1.emissionRange    = M_PI *2.0; //发射角度
//    emitterLayer.emitterCells    = [NSArray arrayWithObject:emitterCell];
    
//    emitterLayer.emitterCells = [NSArray arrayWithObjects:emitterCell,emitterCell, nil];
    [self.layer addSublayer:emitterLayer];
    _outherringEmitter = emitterLayer;
}

- (void)makeEmitter2
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
    emitterLayer.position        = CGPointMake((98+40)/2, (98+40)/2);
    emitterLayer.emitterPosition = CGPointMake(0, -20);
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerLine; //发射器形状
    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
//    emitterLayer.seed = 20;
//    emitterLayer.spin = 3.0;
    
    CAEmitterCell *emitterCell              = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.5;
    emitterCell.scaleRange = 0.3;
    [emitterCell setName:@"threeemitterCell"];
    emitterCell.contents         = (__bridge id)[UIImage imageNamed:@"shanyao"].CGImage;
    emitterCell.birthRate        = 1;       //出生率
    emitterCell.lifetime         = 0.8;            //生存时间
    emitterCell.velocity         = 50;          //发射速度
    emitterCell.velocityRange    = 0;    //发射的范围
//    emitterCell.alphaSpeed       = -0.4;  //透明度递增速度
    emitterCell.emissionRange    = M_PI *2.0; //发射角度
    emitterLayer.emitterCells    = [NSArray arrayWithObject:emitterCell];

    CAEmitterCell *emitterCell1              = [CAEmitterCell emitterCell];
    emitterCell1.scale = 0.7;
//    emitterCell1.scaleRange = 0.05;
    [emitterCell1 setName:@"emitterCell"];
    emitterCell1.beginTime = 0.2;
    emitterCell1.contents         = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
    emitterCell1.birthRate        = 1;       //出生率
    emitterCell1.lifetime         = 0.7;            //生存时间
    emitterCell1.velocity         = 35;          //发射速度
    emitterCell1.velocityRange    = 35;    //发射的范围
    emitterCell.alphaSpeed       = -0.4;  //透明度递增速度
    emitterCell1.emissionLongitude    = M_PI*2.0; //发射角度
//    emitterCell.emitterCells    = [NSArray arrayWithObject:emitterCell1];
    
    
    
    
    
//    CAEmitterCell *emitterCell1              = [CAEmitterCell emitterCell];
//    emitterCell1.scale = 0.2;
//    [emitterCell1 setName:@"emitterCell1"];
//    emitterCell1.contents         = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
//    emitterCell1.birthRate        = 10;       //出生率
//    emitterCell1.lifetime         = 5;            //生存时间
//    emitterCell1.velocity         = 70;          //发射速度
//    emitterCell1.velocityRange    = 10;    //发射的范围
//    emitterCell1.alphaSpeed       = -0.4;  //透明度递增速度
//    emitterCell1.emissionRange    = M_PI *2.0; //发射角度
//    emitterLayer.emitterCells    = [NSArray arrayWithObject:emitterCell];
    
//    emitterLayer.emitterCells = [NSArray arrayWithObjects:emitterCell,emitterCell, nil];
    [self.layer addSublayer:emitterLayer];
    _threeringEmitter = emitterLayer;
}


- (void)makeEmitter3
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
    emitterLayer.position        = CGPointMake((98+40)/2, (98+40)/2);
    emitterLayer.emitterPosition = CGPointMake(0, -20);
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerCircle; //发射器形状
    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
//    emitterLayer.seed = 20;
//    emitterLayer.spin = 3.0;
    
    CAEmitterCell *emitterCell              = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.5;
//    emitterCell.scaleRange = 0.2;
    [emitterCell setName:@"fouremitterCell"];
    emitterCell.contents         = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
    emitterCell.birthRate        = 1;       //出生率
    emitterCell.lifetime         = 1.0;            //生存时间
    emitterCell.velocity         = 100;          //发射速度
//    emitterCell.velocityRange    = 20;    //发射的范围
//    emitterCell.alphaSpeed       = -0.4;  //透明度递增速度
    emitterCell.emissionRange    = M_PI *2.0; //发射角度
    emitterCell.alphaRange = 0.8;
    emitterCell.alphaSpeed = +1.0;
    emitterLayer.emitterCells    = [NSArray arrayWithObject:emitterCell];
    
    
    
//    emitterLayer.emitterCells = [NSArray arrayWithObjects:emitterCell,emitterCell, nil];
    [self.layer addSublayer:emitterLayer];
    _fourringEmitter = emitterLayer;
}


- (void)initFireworks
{

   CAEmitterLayer *emitter = [CAEmitterLayer layer];
   emitter.frame = self.bounds;
   [self.layer addSublayer:emitter];
   
//   emitter.renderMode = kCAEmitterLayerAdditive;
   emitter.emitterPosition = CGPointMake(emitter.frame.size.width/2, emitter.frame.size.height+5);
//   emitter.emitterSize = CGSizeMake(emitter.frame.size.width, emitter.frame.size.height);
    
    emitter.emitterShape = kCAEmitterLayerPoint;
    
    //发射模式，这个字段规定了在特定形状上发射的具体形式是什么
    emitter.emitterMode = kCAEmitterLayerOutline;
   
   CAEmitterCell *cell = [[CAEmitterCell alloc] init];
   cell.contents = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;
   cell.birthRate = 1000;
   cell.lifetime = 0.3;
   cell.alphaSpeed = -0.4;
   cell.velocity = 50;
   cell.velocityRange = 30;
   cell.emissionRange = M_PI *2.0;
   cell.scale = 0.1;
//   cell.yAcceleration
   cell.scaleRange    = 0.05;
//    cell.minificatonFilter =
    
    CAEmitterCell *cell2 = [[CAEmitterCell alloc] init];
    cell2.contents = (__bridge id)[UIImage imageNamed:@"perfect"].CGImage;//perfect  shanyao
    cell2.birthRate = 1000;
    cell2.lifetime = 0.3;
    cell2.alphaSpeed = -0.4;
    cell2.velocity = 50;
    cell2.velocityRange = 30;
    cell2.emissionRange = M_PI *2.0;
    cell2.scale = 0.5;
 //   cell.yAcceleration
    cell2.scaleRange    = 0.05;
  
   emitter.emitterCells = @[cell,cell2];
}

//- (void)makeEmitter{
//    CGRect viewBounds = self.layer.bounds;
//
//
//    self.ringEmitter = [CAEmitterLayer layer];
//
//    self.ringEmitter.emitterPosition = CGPointMake(viewBounds.size.width/2.0f, viewBounds.size.height/2.0f);
//    self.ringEmitter.emitterSize    = CGSizeMake(50, 0);
//    self.ringEmitter.emitterMode    = kCAEmitterLayerOutline;
//    self.ringEmitter.emitterShape    = kCAEmitterLayerCircle;
//    self.ringEmitter.renderMode        = kCAEmitterLayerBackToFront;
//
//    CAEmitterCell* Emitter1 = [CAEmitterCell emitterCell];
//    [Emitter1 setName:@"Emitter1"];
//    Emitter1.birthRate            = 0;
//    Emitter1.velocity            = 40;
//    Emitter1.scale                = 0.5;
//    Emitter1.scaleSpeed            =-0.2;
//    Emitter1.greenSpeed            =-0.2;
//    Emitter1.redSpeed            =-0.5;
//    Emitter1.blueSpeed            =-0.5;
//    Emitter1.lifetime            = 2;
//    Emitter1.color = [self.showColor CGColor];
//
//
//
//    CAEmitterCell* circle = [CAEmitterCell emitterCell];
//    [circle setName:@"circle"];
//    circle.birthRate        = 10;
//    circle.emissionLongitude = M_PI * 0.5 +1;    // 方向
//    circle.zAcceleration  = -1;
//    circle.velocity            = 50;
//    circle.scale            = 0.5;
//    circle.scaleSpeed        = -0.2;
//    circle.greenSpeed        =-0.1;
//    circle.redSpeed            = -0.2;
//    circle.blueSpeed        = 0.1;
//    circle.alphaSpeed        =-0.42;
//    circle.lifetime            = 1;
//    circle.color = [[UIColor whiteColor] CGColor];
//    circle.contents = (id) [[UIImage imageNamed:@"perfect"] CGImage];
//
//
//    CAEmitterCell* ball = [CAEmitterCell emitterCell];
//    [ball setName:@"ball"];
//    ball.birthRate        = 2;
//    ball.velocity        = 140;
//    ball.zAcceleration  = -1;
//    ball.emissionLongitude = -M_PI ;
//    ball.scale            = 1.5;
//    ball.scaleSpeed        =-0.2;
//    ball.greenSpeed        =-0.1;
//    ball.redSpeed        = 0.4;
//    ball.blueSpeed        =-0.1;
//    ball.alphaSpeed        =-0.2;
//    ball.lifetime        = 2.0;
//    ball.color = [[UIColor blueColor] CGColor];
//
//    self.ringEmitter.emitterCells = [NSArray arrayWithObject:Emitter1];
//    Emitter1.emitterCells = [NSArray arrayWithObjects:circle, ball, nil];
//
//    [self.layer addSublayer:self.ringEmitter];
//}
//
//- (void)animationWith:(CGFloat)value{
//
//
//    // 爆炸动画..
//    CABasicAnimation *burst = [CABasicAnimation animationWithKeyPath:@"emitterCells.Emitter1.birthRate"];
////    burst.fromValue            = [NSNumber numberWithFloat: (value-10)*3];
//    burst.fromValue            = [NSNumber numberWithFloat: (value-10)*3];
//    burst.toValue            = [NSNumber numberWithFloat: 0.0];
//    burst.duration            = 0.5;
//    burst.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
//
//    [self.ringEmitter setValue:@(value) forKeyPath:@"emitterCells.Emitter1.velocity"];
//    [self.ringEmitter setValue:@(value) forKeyPath:@"emitterCells.Emitter1.emitterCells.circle.velocity"];
////    [self.ringEmitter setValue:@(value/500) forKeyPath:@"emitterCells.Emitter1.emitterCells.circle.greenSpeed"];//
//    [self.ringEmitter setValue:@(value/5) forKeyPath:@"emitterCells.Emitter1.emitterCells.circle.birthRate"];
//    [self.ringEmitter addAnimation:burst forKey:@"burst"];
//
//    //动画中心位置
//    CGPoint position = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
//
//    [CATransaction begin];
//    [CATransaction setDisableActions: YES];
//    self.ringEmitter.emitterPosition    = position;
//    [CATransaction commit];
//}



- (void)reduceEmitter
{
    [self.fourringEmitter setValue:@(0) forKeyPath:@"emitterCells.fouremitterCell.birthRate"];
    [self.threeringEmitter setValue:@(0) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
    [self.outherringEmitter setValue:@(0) forKeyPath:@"emitterCells.otheremitterCell.birthRate"];
    [self.ringEmitter setValue:@(0) forKeyPath:@"emitterCells.emitterCell.birthRate"];
    [self.ringEmitter setValue:@(0) forKeyPath:@"emitterCells.emitterCell.emitterCellsemitterCell1.birthRate"];
}

- (void)addEmitterWithState:(TRActionState)state
{
//    [self.ringEmitter setValue:@(100) forKeyPath:@"emitterCells.emitterCell.birthRate"];

    if (state == GOOD) {
        [self.threeringEmitter setValue:@(50) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
    }else if (state == SUPER){
        [self.threeringEmitter setValue:@(50) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
    }else if (state == PERFECT){
        [self.ringEmitter setValue:@(30) forKeyPath:@"emitterCells.emitterCell.birthRate"];
        [self.ringEmitter setValue:@(1) forKeyPath:@"emitterCells.emitterCell.emitterCells.emitterCell1.birthRate"];
        
        [self.outherringEmitter setValue:@(30) forKeyPath:@"emitterCells.otheremitterCell.birthRate"];
        [self.threeringEmitter setValue:@(30) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
        [self.fourringEmitter setValue:@(10) forKeyPath:@"emitterCells.fouremitterCell.birthRate"];
    }else if (state == HIDO){
        [self.ringEmitter setValue:@(30) forKeyPath:@"emitterCells.emitterCell.birthRate"];
        [self.ringEmitter setValue:@(1) forKeyPath:@"emitterCells.emitterCell.emitterCells.emitterCell1.birthRate"];
        
        [self.outherringEmitter setValue:@(30) forKeyPath:@"emitterCells.otheremitterCell.birthRate"];
        [self.threeringEmitter setValue:@(40) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
        [self.fourringEmitter setValue:@(20) forKeyPath:@"emitterCells.fouremitterCell.birthRate"];
    }else{
        
    }
    

}

- (void)changeEmitterContentWithState:(TRActionState)state
{
    NSString *contentStr = @"";
    NSString *contentShaoYao = @"";
    switch (state) {
        case SUPER:
        {
            contentStr = @"";
            contentShaoYao = @"good";
        }
            break;
        case GOOD:
        {
            contentStr = @"";
            contentShaoYao = @"good";
        }
            break;
        case PERFECT:
        {
            contentStr = @"perfect";
            contentShaoYao = @"shanyao";
        }
            break;
        case HIDO:
        {
            contentStr = @"perfect";
            contentShaoYao = @"shanyao";
        }
            break;
            
        default:
            break;
    }
    [self.ringEmitter setValue:(__bridge id)[UIImage imageNamed:contentShaoYao].CGImage forKeyPath:@"emitterCells.emitterCell.contents"];
    [self.outherringEmitter setValue:(__bridge id)[UIImage imageNamed:contentShaoYao].CGImage forKeyPath:@"emitterCells.otheremitterCell.contents"];
    [self.threeringEmitter setValue:(__bridge id)[UIImage imageNamed:contentShaoYao].CGImage forKeyPath:@"emitterCells.threeemitterCell.contents"];
    [self.fourringEmitter setValue:(__bridge id)[UIImage imageNamed:contentStr].CGImage forKeyPath:@"emitterCells.fouremitterCell.contents"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
