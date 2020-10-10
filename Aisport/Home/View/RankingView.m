//
//  RankingView.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "RankingView.h"

@implementation RankingView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
//    @property (nonatomic, strong) UIButton *indexBtn;
//    @property (nonatomic, strong) UIImageView *avatarView;
//    @property (nonatomic, strong) UILabel *nickLabel;
//    @property (nonatomic, strong) UILabel *eggsLabel;

    self.indexBtn = [[UIButton alloc] init];
    self.indexBtn.width = UIValue(25);
    self.indexBtn.height = UIValue(29);
    self.indexBtn.left = UIValue(41);
    self.indexBtn.centerY = self.height / 2.0;
    self.indexBtn.titleLabel.font = FontR(14);
    [self addSubview:self.indexBtn];
    
    self.avatarView = [[UIImageView alloc] init];
    self.avatarView.width = UIValue(38);
    self.avatarView.height = UIValue(38);
    self.avatarView.centerY = self.indexBtn.centerY;
    self.avatarView.left = self.indexBtn.right + UIValue(38);
    self.avatarView.layer.cornerRadius = self.avatarView.height / 2.0;
    self.avatarView.layer.masksToBounds = YES;
    [self addSubview:self.avatarView];
    
    self.nickLabel = [[UILabel alloc] init];
    self.nickLabel.width = self.width / 2;
    self.nickLabel.height = self.height;
    self.nickLabel.left = self.avatarView.right + UIValue(8);
    self.nickLabel.font = FontBoldR(14);
    self.nickLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
    [self addSubview:self.nickLabel];
    
    
    self.eggsLabel = [[UILabel alloc] init];
    self.eggsLabel.width = self.width / 2;
    self.eggsLabel.height = self.height;
    self.eggsLabel.right = self.width - UIValue(34);
    self.eggsLabel.font = FontR(14);
    self.eggsLabel.textColor = [UIColor colorWithHex:@"#333333"];
    self.eggsLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.eggsLabel];
    
    
}

- (void)setBtnImage
{
    [self.indexBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    CGSize imageSize = self.indexBtn.imageView.size;
    self.indexBtn.imageEdgeInsets = UIEdgeInsetsMake(0, UIValue(3), 0, UIValue(3));
    self.indexBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width, 0, 0);

}

- (void)setNumber:(NSInteger)index
{
    [self.indexBtn setTitle:[NSString stringWithFormat:@"%d", index] forState:UIControlStateNormal];
    if (index == 1) {
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_index_one"] forState:UIControlStateNormal];
        [self.indexBtn setBackgroundImage:[UIImage imageNamed:@"icon_index_one_bg"] forState:UIControlStateNormal];
        
        [self setBtnImage];
    } else if (index == 2) {
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_index_two"] forState:UIControlStateNormal];
        [self.indexBtn setBackgroundImage:[UIImage imageNamed:@"icon_index_two_bg"] forState:UIControlStateNormal];
        
        [self setBtnImage];
    } else if (index == 3) {
        [self.indexBtn setImage:[UIImage imageNamed:@"icon_index_three"] forState:UIControlStateNormal];
        [self.indexBtn setBackgroundImage:[UIImage imageNamed:@"icon_index_three_bg"] forState:UIControlStateNormal];
        
        [self setBtnImage];
    } else {
        
        [self.indexBtn setImage:nil forState:UIControlStateNormal];
        [self.indexBtn setBackgroundImage:nil forState:UIControlStateNormal];

        [self.indexBtn setTitleColor:[UIColor colorWithHex:@"#666666"] forState:UIControlStateNormal];
    }
    
    
}

@end
