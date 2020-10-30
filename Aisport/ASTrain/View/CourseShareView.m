//
//  CourseShareView.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "CourseShareView.h"

@implementation CourseShareView

- (instancetype)initWithFrame:(CGRect)frame HomeListModel:(HomeListModel *)model
{
    if (self = [super initWithFrame:frame]) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(22, StatusHeight + 17, 27, 27);
        [backButton setImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-100, StatusHeight+17, 200, 15)];
        [self addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = fontBold(16);
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.text = @"课程分享";
        
        UIView *middleBgView = [[UIView alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, titleLabel.bottom+16*2*Screen_Scale, SCR_WIDTH-13*2*2*Screen_Scale, 423*2*Screen_Scale)];
        [self addSubview:middleBgView];
        middleBgView.backgroundColor = [UIColor colorWithHex:@"#46342A"];
        middleBgView.layer.cornerRadius = 7;
        middleBgView.clipsToBounds = YES;
        
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, middleBgView.width, 252*2*Screen_Scale)];
        [middleBgView addSubview:picImageView];
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
        picImageView.clipsToBounds = YES;
        [picImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(model.detailCover)] placeholderImage:nil];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, picImageView.bottom, middleBgView.width-13*2*2*Screen_Scale, 44*2*Screen_Scale)];
        [middleBgView addSubview:nameLabel];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = fontBold(21);
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.text = StringForId(model.name);
        
        UILabel *nameSubLabel = [[UILabel alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, nameLabel.bottom, middleBgView.width-13*2*2*Screen_Scale, 12)];
        [middleBgView addSubview:nameSubLabel];
        nameSubLabel.textAlignment = NSTextAlignmentLeft;
        nameSubLabel.font = fontApp(12);
        nameSubLabel.textColor = [UIColor whiteColor];
        nameSubLabel.text = [NSString stringWithFormat:@"%@  中等",StringForId(model.content)];
        
        UIView *whiteBgView = [[UIView alloc] initWithFrame:CGRectMake(13*2*Screen_Scale, nameSubLabel.bottom+12, middleBgView.width-13*2*2*Screen_Scale, 92*2*Screen_Scale)];
        [middleBgView addSubview:whiteBgView];
        whiteBgView.backgroundColor = [UIColor whiteColor];
        whiteBgView.layer.cornerRadius = 7;
        whiteBgView.clipsToBounds = YES;
        
        NSArray *titleArr = @[@"时长",@"消耗",@"难度"];
        NSArray *numArr = @[@"30",@"567",@"中等"];
        NSArray *numArr1 = @[@"min",@"kcal",@""];
        CGFloat numW = whiteBgView.width/3;
        for (int i = 0; i < titleArr.count; i++) {
            
            UILabel *numTiLab = [[UILabel alloc] initWithFrame:CGRectMake(numW*i, 22, numW, 12)];
            [whiteBgView addSubview:numTiLab];
            numTiLab.textColor = [UIColor colorWithHex:@"#333333"];
            numTiLab.font = fontApp(12);
            numTiLab.textAlignment = NSTextAlignmentCenter;
            numTiLab.text = titleArr[i];
            
            UILabel *numberLab = [[UILabel alloc] initWithFrame:CGRectMake(numW*i, numTiLab.bottom+17, numW, 14)];
            [whiteBgView addSubview:numberLab];
//            numberLab.textColor = [UIColor colorWithHex:@"#333333"];
//            numberLab.font = fontBold(19);
            numberLab.textAlignment = NSTextAlignmentCenter;
//            numberLab.text = numArr[i];
//            [self.titleLabArr addObject:numberLab];
            NSMutableAttributedString *numAttri = [[NSMutableAttributedString alloc] initWithString:numArr[i] attributes:@{NSFontAttributeName:fontBold(16),NSForegroundColorAttributeName:[UIColor colorWithHex:@"#333333"]}];
            if (i != 2) {
                NSMutableAttributedString *numAfterAttri = [[NSMutableAttributedString alloc] initWithString:numArr1[i] attributes:@{NSFontAttributeName:fontApp(12),NSForegroundColorAttributeName:[UIColor colorWithHex:@"#333333"]}];
                [numAttri appendAttributedString:numAfterAttri];
            }
            numberLab.attributedText = numAttri;
            
            if (i == 0) {
                numberLab.text = StringNumForId(model.playTotal, @"0");
            }else if (i == 1){
                numberLab.text = StringNumForId(model.highScore, @"0");
            }
        }
        
        UIView *erweimaBgView = [[UIView alloc] initWithFrame:CGRectMake(SCR_WIDTH/2-170*Screen_Scale, middleBgView.bottom+15, 170*2*Screen_Scale, 62*2*Screen_Scale)];
        [self addSubview:erweimaBgView];
        erweimaBgView.backgroundColor = [UIColor colorWithHex:@"#FFFFFF" alpha:0.25];
        erweimaBgView.layer.cornerRadius = 5;
        erweimaBgView.clipsToBounds = YES;
        
        
        UIImageView *codeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4*2*Screen_Scale, erweimaBgView.height/2-51*Screen_Scale, 51*2*Screen_Scale, 51*2*Screen_Scale)];
        [erweimaBgView addSubview:codeImageView];
        codeImageView.contentMode = UIViewContentModeScaleAspectFill;
        codeImageView.clipsToBounds = YES;
        
        UILabel *codeUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(codeImageView.right+5, 14, erweimaBgView.width-codeImageView.right-5, 13)];
        [erweimaBgView addSubview:codeUpLabel];
        codeUpLabel.font = fontApp(13);
        codeUpLabel.textColor = [UIColor whiteColor];
        codeUpLabel.text = @"嗨动AI健身课程";
        
        UILabel *codeDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(codeImageView.right+5, codeUpLabel.bottom+10, erweimaBgView.width-codeImageView.right-5, 12)];
        [erweimaBgView addSubview:codeDownLabel];
        codeDownLabel.font = fontApp(12);
        codeDownLabel.textColor = [UIColor whiteColor];
        codeDownLabel.text = @"长按扫码.一起运动";
    }
    return self;
}


- (void)backButtonClick
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
