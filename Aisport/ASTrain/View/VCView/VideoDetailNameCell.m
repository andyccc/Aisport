//
//  VideoDetailNameCell.m
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import "VideoDetailNameCell.h"
#import "VideoDetailInfoModel.h"

#define Cell_Height UIValue(50)

@interface VideoDetailNameCell()

@property (nonatomic, strong) UILabel *videoNameLabel;
@property (nonatomic, strong) UIButton *arrowBtn;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIImageView *hotImageView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *recordLabel;

@end

@implementation VideoDetailNameCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        [self.contentView addSubview:self.videoNameLabel];
        [self.contentView addSubview:self.arrowBtn];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.hotImageView];
        [self.contentView addSubview:self.countLabel];
        [self.contentView addSubview:self.recordLabel];
        
    }
    return self;
}

- (void)fillData:(VideoDetailInfoModel *)data withShowIntroduction:(BOOL)showIntroduction
{
    self.videoNameLabel.text = [NSString stringWithFormat:@"%@",data.name];
    self.countLabel.text = [NSString stringWithFormat:@"%@",data.playTotal];
    self.recordLabel.text = [NSString stringWithFormat:@"当前记录：%d‘%d", data.time.intValue/60,data.time.intValue%60];
    NSString *imageName = showIntroduction ? @"arrow_up" : @"arrow_down";
    self.arrowImageView.image = [UIImage imageNamed:imageName];
}

- (void)arrowBtnClick:(UIButton *)btn
{
    if (self.showIntroductionBlock) {
        self.showIntroductionBlock();
    }
}

- (UILabel *)videoNameLabel
{
    if (!_videoNameLabel) {
        _videoNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(UIValue(16), UIValue(10), SCR_WIDTH - UIValue(32) - UIValue(27), UIValue(20))];
        _videoNameLabel.textColor = [UIColor colorWithHex:@"#333333"];
        _videoNameLabel.font = FontBoldR(18);
        _videoNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _videoNameLabel;
}

- (UIButton *)arrowBtn
{
    if (!_arrowBtn) {
        _arrowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _arrowBtn.frame =CGRectMake(UIScreenWidth - UIValue(50), 0, UIValue(50), UIValue(50));
        [_arrowBtn addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _arrowBtn.centerY = self.videoNameLabel.centerY;
    }
    return _arrowBtn;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UIScreenWidth - UIValue(33), UIValue(10), UIValue(17), UIValue(10))];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_down"];
        _arrowImageView.userInteractionEnabled = YES;
        _arrowImageView.centerY = self.videoNameLabel.centerY;
    }
    return _arrowImageView;
}

- (UIImageView *)hotImageView
{
    if (!_hotImageView) {
        _hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.videoNameLabel.left, self.videoNameLabel.bottom + UIValue(6), UIValue(11), UIValue(12))];
        _hotImageView.image = [UIImage imageNamed:@"hot_icon"];
    }
    return _hotImageView;
}

- (UILabel *)countLabel
{
    if (!_countLabel)
    {
        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.hotImageView.right + UIValue(1), self.hotImageView.top, UIValue(80), UIValue(12))];
        _countLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _countLabel.font = FontR(10);
        _countLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _countLabel;
}

- (UILabel *)recordLabel
{
    if (!_recordLabel)
    {
        _recordLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.countLabel.right + UIValue(10), self.countLabel.top, UIValue(150), UIValue(12))];
        _recordLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _recordLabel.font = FontR(10);
        _recordLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _recordLabel;
}

+ (CGFloat)cellHeight
{
    return Cell_Height;
}

@end
