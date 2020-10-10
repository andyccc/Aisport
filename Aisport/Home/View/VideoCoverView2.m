//
//  VideoCoverView2.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "VideoCoverView2.h"

@implementation VideoCoverView2


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    self.coverView = [[UIImageView alloc] init];
    self.coverView.layer.masksToBounds = YES;
    self.coverView.clipsToBounds = YES;
    self.coverView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.coverView];
    
    self.lveLabel = [[UILabel alloc] init];
    self.lveLabel.width = UIValue(40);
    self.lveLabel.height = UIValue(18);
    self.lveLabel.top = UIValue(10);
    self.lveLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.lveLabel.textColor = [UIColor whiteColor];
    self.lveLabel.textAlignment = NSTextAlignmentCenter;
    self.lveLabel.font = FontR(10);
    self.lveLabel.layer.cornerRadius = self.lveLabel.height/ 2.0;
    self.lveLabel.layer.masksToBounds = YES;
    [self addSubview:self.lveLabel];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.height = UIValue(20);
    self.titleLabel.left = self.coverView.left;
    self.titleLabel.font = FontR(14);
    self.titleLabel.textColor = [UIColor colorWithHex:@"#333333"];
    [self addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.tapBtn = [[UIButton alloc] initWithFrame:self.bounds];
    [self addSubview:self.tapBtn];

}

- (void)layout
{
    self.coverView.width = self.width;
    if (self.coverView.height <= 0) {
        self.coverView.height = self.width;
    }
    self.lveLabel.right = self.coverView.width - UIValue(10);

    self.coverView.layer.cornerRadius = UIValue(10);
    self.titleLabel.width = self.coverView.width;
    self.titleLabel.top = self.coverView.bottom + UIValue(3);
    
    [self bringSubviewToFront:self.tapBtn];
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


@end
