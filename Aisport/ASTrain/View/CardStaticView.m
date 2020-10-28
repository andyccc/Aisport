//
//  CardStaticView.m
//  aisport
//
//  Created by Apple on 2020/10/16.
//

#import "CardStaticView.h"

@interface CardStaticView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *playTitleLabel;
@property (nonatomic, strong) UILabel *playCountLabel;

@property (nonatomic, strong) UILabel *historyTitleLabel;
@property (nonatomic, strong) UILabel *historyCountLabel;

@property (nonatomic, strong) UILabel *costTitleLabel;
@property (nonatomic, strong) UILabel *costCountLabel;


@end

@implementation CardStaticView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self setupSubViews];
//    }
//    return self;
//}

- (void)setupSubViews
{
//    CGPoint point1 = CGPointMake(1.5, 2.4);
//    CGPoint point2 = CGPointMake(1.5, 2.4);
//
//    NSArray *array = @[@(point1),@(point2)];
//
//    CGPoint point3 = [array[0] CGPointValue];
//
//    NSLog(@"%@---%@",array,point3);
    
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    _titleLabel.font = fontBold(16);
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.text = @"开合跳有氧操";
    
    
    //累计播放
    _playTitleLabel = [[UILabel alloc] init];
    [self addSubview:_playTitleLabel];
    _playTitleLabel.font = fontApp(14);
    _playTitleLabel.textColor = [UIColor darkGrayColor];
    _playTitleLabel.text = @"累计播放";
    
    _playCountLabel = [[UILabel alloc] init];
    [self addSubview:_playCountLabel];
    _playCountLabel.font = fontApp(15);
    _playCountLabel.textColor = [UIColor blackColor];
    _playCountLabel.text = @"44";
    
    
    //历史记录
    _historyTitleLabel = [[UILabel alloc] init];
    [self addSubview:_historyTitleLabel];
    _historyTitleLabel.font = fontApp(14);
    _historyTitleLabel.textColor = [UIColor darkGrayColor];
    _historyTitleLabel.text = @"历史记录";
    
    _historyCountLabel = [[UILabel alloc] init];
    [self addSubview:_historyCountLabel];
    _historyCountLabel.font = fontApp(15);
    _historyCountLabel.textColor = [UIColor blackColor];
    _historyCountLabel.text = @"4673";
    
    //累计消耗千卡
    _costTitleLabel = [[UILabel alloc] init];
    [self addSubview:_costTitleLabel];
    _costTitleLabel.font = fontApp(14);
    _costTitleLabel.textColor = [UIColor darkGrayColor];
    _costTitleLabel.text = @"累计消耗千卡";
    
    _costCountLabel = [[UILabel alloc] init];
    [self addSubview:_costCountLabel];
    _costCountLabel.font = fontApp(15);
    _costCountLabel.textColor = [UIColor blackColor];
    _costCountLabel.text = @"33";
    
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.left.equalTo(self.mas_left).offset(10);
        make.width.mas_equalTo(16 * 20);
        make.height.mas_equalTo(20);
    }];
    
    [_playTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.left.equalTo(_titleLabel);
        make.width.mas_equalTo(4 * 16);
        make.height.mas_equalTo(16);
    }];
    
    [_playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playTitleLabel.mas_bottom).offset(5);
        make.left.equalTo(_playTitleLabel);
        make.width.mas_equalTo(_playTitleLabel);
        make.height.mas_equalTo(16);
    }];
    
    [_historyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playTitleLabel);
        make.left.equalTo(_playTitleLabel.mas_right).offset(30);
        make.width.mas_equalTo(4 * 16);
        make.height.mas_equalTo(16);
    }];
    
    [_historyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playCountLabel);
        make.left.equalTo(_historyTitleLabel);
        make.width.mas_equalTo(_historyTitleLabel);
        make.height.mas_equalTo(16);
    }];
    
    
    [_costTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playTitleLabel);
        make.left.equalTo(_historyTitleLabel.mas_right).offset(30);
        make.width.mas_equalTo(6 * 16);
        make.height.mas_equalTo(16);
    }];
    
    [_costCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_playCountLabel);
        make.left.equalTo(_costTitleLabel);
        make.width.mas_equalTo(_costTitleLabel);
        make.height.mas_equalTo(16);
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
