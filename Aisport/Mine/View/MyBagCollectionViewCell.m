//
//  MyBagCollectionViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "MyBagCollectionViewCell.h"

@interface MyBagCollectionViewCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numLabel;

@end

@implementation MyBagCollectionViewCell

+ (CGSize)sizeForItemCell
{
    return CGSizeMake(UIValue(70), UIValue(97));
}

- (void)initSelf
{
    self.bgView = [[UIView alloc] init];
    self.bgView.width = uiv(70);
    self.bgView.height = uiv(70);
    self.bgView.layer.cornerRadius = uiv(5);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    self.coverView = [[UIImageView alloc] init];
    self.coverView.contentMode = UIViewContentModeScaleAspectFit;
    self.coverView.width = uiv(60);
    self.coverView.height = uiv(60);
    self.coverView.left = UIValue(5);
    self.coverView.top = UIValue(5);
    [self.bgView addSubview:self.coverView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.height = UIValue(20);
    self.titleLabel.width = uiv(70);
    self.titleLabel.top = self.coverView.bottom + UIValue(7);
    self.titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    self.titleLabel.font = FontR(13);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    
    self.numLabel = [[UILabel alloc] init];
    self.numLabel.width = UIValue(30);
    self.numLabel.height = UIValue(15);
    self.numLabel.right = self.bgView.right + UIValue(10);
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.font = FontR(9);
    self.numLabel.backgroundColor = [UIColor colorWithHex:@"#F48F45"];
    self.numLabel.layer.cornerRadius = self.numLabel.height /2.0;
    self.numLabel.layer.masksToBounds = YES;

    [self.contentView addSubview:self.numLabel];

}

- (void)fillData:(id)data
{
    NSString *cover = data[@"propsImage"];
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:StringForId(cover)] placeholderImage:nil];
    NSNumber *num = data[@"total"];
    self.numLabel.text = [NSString stringWithFormat:@"X%@",num];
    self.titleLabel.text = data[@"propsName"];
}

@end
