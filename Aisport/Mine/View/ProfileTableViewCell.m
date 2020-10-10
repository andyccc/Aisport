//
//  SettinCentreViewCell.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 75, 60*2*Screen_Scale)];
        [self.contentView addSubview:_titleLab];
        _titleLab.textColor = [UIColor colorWithHex:@"#333333"];
        _titleLab.font = fontApp(16);
        
        _subTf = [[UITextField alloc]initWithFrame:CGRectMake(112, 0, SCR_WIDTH - 112-15, 60*2*Screen_Scale)];
        _subTf.textColor = [UIColor colorWithHex:@"#999999"];
        _subTf.font = fontApp(15);
        _subTf.textAlignment = NSTextAlignmentRight;
        _subTf.tag = _index;
        _subTf.delegate = self;
//        [_subTf addTarget:self action:@selector(changVaule:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_subTf];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_WIDTH-40-15, 60*2*Screen_Scale/2-40/2, 40, 40)];
        [self.contentView addSubview:_iconImageView];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = 40/2;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.image = [UIImage imageNamed:@"home_banner"];
        _iconImageView.hidden = YES;
        
        UIView *horiView = [[UIView alloc] initWithFrame:CGRectMake(17, 60*2*Screen_Scale-0.5, SCR_WIDTH-17, 0.5)];
        [self.contentView addSubview:horiView];
        horiView.backgroundColor = [UIColor colorWithHex:@"f5f5f5"];
        
        
        self.arrowView = [[UIImageView alloc] init];
        self.arrowView.width = uiv(6);
        self.arrowView.height = uiv(11);
        self.arrowView.image = [UIImage imageNamed:@"icon_arrow_gray"];
        self.arrowView.right = SCR_WIDTH - UIValue(10);
        [self.contentView addSubview:self.arrowView];

    }
    return self;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    _subTf.tag = index;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 2){
        [GVUserDefaults standardUserDefaults].nickName = textField.text;
    }
}

//- (void)changVaule:(UITextField *)textFile
//{
//    if (_subTf.tag == 1) {
//        [GVUserDefaults standardUserDefaults].sex = textFile.text;
//    }else
//}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.arrowView.centerY = self.height / 2.0;
    self.subTf.right = self.arrowView.left - UIValue(10);
    self.iconImageView.right = self.subTf.right;
}

@end
