//
//  SettinCentreViewCell.m
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import "SettinCentreViewCell.h"

@implementation SettinCentreViewCellData

@synthesize titleStr = _titleStr;
@synthesize contentStr = _contentStr;
@synthesize tag = _tag;

@end

@implementation SettinCentreViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.horiView];
    }
    return self;
}

- (void)fillData:(SettinCentreViewCellData *)data
{
    self.titleLab.text = data.titleStr;
    self.contentLabel.text = data.contentStr;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(39, 0, 150, 78*2*Screen_Scale)];
        _titleLab.textColor = [UIColor colorWithHex:@"#333333"];
        _titleLab.font = fontApp(15);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, SCR_WIDTH - 200 - 44,78*2*Screen_Scale)];
        _contentLabel.textAlignment = NSTextAlignmentRight;
        _contentLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _contentLabel.font = fontApp(14);
    }
    return _contentLabel;
}

- (UIView *)horiView
{
    if (!_horiView) {
        _horiView = [[UIView alloc] initWithFrame:CGRectMake(39, 78*2*Screen_Scale-1, SCR_WIDTH-39-20, 1)];
        _horiView.backgroundColor = [UIColor colorWithHex:@"f5f5f5"];
    }
    return _horiView;
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
