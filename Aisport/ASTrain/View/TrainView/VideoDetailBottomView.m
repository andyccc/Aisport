//
//  VideoDetailBottomView.m
//  Aisport
//
//  Created by 申公安 on 2020/12/26.
//

#import "VideoDetailBottomView.h"

@implementation VideoDetailBottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionBtn];
        [self addSubview:self.danceBtn];
    }
    return self;
}

- (void)fillData:(BOOL)isCollection
{
    self.collectionBtn.selected = isCollection;
}

- (void)collectionBtnClick:(UIButton *)btn
{
    if (self.collectionVideoBlock) {
        self.collectionVideoBlock();
    }
}

- (void)danceBtnClick:(UIButton *)btn
{
    if (self.danceActionBlock) {
        self.danceActionBlock();
    }
}

- (UIButton *)collectionBtn
{
    if (!_collectionBtn) {
        _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _collectionBtn.frame =CGRectMake(UIValue(26), 0, UIValue(32), UIValue(32));
        [_collectionBtn addTarget:self action:@selector(collectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"collection_icon"] forState:UIControlStateSelected];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"un_collection_icon"] forState:UIControlStateNormal];
        _collectionBtn.centerY = self.height/2.0;
    }
    return _collectionBtn;
}

- (UIButton *)danceBtn
{
    if (!_danceBtn) {
        _danceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _danceBtn.frame =CGRectMake(0, 0, UIValue(275), UIValue(38));
        _danceBtn.right = SCR_WIDTH - UIValue(16);
        [_danceBtn setTitle:@"跳舞吧！" forState:UIControlStateNormal];
        _danceBtn.titleLabel.font = FontR(16);
        [_danceBtn setBackgroundColor:[UIColor colorWithHex:@"#FBB313"]];
        [_danceBtn setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateNormal];
        [_danceBtn addTarget:self action:@selector(danceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _danceBtn.centerY = self.height/2.0;
        _danceBtn.layer.cornerRadius = UIValue(19);
        _danceBtn.layer.masksToBounds = YES;
    }
    return _danceBtn;
}

@end
