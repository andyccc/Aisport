//
//  HomeListViewCell.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "HomeListViewCell.h"
#import "CardStaticView.h"


@interface HomeListViewCell ()

@property (nonatomic, strong) CardStaticView *staticView;
@property (nonatomic, strong) UIImageView *classImageView;

@end

@implementation HomeListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //WithFrame:CGRectMake(16, 31, SCR_WIDTH-16*2, 96)
        _staticView = [[CardStaticView alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, 31, SCR_WIDTH-16*2*2*Screen_Scale, 96)];
        [self addSubview:_staticView];
        _staticView.backgroundColor = [UIColor whiteColor];
    //    [_staticView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(bottomView.mas_left).offset(16);
    //        make.right.equalTo(bottomView.mas_right).offset(-16);
    //        make.height.mas_equalTo(96);
    //        make.top.equalTo(bottomView.mas_top).offset(31);
    //    }];
        _staticView.layer.cornerRadius = 5;
        _staticView.layer.shadowColor = [UIColor colorWithHex:@"#000000" alpha:0.11].CGColor;
        _staticView.layer.shadowOffset = CGSizeMake(0,0);
        _staticView.layer.shadowOpacity = 1;
        _staticView.layer.shadowRadius = 12;
        
        
        _classImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16*2*Screen_Scale, _staticView.bottom+6, SCR_WIDTH-16*2*2*Screen_Scale, 146*2*Screen_Scale)];
        [self addSubview:_classImageView];
    //  _classImageView.backgroundColor = [UIColor yellowColor];
        _classImageView.image = [UIImage imageNamed:@"home_sportBanner"];
        _classImageView.userInteractionEnabled = NO;
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnAction)];
        [_classImageView addGestureRecognizer:tgr];

        UILabel *sportTiLabel = [[UILabel alloc] initWithFrame:CGRectMake(18*2*Screen_Scale, 42*2*Screen_Scale, _classImageView.width-(18+29+22)*2*Screen_Scale, 19)];
        [_classImageView addSubview:sportTiLabel];
        sportTiLabel.font = fontBold(19);
        sportTiLabel.textColor = [UIColor whiteColor];
        sportTiLabel.text = @"全身激活运动";
        
        UILabel *sportTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(18*2*Screen_Scale, sportTiLabel.bottom+16*2*Screen_Scale, _classImageView.width-(18+29+22)*2*Screen_Scale, 15)];
        [_classImageView addSubview:sportTimeLabel];
        sportTimeLabel.font = fontBold(19);
        sportTimeLabel.textColor = [UIColor whiteColor];
        sportTimeLabel.text = @"32min";
        
        
        UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(_classImageView.width-(29+22)*2*Screen_Scale, _classImageView.height/2-22*Screen_Scale, 22*2*Screen_Scale, 22*2*Screen_Scale)];
        [_classImageView addSubview:enterBtn];
        [enterBtn setImage:[UIImage imageNamed:@"home_enter"] forState:UIControlStateNormal];
    }
    return self;
}


- (void)btnAction
{
    
    if (self.homeCellJumpBlock) {
        self.homeCellJumpBlock();
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
