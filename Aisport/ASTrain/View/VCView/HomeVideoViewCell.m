//
//  HomeVideoViewCell.m
//  Aisport
//
//  Created by Apple on 2020/11/10.
//

#import "HomeVideoViewCell.h"
#import "UILabel+getWidth.h"

@implementation HomeVideoViewCell

- (NSMutableArray *)rankViewArr
{
    if (!_rankViewArr) {
        _rankViewArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _rankViewArr;
}

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
//        backBgView.backgroundColor = [UIColor colorWithHex:@"#282828" alpha:0.23];
//        backBgView.layer.borderWidth = 0.5;
//        backBgView.layer.borderColor = [[UIColor colorWithHex:@"#282828"] CGColor];
 
        
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 113*2*Screen_Scale)];
        [backBgView addSubview:picImageView];
        picImageView.image = [UIImage imageNamed:@"train_rank"];
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
//        picImageView.layer.cornerRadius = 5;
        picImageView.clipsToBounds = YES;
        
        CAShapeLayer *mask=[CAShapeLayer layer];
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:picImageView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft  cornerRadii:CGSizeMake(5,5)];
        mask.path = path.CGPath;
        mask.frame = picImageView.bounds;
        
//        CAShapeLayer *borderLayer = [CAShapeLayer layer];
//        borderLayer.path = path.CGPath;
//        borderLayer.fillColor = [UIColor clearColor].CGColor;
//        //        borderLayer.strokeColor = [UIColor colorWithHex:@"#FDAB00"].CGColor;
//        //        borderLayer.lineWidth = 1;
//        borderLayer.frame = bottomView.bounds;
//        bottomView.layer.mask = mask;
        picImageView.layer.mask = mask;
//        [bottomView.layer addSublayer:borderLayer];
        _picImageView = picImageView;
        
        UIView *coverView = [[UIView alloc] init];
        [picImageView addSubview:coverView];
        [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picImageView.mas_top).offset(0);
            make.left.equalTo(picImageView.mas_left);
            make.right.equalTo(picImageView.mas_right);
            make.bottom.equalTo(picImageView.mas_bottom);
        }];
        coverView.backgroundColor = [UIColor colorWithHex:@"#000000" alpha:0.1];
        coverView.layer.cornerRadius = 5;
        coverView.clipsToBounds = YES;
        
        UILabel *difficultLabel = [[UILabel alloc] init];
        [coverView addSubview:difficultLabel];
        [difficultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(coverView.mas_top).offset(8);
            make.width.mas_equalTo(50);
            make.right.equalTo(coverView.mas_right).offset(-10);
            make.height.mas_equalTo(11);
        }];
        difficultLabel.font = fontApp(11);
        difficultLabel.textColor = [UIColor colorWithHex:@"#FFFFFF"];
        difficultLabel.textAlignment = NSTextAlignmentRight;
        difficultLabel.text = @"入门";
        _difficultLabel = difficultLabel;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, picImageView.bottom, picImageView.width-8*2, 10+9+7)];
        [backBgView addSubview:titleLabel];
        titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        titleLabel.font = fontBold(13);
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 1;
        titleLabel.text = @"DON'T START NOWAW...";
        _titleLabel = titleLabel;
        
        UILabel *autherLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, titleLabel.bottom, picImageView.width-8*2, 11)];
        [backBgView addSubview:autherLabel];
        autherLabel.textColor = [UIColor colorWithHex:@"#333333"];
        autherLabel.font = fontApp(11);
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 1;
        autherLabel.text = @"王建国";
        _autherLabel = autherLabel;
        
        UILabel * recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, autherLabel.bottom+8, picImageView.width/2-8, 10)];
        [backBgView addSubview:recordLabel];
        recordLabel.textColor = [UIColor colorWithHex:@"#666666"];
        recordLabel.font = fontApp(10);
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 1;
        recordLabel.text = @"当前记录:12562";
        _recordLabel = recordLabel;
        
        
        NSString *timeStr = @"1.2万人跳过";
        CGFloat timeW = [UILabel getWidthWithTitle:timeStr font:fontApp(10)];
//        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-timeW-8-4, autherLabel.bottom+3, timeW+4, 17)];
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, picImageView.bottom-3-17, timeW+4, 17)];
        [backBgView addSubview:timeLabel];
        timeLabel.font = fontApp(10);
//        timeLabel.textColor = [UIColor colorWithHex:@"#1BC2B1"];
        timeLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.07];//0.07
        timeLabel.layer.cornerRadius = 3;
        timeLabel.clipsToBounds = YES;
        timeLabel.text = timeStr;
        _timeLabel = timeLabel;
        
        UIButton *jumpButton = [[UIButton alloc] init];
        [self addSubview:jumpButton];
        [jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(coverView.mas_bottom).offset(-5);
            make.right.equalTo(coverView.mas_right).offset(-5);
            make.width.mas_equalTo(61);
            make.height.mas_equalTo(26);
        }];
        [jumpButton setTitle:@"跳舞吧！" forState:UIControlStateNormal];
        [jumpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [jumpButton setBackgroundColor:[UIColor colorWithHex:@"#1BC2B1"]];
        jumpButton.titleLabel.font = fontBold(11);
        jumpButton.layer.cornerRadius = 26.0/2;
        jumpButton.clipsToBounds = YES;
        jumpButton.hidden = YES;
//        [jumpButton addTarget:self action:@selector(clickjumpButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clickplayButton
{
    if (self.playVideoBlcok) {
        self.playVideoBlcok(StringForId(_model.url));
    }
}

- (void)setModel:(HomeListModel *)model
{
    _model = model;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(model.cover)] placeholderImage:nil];
    _difficultLabel.text = StringForId(model.leverVStr);
    _titleLabel.text = StringForId(model.name);
    _autherLabel.text = StringForId(model.author);
    _recordLabel.text = [NSString stringWithFormat:@"当前记录:%@",StringNumForId(model.curHighScore, @"0")];
    
    NSString *timeStr = [NSString stringWithFormat:@"%@人跳过",StringNumForId(model.playTotal, @"0")];
    if ([StringNumForId(model.playTotal, @"0") longLongValue] >= 10000) {
        timeStr = [NSString stringWithFormat:@"%.1f万人跳过",[StringNumForId(model.playTotal, @"0") floatValue]/10000.0];
    }
    CGFloat timeW = [UILabel getWidthWithTitle:timeStr font:fontApp(10)];
    _timeLabel.frame = CGRectMake(8, _picImageView.bottom-3-17, timeW+4, 17);
//    timeLabel.backgroundColor = [UIColor colorWithHex:@"#1BC2B1" alpha:0.07];//0.07
//    timeLabel.layer.cornerRadius = 3;
//    timeLabel.clipsToBounds = YES;
    _timeLabel.text = timeStr;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
