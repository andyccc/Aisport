//
//  WholePartVideoViewCell.m
//  Aisport
//
//  Created by Apple on 2020/11/10.
//

#import "WholePartVideoViewCell.h"

@implementation WholePartVideoViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backView];
        backView.backgroundColor = [UIColor colorWithHex:@"#282828" alpha:0.08];
//        backView.layer.borderWidth = 0.5;
//        backView.layer.borderColor = [[UIColor colorWithHex:@"#282828"] CGColor];
        backView.layer.cornerRadius = 5;
        backView.clipsToBounds = YES;
        _backView = backView;
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.width)];
        [backView addSubview:iconImageView];
        iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        iconImageView.layer.cornerRadius = 5;
        iconImageView.clipsToBounds = YES;
//        [iconImageView sd_setImageWithURL:[NSURL URLWithString:@"http://47.104.247.163:8080/turenadmin/upload/2019-04-18/1555577186305.jpg"] placeholderImage:[UIImage imageNamed:@"placeHolderImg"]];
//        iconImageView.image = [UIImage imageNamed:@"home_hejipic"];
        _iconImageView = iconImageView;
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 0, frame.size.width-16*2*Screen_Scale*2, backView.height)];
        [backView addSubview:nameLabel];
//        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = fontBold(17);
        nameLabel.textColor = [UIColor colorWithHex:@"#1D1D1D"];
        nameLabel.text = @"合集2";
        _nameLabel = nameLabel;
        
//        UILabel *subLabel = [[UILabel alloc] initWithFrame:CGRectMake(9, nameLabel.bottom+6, 136-18, 40)];
//        [self addSubview:subLabel];
//        subLabel.textAlignment = NSTextAlignmentCenter;
//        subLabel.font = fontApp(14);
//        subLabel.textColor = [UIColor colorWithHex:@"#666666"];
//        subLabel.numberOfLines = 0;
//        subLabel.text = @"从事领域:系统创新工程";
//        _subLabel = subLabel;
        
        
//        UIButton *checkBtn = [[UIButton alloc] initWithFrame:CGRectMake(136.0/2-65.0/2, subLabel.bottom+10, 65, 25)];
//        [self addSubview:checkBtn];
//        [checkBtn setBackgroundColor:[UIColor colorWithHex:@"#476ED7"] forState:UIControlStateNormal];
//        checkBtn.layer.cornerRadius = 2;
//        checkBtn.clipsToBounds = YES;
//        [checkBtn setTitle:@"立即查看" forState:UIControlStateNormal];
//        [checkBtn setTitleColor:WHITE_Color forState:UIControlStateNormal];
//        checkBtn.titleLabel.font = fontApp(12);
        
    }
    return self;
}

- (void)setModel:(WholePartModel *)model
{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(model.cover)] placeholderImage:[UIImage imageNamed:@"home_hejipic"]];
    _nameLabel.text = StringForId(model.name);
}

@end
