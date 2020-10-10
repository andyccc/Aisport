//
//  QuickMatchActivityTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "QuickMatchActivityTableViewCell.h"

@implementation QuickMatchActivityTableViewCell

+ (CGFloat)cellHeight
{
    return uiv(169 + 10);
}

- (void)initSelf
{
    [super initSelf];

    self.quickMatchView = [[UIButton alloc] init];
    self.quickMatchView.width = UIValue(163);
    self.quickMatchView.height = UIValue(169);
    
    self.quickMatchView.top = self.countDownView.top;
    self.quickMatchView.left = self.countDownView.right + UIValue(13);
    
    [self.quickMatchView setBackgroundImage:[UIImage imageNamed:@"icon_quick_match_big"] forState:UIControlStateNormal];
    [self.quickMatchView addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.quickMatchView.tag = 2;
    [self.contentView addSubview:self.quickMatchView];
    
    self.quickMatchLabel = [[UILabel alloc] init];
    self.quickMatchLabel.width = UIValue(100);
    self.quickMatchLabel.height = UIValue(40);
    self.quickMatchLabel.left = UIValue(10);
    self.quickMatchLabel.top = UIValue(19);
    [self.quickMatchView addSubview:self.quickMatchLabel];
    self.quickMatchLabel.attributedText = [self createAttributedString:@"快速匹配\n" info:@"MATCHING"];
    self.quickMatchLabel.numberOfLines =4;

}

@end
