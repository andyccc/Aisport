//
//  MineTitleIconViewCell.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "MineTitleIconViewCell.h"

@implementation MineTitleIconViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
//        self.backgroundColor = Bg_Color;
        
        _bodyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 60*2*Screen_Scale)];
        _bodyView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bodyView];
        
        _iconView = [[UIImageView alloc]initWithFrame:CGRectMake(17*2*Screen_Scale, 60*Screen_Scale-18*Screen_Scale, 18*2*Screen_Scale, 18*2*Screen_Scale)];
        [_bodyView addSubview:_iconView];
        
        _titleLab = [[UILabel alloc]initWithFrame:CGRectMake(_iconView.right+10, 0, 120, 60*2*Screen_Scale)];
        _titleLab.font = fontApp(16);
        _titleLab.textColor = [UIColor colorWithHex:@"#443C48"];
        [_bodyView addSubview:_titleLab];
        
        _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCR_WIDTH-15-15-90, 12, 90, 20)];
        _subLabel.font = fontApp(14);
        _subLabel.textAlignment = NSTextAlignmentRight;
        _subLabel.textColor = [UIColor colorWithHex:@"#9F9F9F"];
        [_bodyView addSubview:_subLabel];
        _subLabel.hidden = YES;
        
        UIImageView* arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_bodyView.width - 14-15, 17.5, 15, 15)];
        arrowImg.image = [UIImage imageNamed:@"arrow_tiaozhuan"];
        [_bodyView addSubview:arrowImg];
        _arrowImg = arrowImg;
        _arrowImg.hidden = YES;
    }
    return self;
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
