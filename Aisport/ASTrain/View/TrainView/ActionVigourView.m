//
//  ActionVigourView.m
//  Aisport
//
//  Created by Apple on 2020/10/20.
//

#import "ActionVigourView.h"

@implementation ActionVigourView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
//        CGFloat max = MAX(SCR_WIDTH, SCR_HIGHT);
//        CGFloat min = MIN(SCR_WIDTH, SCR_HIGHT);
        UIView *prosessView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height/2-7.0/2, 0, 7)];
        [self addSubview:prosessView];
        prosessView.backgroundColor = [UIColor colorWithHex:@"#00FFDD"];
        _prosessView = prosessView;
    }
    return self;
}

//总长101
- (void)setValue:(float)value
{
    _value = value;
    [UIView animateWithDuration:0.05 animations:^{
        self.prosessView.frame = CGRectMake(0, 9.0/2-7.0/2, 98*value, 7);
        } completion:^(BOOL finished) {

        }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
