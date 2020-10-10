//
//  AddEmitterView.m
//  Aisport
//
//  Created by Apple on 2020/12/15.
//

#import "AddEmitterView.h"
#import <QuartzCore/CoreAnimation.h>

@interface AddEmitterView ()

@property (nonatomic,strong) CAEmitterLayer *ringEmitter;

@property (nonatomic,strong) CAEmitterLayer *outherringEmitter;

@property (nonatomic,strong) CAEmitterLayer *threeringEmitter;
@property (nonatomic,strong) CAEmitterLayer *fourringEmitter;

@end

@implementation AddEmitterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//- (void)make

- (void)makeEmitterWithPositon:(CGPoint)position
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
    emitterLayer.position        = position;
//    emitterLayer.emitterPosition = position;
//    emitterLayer.emitterPosition = CGPointMake(0, -20);
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerCircle; //发射器形状
//    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
    emitterLayer.renderMode = kCAEmitterLayerUnordered;
//    emitterLayer.seed = 20;
//    emitterLayer.spin = 3.0;
    
    CAEmitterCell *emitterCell              = [CAEmitterCell emitterCell];
    emitterCell.scale = 0.5;
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

    [self.layer addSublayer:emitterLayer];
    _ringEmitter = emitterLayer;
    
//    [self makeEmitter1WithPositon:position];
//    [self makeEmitter2WithPositon:position];
//    [self makeEmitter3WithPositon:position];
}


- (void)makeEmitter1WithPositon:(CGPoint)position
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
//    emitterLayer.position        = CGPointMake((98+40)/2, (98+40)/2);
    emitterLayer.emitterPosition = CGPointMake(position.y-10, position.y);
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerCircle; //发射器形状
//    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
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

- (void)makeEmitter2WithPositon:(CGPoint)position
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
//    emitterLayer.position        = CGPointMake((98+40)/2, (98+40)/2);
    emitterLayer.emitterPosition = CGPointMake(position.y+10, position.y);
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerLine; //发射器形状
//    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
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


- (void)makeEmitter3WithPositon:(CGPoint)position
{
    CAEmitterLayer *emitterLayer                 = [CAEmitterLayer layer];
    emitterLayer.backgroundColor = [[UIColor blackColor] CGColor];
//    let screenWidth              = self.view.bounds.size.width
//    emitterLayer.frame           = CGRectMake(0, 0, screenWidth, screenWidth)
//    emitterLayer.position        = CGPointMake((98+40)/2, (98+40)/2);
    emitterLayer.emitterPosition = position;
    emitterLayer.emitterMode      = kCAEmitterLayerSurface;
    emitterLayer.emitterShape    = kCAEmitterLayerCircle; //发射器形状
//    emitterLayer.emitterSize     = CGSizeMake(98/2, 98/2); // 发射器大小
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


- (void)reduceEmitter
{
    [self.fourringEmitter setValue:@(0) forKeyPath:@"emitterCells.fouremitterCell.birthRate"];
    [self.threeringEmitter setValue:@(0) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
    [self.outherringEmitter setValue:@(0) forKeyPath:@"emitterCells.otheremitterCell.birthRate"];
    [self.ringEmitter setValue:@(0) forKeyPath:@"emitterCells.emitterCell.birthRate"];
    [self.ringEmitter setValue:@(0) forKeyPath:@"emitterCells.emitterCell.emitterCellsemitterCell1.birthRate"];
}

- (void)addEmitterWithState:(ATRActionState)state
{
//    [self.ringEmitter setValue:@(100) forKeyPath:@"emitterCells.emitterCell.birthRate"];

    if (state == AGOOD) {
        [self.threeringEmitter setValue:@(50) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
    }else if (state == ASUPER){
        [self.threeringEmitter setValue:@(50) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
    }else if (state == APERFECT){
        [self.ringEmitter setValue:@(30) forKeyPath:@"emitterCells.emitterCell.birthRate"];
        [self.ringEmitter setValue:@(1) forKeyPath:@"emitterCells.emitterCell.emitterCells.emitterCell1.birthRate"];
        
        [self.outherringEmitter setValue:@(30) forKeyPath:@"emitterCells.otheremitterCell.birthRate"];
        [self.threeringEmitter setValue:@(30) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
        [self.fourringEmitter setValue:@(10) forKeyPath:@"emitterCells.fouremitterCell.birthRate"];
    }else if (state == AHIDO){
        [self.ringEmitter setValue:@(30) forKeyPath:@"emitterCells.emitterCell.birthRate"];
        [self.ringEmitter setValue:@(1) forKeyPath:@"emitterCells.emitterCell.emitterCells.emitterCell1.birthRate"];
        
        [self.outherringEmitter setValue:@(30) forKeyPath:@"emitterCells.otheremitterCell.birthRate"];
        [self.threeringEmitter setValue:@(40) forKeyPath:@"emitterCells.threeemitterCell.birthRate"];
        [self.fourringEmitter setValue:@(20) forKeyPath:@"emitterCells.fouremitterCell.birthRate"];
    }else{
        
    }
    

}

- (void)changeEmitterContentWithState:(ATRActionState)state
{
    NSString *contentStr = @"";
    NSString *contentShaoYao = @"";
    switch (state) {
        case ASUPER:
        {
            contentStr = @"";
            contentShaoYao = @"good";
        }
            break;
        case AGOOD:
        {
            contentStr = @"";
            contentShaoYao = @"good";
        }
            break;
        case APERFECT:
        {
            contentStr = @"perfect";
            contentShaoYao = @"shanyao";
        }
            break;
        case AHIDO:
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
