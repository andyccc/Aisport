//
//  VideoDetailParameterCell.m
//  Aisport
//
//  Created by sga on 2020/12/25.
//

#import "VideoDetailParameterCell.h"

#define Cell_Height  UIValue(85)

#define Content_Label_Tag 10000

@implementation VideoDetailParameterCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHex:@"#F5F5F5"];
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(UIValue(16), UIValue(5), SCR_WIDTH-UIValue(32), UIValue(75))];
    bgView.layer.cornerRadius = UIValue(16);
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    NSArray *params = @[@"难度系数", @"视频强度", @"视频曲目"];
    CGFloat width = bgView.width/params.count;
    for (int i = 0; i < params.count; i++) {
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*width + width/2.0 - UIValue(33), UIValue(20), UIValue(13), UIValue(13))];
        NSString *imageName = [NSString stringWithFormat:@"video_params_icon_%d",(i+1)];
        iconImageView.image = [UIImage imageNamed:imageName];
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [bgView addSubview:iconImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImageView.right + UIValue(2), UIValue(20), UIValue(100), UIValue(13))];
        titleLabel.textColor = [UIColor colorWithHex:@"#666666"];
        titleLabel.font = FontR(12);
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = params[i];
        [bgView addSubview:titleLabel];
        
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(width*i, titleLabel.bottom+UIValue(10), width, UIValue(16))];
        contentLabel.textColor = [UIColor colorWithHex:@"#333333"];
        contentLabel.font = FontBoldR(14);
        contentLabel.textAlignment = NSTextAlignmentCenter;
        contentLabel.tag = Content_Label_Tag + i;
        contentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [bgView addSubview:contentLabel];
    }
}

- (void)fillData:(VideoDetailInfoModel *)data
{
    UILabel *label1 = [self.contentView viewWithTag:Content_Label_Tag];
    label1.text = data.strengthStr;
    UILabel *label2 = [self.contentView viewWithTag:Content_Label_Tag + 1];
    label2.text = data.leaveStr;
    UILabel *label3 = [self.contentView viewWithTag:Content_Label_Tag + 2];
    label3.text = data.song;
}

+ (CGFloat)cellHeight
{
    return Cell_Height;
}

@end
