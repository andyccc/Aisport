//
//  HomeWholeViewCell.m
//  Aisport
//
//  Created by Apple on 2020/11/16.
//

#import "HomeWholeViewCell.h"

@implementation HomeWholeViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *backBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backBgView];
        backBgView.backgroundColor = [UIColor whiteColor];
        backBgView.layer.cornerRadius = 5;
//        backBgView.clipsToBounds = YES;
        backBgView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.23].CGColor;
        backBgView.layer.shadowOffset = CGSizeMake(0,0);
        backBgView.layer.shadowRadius = 2;
        backBgView.layer.shadowOpacity = 1;
        
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 138*2*Screen_Scale)];
        [backBgView addSubview:picImageView];
        picImageView.image = [UIImage imageNamed:@"train_rank"];
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
        picImageView.clipsToBounds = YES;
        _picImageView = picImageView;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, picImageView.bottom, picImageView.width-8*2, 43*2*Screen_Scale)];
        [backBgView addSubview:titleLabel];
        titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        titleLabel.font = fontApp(12);
//        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        titleLabel.text = @"帕梅拉-20min臀部+大腿负重训练丨全称讲解全称讲解全...";
        _titleLabel = titleLabel;
    }
    return self;
}

@end
