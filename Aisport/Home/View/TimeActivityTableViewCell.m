//
//  TimeActivityTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "TimeActivityTableViewCell.h"

@implementation TimeActivityTableViewCell

- (void)initSelf
{
    [super initSelf];
    
    self.leaderBandView = [[UIButton alloc] init];
    self.leaderBandView.width = UIValue(163);
    self.leaderBandView.height = UIValue(78);
    self.leaderBandView.left = self.countDownView.right + UIValue(13);
    [self.leaderBandView setBackgroundImage:[UIImage imageNamed:@"icon_leader_band"] forState:UIControlStateNormal];
    [self.leaderBandView addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.leaderBandView.tag = 1;
    [self.contentView addSubview:self.leaderBandView];

    self.leaderBandLabel = [[UILabel alloc] init];
    self.leaderBandLabel.width = UIValue(100);
    self.leaderBandLabel.height = UIValue(40);
    self.leaderBandLabel.left = UIValue(10);
    self.leaderBandLabel.top = UIValue(19);
    [self.leaderBandView addSubview:self.leaderBandLabel];
    self.leaderBandLabel.attributedText = [self createAttributedString:@"排行榜\n" info:@"RANKING"];
    self.leaderBandLabel.numberOfLines =4;
    
    self.quickMatchView.top = self.leaderBandView.bottom + UIValue(13);
    self.quickMatchView.height = UIValue(78);
    [self.quickMatchView setBackgroundImage:[UIImage imageNamed:@"icon_quick_match"] forState:UIControlStateNormal];
}


@end
