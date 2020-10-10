//
//  VideoDetailBankTitleCell.m
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import "VideoDetailBankTitleCell.h"

#define Cell_Height  UIValue(47)

@interface VideoDetailBankTitleCell()

@property (nonatomic, strong) UIButton *bankBtn;
@property (nonatomic, strong) UIButton *growthBtn;

@end

@implementation VideoDetailBankTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        [self.contentView addSubview:self.bankBtn];
        [self.contentView addSubview:self.growthBtn];
    }
    return self;
}

- (void)fillData:(VideoDetailInfoModel *)data isBankList:(BOOL)isBankList
{
    self.bankBtn.selected = isBankList;
    self.growthBtn.selected = !isBankList;
}

- (void)bankBtnClick:(UIButton *)btn
{
    if (self.showBankListBlock) {
        self.showBankListBlock(YES);
    }
}

- (void)growthBtnClick:(UIButton *)btn
{
    if (self.showBankListBlock) {
        self.showBankListBlock(NO);
    }
}

- (UIButton *)bankBtn
{
    if (!_bankBtn) {
        _bankBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bankBtn.frame =CGRectMake(UIValue(16), UIValue(5), (SCR_WIDTH-UIValue(32))/2.0, Cell_Height);
        [_bankBtn setTitle:@"排行榜" forState:UIControlStateNormal];
        _bankBtn.titleLabel.font = FontBoldR(16);
        [_bankBtn setTitleColor:[UIColor colorWithHex:@"#989898"] forState:UIControlStateNormal];
        [_bankBtn setTitleColor:[UIColor colorWithHex:@"#FBB313"] forState:UIControlStateSelected];
        [_bankBtn addTarget:self action:@selector(bankBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bankBtn setBackgroundImage:[UIImage imageNamed:@"bank_btn"] forState:UIControlStateSelected];
        [_bankBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _bankBtn;
}

- (UIButton *)growthBtn
{
    if (!_growthBtn) {
        _growthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _growthBtn.frame =CGRectMake(SCR_WIDTH/2.0, self.bankBtn.top, self.bankBtn.width, Cell_Height);
        [_growthBtn setTitle:@"我的成长" forState:UIControlStateNormal];
        _growthBtn.titleLabel.font = FontBoldR(16);
        [_growthBtn setTitleColor:[UIColor colorWithHex:@"#989898"] forState:UIControlStateNormal];
        [_growthBtn setTitleColor:[UIColor colorWithHex:@"#FBB313"] forState:UIControlStateSelected];
        [_growthBtn addTarget:self action:@selector(growthBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_growthBtn setBackgroundImage:[UIImage imageNamed:@"growth_btn"] forState:UIControlStateSelected];
        [_growthBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    return _growthBtn;
}

+ (CGFloat)cellHeight
{
    return Cell_Height;
}

@end
