//
//  ReportprogressView.m
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import "ReportprogressView.h"

@implementation ReportprogressView

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
    UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30+8, 15, 17)];
    [self addSubview:picImageView];
//    picImageView.backgroundColor = [UIColor redColor];
    picImageView.contentMode = UIViewContentModeScaleAspectFill;
//    picImageView.image = [UIImage imageNamed:@""];
    _picImageView = picImageView;
    
    UILabel *upTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(picImageView.right+10, 30, SCR_WIDTH-67-picImageView.right-10, 11)];
    [self addSubview:upTitleLabel];
    upTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    upTitleLabel.font = fontApp(11);
    upTitleLabel.text = @"热量消耗/kcal";
    _upTitleLabel = upTitleLabel;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(picImageView.right+10, 44, SCR_WIDTH-67-picImageView.right-10, 10)];
    [self addSubview:bottomView];
    bottomView.backgroundColor = [UIColor colorWithHex:@"#EFEFEF"];
    bottomView.layer.cornerRadius = 5;
    bottomView.clipsToBounds = YES;
    
    UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(picImageView.right+10, 44, bottomView.width*0.4, 10)];
    [self addSubview:upView];
    upView.backgroundColor = [UIColor colorWithHex:@"#1BC2B1"];
    upView.layer.cornerRadius = 5;
    upView.clipsToBounds = YES;
    _upView = upView;
    
    
    UILabel *stateTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomView.right+12, 44, SCR_WIDTH-bottomView.right-12, 10)];
    [self addSubview:stateTitleLabel];
    stateTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    stateTitleLabel.font = fontApp(10);
    stateTitleLabel.text = @"完美燃脂";
    _stateTitleLabel = stateTitleLabel;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
