//
//  VideoCoverView.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "VideoCoverView.h"

@implementation VideoCoverView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.playLabel = [[UILabel alloc] init];
        self.playLabel.width = self.width;
        self.playLabel.height = UIValue(14);
        self.playLabel.left = self.titleLabel.left;
        self.playLabel.font = FontR(10);
        self.playLabel.textColor = [UIColor colorWithHex:@"#999999"];
        [self addSubview:self.playLabel];
        
        self.hotBtn = [[UIButton alloc] init];
        self.hotBtn.width = UIValue(50);
        self.hotBtn.height = UIValue(16);
        self.hotBtn.titleLabel.font = FontR(10);
        self.hotBtn.right = self.width;
        [self.hotBtn setImage:[UIImage imageNamed:@"icon_hot"] forState:UIControlStateNormal];
        [self.hotBtn setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
        [self addSubview:self.hotBtn];
        
    }
    return self;
}

- (void)layout
{
    [super layout];
    
    self.playLabel.top = self.titleLabel.bottom;
    self.hotBtn.centerY = self.playLabel.centerY;

}

@end
