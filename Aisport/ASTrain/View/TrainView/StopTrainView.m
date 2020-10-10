//
//  StopTrainView.m
//  aisport
//
//  Created by 曹停 on 2020/10/18.
//

#import "StopTrainView.h"

@interface StopTrainView ()

@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, assign) BOOL isTV;

@end

@implementation StopTrainView

- (instancetype)initWithFrame:(CGRect)frame IsTV:(BOOL)isTV;
{
    self = [super initWithFrame:frame];
    if (self) {
        _isTV = isTV;
        [self setMainViewWithIsTV:isTV];
//    UIView *endAlertView = [UIView alloc] initWithFrame:<#(CGRect)#>;
//        [self setEndView];
    }
    return self;
}

- (void)setMainViewWithIsTV:(BOOL)isTV;
{
    
    CGFloat max = MAX(SCR_WIDTH, SCR_HIGHT);
    CGFloat min = MIN(SCR_WIDTH, SCR_HIGHT);
    
    //WithFrame:CGRectMake((max-138-62*2)/2, min/2-(62+16+15)/2.0, 62, 62+16+15)
    UIButton *playBtn = [[UIButton alloc] init];
    if (!isTV) {
        playBtn.frame = CGRectMake((SCR_WIDTH-138-62*2)/2, SCR_HIGHT/2-(62+16+15)/2.0, 62, 62+16+15);
    }else{
        playBtn.frame = CGRectMake((max-138-62*2)/2, min/2-(62+16+15)/2.0, 62, 62+16+15);
    }
    [self addSubview:playBtn];
//    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(62);
//        make.height.mas_equalTo(62+16+15);
//        make.left.equalTo(self.mas_left).offset((SCR_HIGHT-138-62*2)/2);
//        make.centerY.equalTo(self.mas_centerY);
//    }];
    [playBtn setTitle:@"继续" forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor colorWithHex:@"#FFFFFF"] forState:UIControlStateNormal];
    playBtn.titleLabel.font = fontBold(15);
    [playBtn setImage:[UIImage imageNamed:@"train_play"] forState:UIControlStateNormal];
    [playBtn layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleTop imageTitleSpace:16];
    [playBtn addTarget:self action:@selector(clickPlayBtn) forControlEvents:UIControlEventTouchUpInside];
    _playBtn = playBtn;
    
    //WithFrame:CGRectMake(max-(max-138-62*2)/2-62, min/2-(62+16+15)/2.0, 62, 62+16+15)
    UIButton *backBtn = [[UIButton alloc] init];
    if (!isTV) {
        backBtn.frame = CGRectMake(SCR_WIDTH-(SCR_WIDTH-138-62*2)/2-62, SCR_HIGHT/2-(62+16+15)/2.0, 62, 62+16+15);
    }else{
        backBtn.frame = CGRectMake(max-(max-138-62*2)/2-62, min/2-(62+16+15)/2.0, 62, 62+16+15);
    }
    [self addSubview:backBtn];
//    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(62);
//        make.height.mas_equalTo(62+16+15);
//        make.right.equalTo(self.mas_right).offset(-(SCR_HIGHT-138-62*2)/2);
//        make.centerY.equalTo(self.mas_centerY);
//    }];
    [backBtn setTitle:@"退出" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithHex:@"#FFFFFF"] forState:UIControlStateNormal];
    backBtn.titleLabel.font = fontBold(15);
    [backBtn setImage:[UIImage imageNamed:@"train_out"] forState:UIControlStateNormal];
    [backBtn layoutButtonWithEdgeInsetsStyle:MWButtonEdgeInsetsStyleTop imageTitleSpace:16];
    [backBtn addTarget:self action:@selector(clickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    _backBtn = backBtn;
    
    

    
       
}

- (void)clickPlayBtn
{
    if (self.continuePlayVideoBlock) {
        self.continuePlayVideoBlock();
    }
}

- (void)clickBackBtn
{
    [_playBtn removeFromSuperview];
    _playBtn = nil;
    
    [_backBtn removeFromSuperview];
    _backBtn = nil;
    
    [self setEndView];
}


- (void)setEndView
{
    CGFloat max = MAX(SCR_WIDTH, SCR_HIGHT);
    CGFloat min = MIN(SCR_WIDTH, SCR_HIGHT);
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 269, 131)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    if (!_isTV) {
        whiteView.center = CGPointMake(SCR_WIDTH/2, SCR_HIGHT/2);
    }else{
        whiteView.center = CGPointMake(max/2, min/2);
    }
    
//        _whiteView = whiteView;
    
    UILabel * endTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, 269, 15+4)];
    endTitleLabel.text = @"是否结束训练？";
    endTitleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    endTitleLabel.textAlignment = NSTextAlignmentCenter;
    endTitleLabel.font = fontBold(16);
    [whiteView addSubview:endTitleLabel];
    
    UILabel * subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, endTitleLabel.bottom+13, 269, 13)];
    subTitleLabel.text = @"中途退出不会计分，再坚持一下呗";
    subTitleLabel.textColor = [UIColor colorWithHex:@"#999999"];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.font = fontApp(12);
    [whiteView addSubview:subTitleLabel];
    
    
    UIView* defLine = [[UIView alloc]initWithFrame:CGRectMake(0, 78 , whiteView.frame.size.width, 1)];
    defLine.backgroundColor = [UIColor colorWithHex:@"#D8D8D8"];
    [whiteView addSubview:defLine];


    UIButton * cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 79, 269/2-0.5, 131-79.0)];
    [cancelButton setTitle:@"结束并退出" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithHex:@"#333333"] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = fontBold(15);
    [cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:cancelButton];
    


    UIView* verLine = [[UIView alloc]initWithFrame:CGRectMake(cancelButton.right, 79 , 1, whiteView.frame.size.height-79)];
    verLine.backgroundColor = [UIColor colorWithHex:@"#D8D8D8"];;
    [whiteView addSubview:verLine];

    UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(cancelButton.right+1, 79, 269/2-0.5, 131-79.0)];
    [sureButton setTitle:@"继续" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor colorWithHex:@"#1BC2B1"] forState:UIControlStateNormal];
    sureButton.titleLabel.font = fontBold(15);
    [sureButton addTarget:self action:@selector(clickContinuePlay) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:sureButton];
}

- (void)clickContinuePlay
{
    if (self.continuePlayVideoBlock) {
        self.continuePlayVideoBlock();
    }
}

- (void)hide
{
    if (self.backPlayVideoBlock) {
        self.backPlayVideoBlock();
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
