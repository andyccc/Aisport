//
//  SettinCentreViewCell.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "SettinCentreViewCell.h"

@implementation SettinCentreViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, 75, 50)];
        [self addSubview:_titleLab];
        _titleLab.textColor = [UIColor colorWithHex:@"#333333"];
        _titleLab.font = fontApp(16);
        
        _subTf = [[UITextField alloc]initWithFrame:CGRectMake(112, 0, SCR_WIDTH - 112-15, 50)];
        _subTf.textColor = [UIColor colorWithHex:@"#999999"];
        _subTf.font = fontApp(13);
        _subTf.textAlignment = NSTextAlignmentRight;
        _subTf.tag = _index;
        [_subTf addTarget:self action:@selector(changVaule:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:_subTf];
        
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCR_WIDTH-40-15, 50/2-40/2, 40, 40)];
        [self addSubview:_iconImageView];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.cornerRadius = 40/2;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.image = [UIImage imageNamed:@"home_banner"];
        _iconImageView.hidden = YES;
        
        UIView *horiView = [[UIView alloc] initWithFrame:CGRectMake(17, 50-0.5, SCR_WIDTH-17, 0.5)];
        [self addSubview:horiView];
        horiView.backgroundColor = [UIColor colorWithHex:@"f5f5f5"];
    }
    return self;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
    _subTf.tag = index;
}

- (void)changVaule:(UITextField *)textFile
{
    if (_subTf.tag == 1) {
        [GVUserDefaults standardUserDefaults].sex = textFile.text;
    }else if (_subTf.tag == 2){
        [GVUserDefaults standardUserDefaults].nickName = textFile.text;
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
