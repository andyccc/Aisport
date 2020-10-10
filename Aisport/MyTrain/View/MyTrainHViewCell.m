//
//  MyTrainHViewCell.m
//  Aisport
//
//  Created by Apple on 2020/11/25.
//

#import "MyTrainHViewCell.h"

@implementation MyTrainHViewCell

- (NSMutableArray *)rankViewArr
{
    if (!_rankViewArr) {
        _rankViewArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _rankViewArr;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *backBgView = [[UIView alloc] initWithFrame:CGRectMake(15*2*Screen_Scale, 0, SCR_WIDTH-15*2*2*Screen_Scale, 140*2*Screen_Scale)];
        [self addSubview:backBgView];
        backBgView.backgroundColor = [UIColor whiteColor];
        backBgView.layer.cornerRadius = 5;
//        backBgView.clipsToBounds = YES;
        backBgView.layer.shadowColor = [UIColor colorWithHex:@"#282828" alpha:0.25].CGColor;
        backBgView.layer.shadowOffset = CGSizeMake(0,5);
        backBgView.layer.shadowRadius = 7;
        backBgView.layer.shadowOpacity = 1;
//        backBgView.backgroundColor = [UIColor colorWithHex:@"#282828" alpha:0.23];
//        backBgView.layer.borderWidth = 0.5;
//        backBgView.layer.borderColor = [[UIColor colorWithHex:@"#282828"] CGColor];
 
        
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, backBgView.width, 140*2*Screen_Scale)];
        [backBgView addSubview:picImageView];
        picImageView.image = [UIImage imageNamed:@"train_rank"];
        picImageView.contentMode = UIViewContentModeScaleAspectFill;
        picImageView.layer.cornerRadius = 5;
        picImageView.clipsToBounds = YES;
        _picImageView = picImageView;
        
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, picImageView.width, picImageView.height)];
        [picImageView addSubview:coverView];
        coverView.layer.cornerRadius = 5;
        coverView.clipsToBounds = YES;
        coverView.backgroundColor = [UIColor colorWithHex:@"#282828" alpha:0.15];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, picImageView.bottom-30*2*Screen_Scale, picImageView.width-15*2-70, 30*2*Screen_Scale)];
        [picImageView addSubview:titleLabel];
        titleLabel.textColor = [UIColor colorWithHex:@"#FFFFFF"];
        titleLabel.font = fontBold(15);
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.numberOfLines = 0;
        titleLabel.text = @"帕梅拉-20min臀部+大腿负重训练丨全称讲解全称讲解全...";
        _titleLabel = titleLabel;
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(backBgView.width-60, picImageView.bottom-30*2*Screen_Scale, 60-10, 30*2*Screen_Scale)];
        [picImageView addSubview:timeLabel];
        timeLabel.textColor = [UIColor colorWithHex:@"#FFFFFF"];
        timeLabel.font = fontApp(11);
        timeLabel.textAlignment = NSTextAlignmentRight;
        timeLabel.text = @"12:20";
        _timeLabel = timeLabel;
        
        UIButton *playButton = [[UIButton alloc] initWithFrame:CGRectMake(backBgView.width/2-39*Screen_Scale, (140-39)*Screen_Scale, 39*2*Screen_Scale, 39*2*Screen_Scale)];
        [backBgView addSubview:playButton];
        [playButton setImage:[UIImage imageNamed:@"home_yulanplay"] forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(clickplayButton) forControlEvents:UIControlEventTouchUpInside];
        playButton.hidden = YES;
        
        
        [self.rankViewArr removeAllObjects];
        for (int i = 0; i < 4; i++) {
            UIView *rankView = [[UIView alloc] initWithFrame:CGRectMake(picImageView.right-10-7-(7+4)*(3-i), 10, 7, 15)];
            [picImageView addSubview:rankView];
            rankView.backgroundColor = [UIColor colorWithHex:@"#F3F3F3"];
            rankView.layer.cornerRadius = 2;
            rankView.clipsToBounds = YES;
            [self.rankViewArr addObject:rankView];
        }
    }
    return self;
}

- (void)setModel:(TrainVideoModel *)model
{
    _model = model;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:StringForId(model.cover)] placeholderImage:nil];
    _titleLabel.text = StringForId(model.name);
    _timeLabel.text = [DatetimeOpeartion getTimeHoursMinuteSecondHCurrentTimeWith:StringForId(model.time).longLongValue];
    for (int i = 0; i < [StringForId(model.lever) intValue]; i++) {
        UIView *view = self.rankViewArr[i];
        view.backgroundColor = [UIColor colorWithHex:@"#2BD6C5"];
    }
}

- (void)clickplayButton
{
    if (self.playMyVideoBlcok) {
        self.playMyVideoBlcok(StringForId(_model.url));
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
