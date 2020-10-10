//
//  LeaderBandTitleView.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "LeaderBandTitleView.h"

@implementation LeaderBandTitleView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    UIView *maskView = [[UIView alloc] init];
    maskView.backgroundColor = [UIColor whiteColor];
    maskView.height = UIValue(46);
    maskView.width = self.width;
    maskView.layer.cornerRadius = maskView.height/2.0;
    maskView.layer.masksToBounds = YES;
    [self addSubview:maskView];

    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.top = maskView.height / 2.0;
    self.numberLabel.width = UIValue(36);
    self.numberLabel.height = UIValue(22);
    self.numberLabel.font = FontR(16);
    self.numberLabel.textColor = [UIColor colorWithHex:@"#666666"];
    self.numberLabel.left = UIValue(34);
    [self addSubview:self.numberLabel];
    self.numberLabel.text = @"序号";
    
    self.userLabel = [[UILabel alloc] init];
    self.userLabel.top = self.numberLabel.top;
    self.userLabel.width = UIValue(36);
    self.userLabel.height = UIValue(22);
    self.userLabel.font = FontR(16);
    self.userLabel.textColor = [UIColor colorWithHex:@"#666666"];
    self.userLabel.left = self.numberLabel.right + UIValue(36);
    [self addSubview:self.userLabel];
    self.userLabel.text = @"玩家";

    self.godEggsLabel = [[UILabel alloc] init];
    self.godEggsLabel.top = self.numberLabel.top;
    self.godEggsLabel.width = UIValue(36);
    self.godEggsLabel.height = UIValue(22);
    self.godEggsLabel.font = FontR(16);
    self.godEggsLabel.textColor = [UIColor colorWithHex:@"#666666"];
    self.godEggsLabel.right = SCR_WIDTH - UIValue(34);
    self.godEggsLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.godEggsLabel];
    self.godEggsLabel.text = @"金蛋";

}

@end
