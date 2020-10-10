//
//  SearchTableViewCell.m
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import "SearchTableViewCell.h"
#import "VideoElementListModel.h"
#import "YYKit.h"

@interface SearchTableViewCell()

@property (nonatomic, strong) UIImageView *iconImageview;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *authorView;
@property (nonatomic, strong) UILabel *authorLabel;


@property (nonatomic, strong) UILabel *lveLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIImageView *hotView;
@property (nonatomic, strong) UILabel *hotLabel;


//@property (nonatomic, strong) UIButton *hotBtn;
@property (nonatomic, strong) UILabel *playLabel;

@end

@implementation SearchTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];

        self.iconImageview = [[UIImageView alloc] initWithFrame:CGRectMake(uiv(16), UIValue(6), UIValue(166), UIValue(93))];
        self.iconImageview.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImageview.layer.cornerRadius = 10;
        self.iconImageview.layer.masksToBounds = YES;
        self.iconImageview.backgroundColor = [UIColor colorWithHex:@"#f3f4f8"];
        [self.contentView addSubview:self.iconImageview];
        
        self.lveLabel = [[UILabel alloc] init];
        self.lveLabel.width = UIValue(40);
        self.lveLabel.height = UIValue(18);
        self.lveLabel.top = UIValue(10);
        self.lveLabel.right = self.iconImageview.width - UIValue(10);
        self.lveLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.lveLabel.textColor = [UIColor whiteColor];
        self.lveLabel.textAlignment = NSTextAlignmentCenter;
        self.lveLabel.font = FontR(10);
        self.lveLabel.layer.cornerRadius = self.lveLabel.height/ 2.0;
        self.lveLabel.layer.masksToBounds = YES;
        [self.iconImageview addSubview:self.lveLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom + 35, UIValue(30), UIValue(16))];
        self.timeLabel.bottom = self.iconImageview.height - UIValue(10);
        self.timeLabel.right = self.iconImageview.width - UIValue(10);
        self.timeLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
        self.timeLabel.font = FontR(10);
        self.timeLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        self.timeLabel.layer.cornerRadius = self.playLabel.height /2.0;
        self.timeLabel.layer.masksToBounds = YES;
        [self.iconImageview addSubview:self.timeLabel];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageview.right + 13, self.iconImageview.top + UIValue(13),0,UIValue(20))];
        self.titleLabel.width = SCR_WIDTH - self.titleLabel.left - UIValue(16);
        self.titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
        self.titleLabel.font = FontR(14);
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.titleLabel];
        
        self.authorView = [[UIImageView alloc] init];
        self.authorView.width = UIValue(11);
        self.authorView.height = UIValue(11);
        self.authorView.image = [UIImage imageNamed:@"icon_author_user"];
        self.authorView.left = self.titleLabel.left;
        [self.contentView addSubview:self.authorView];
        
        self.authorLabel = [[UILabel alloc] init];
        self.authorLabel.height = UIValue(16);
        self.authorLabel.font = FontR(10);
        self.authorLabel.textColor = [UIColor colorWithHex:@"#999999"];
        self.authorLabel.left = self.authorView.right + uiv(3);
        self.authorLabel.width = SCR_WIDTH - UIValue(16) - self.authorLabel.left;
        [self.contentView addSubview:self.authorLabel];
        self.authorLabel.numberOfLines = 3;
        
        self.hotView = [[UIImageView alloc] init];
        self.hotView.width = UIValue(11);
        self.hotView.height = UIValue(12);
        self.hotView.image = [UIImage imageNamed:@"icon_hot"];
        self.hotView.left = self.titleLabel.left;
        [self.contentView addSubview:self.hotView];
        self.hotView.bottom = self.iconImageview.bottom - UIValue(3);

        self.hotLabel = [[UILabel alloc] init];
        self.hotLabel.width = SCR_WIDTH / 2.0;
        self.hotLabel.height = UIValue(16);
        self.hotLabel.font = FontR(10);
        self.hotLabel.textColor = [UIColor colorWithHex:@"#999999"];
        self.hotLabel.left = self.hotView.right + uiv(3);
        [self.contentView addSubview:self.hotLabel];
        self.hotLabel.centerY = self.hotView.centerY;
        
        
        self.authorView.bottom = self.hotView.top - UIValue(4);
        self.authorLabel.centerY = self.authorView.centerY;
        
        self.playLabel = [[UILabel alloc] init];
        self.playLabel.width = UIValue(150);
        self.playLabel.height = UIValue(16);
        self.playLabel.right = SCR_WIDTH - UIValue(16);
        self.playLabel.centerY = self.hotView.centerY;
        self.playLabel.textAlignment = NSTextAlignmentRight;
        self.playLabel.textColor = [UIColor colorWithHex:@"#999999"];
        self.playLabel.font = FontR(10);
        [self.contentView addSubview:self.playLabel];
        
//        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(UIScreenWidth - 22, 0, 7, 10)];
//        self.arrowImageView.image = [UIImage imageNamed:@"icon_right_tint.png"];
//        self.arrowImageView.centerY = 52;
//        self.arrowImageView.backgroundColor = [UIColor redColor];
//        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (void)fillCell:(VideoElementListModel *)data
{
    NSString *palyCount = [data.playTotal description];
    NSNumber *lever = data.lever;
    NSString *author = data.author;
    NSString *hotCount = [data.curHighScore description];
    if (!hotCount) {
        hotCount = @"0";
    }
    if (!palyCount) {
        palyCount = @"0";
    }
    [self.iconImageview sd_setImageWithURL:[NSURL URLWithString:data.cover]];
    
    self.titleLabel.text = data.name;
    self.titleLabel.height = [self.titleLabel.text heightForFont:self.titleLabel.font width:self.titleLabel.width];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d",data.time.intValue/60,data.time.intValue%60];

    self.authorLabel.text = author;
    self.authorLabel.height = [self.authorLabel.text heightForFont:self.authorLabel.font width:self.authorLabel.width];
    self.authorLabel.bottom = self.hotView.top - UIValue(4);
    self.authorView.centerY = self.authorLabel.centerY;
    
    
    self.playLabel.text = [NSString stringWithFormat:@"当前记录：%@", palyCount];
    self.hotLabel.text = hotCount;
    
    [self setLev:[lever intValue]];
}


- (void)setLev:(int)type
{
    if (type == 1) {
        self.lveLabel.text = @"简单";
    } else if (type == 2) {
        self.lveLabel.text = @"中等";
    } else if (type == 3) {
        self.lveLabel.text = @"困难";
    } else {
        self.lveLabel.text = @"";
    }
}



+ (CGFloat)rowHeight
{
    return UIValue(93+12);
}
@end
