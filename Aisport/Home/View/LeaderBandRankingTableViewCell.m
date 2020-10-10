//
//  LeaderBandRankingTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "LeaderBandRankingTableViewCell.h"

@implementation LeaderBandRankingTableViewCell


+ (CGFloat)cellHeight
{
    return UIValue(38 + 18);
}

- (void)initSelf
{
    self.contentView.backgroundColor = [UIColor whiteColor];

    self.rankingView = [[RankingView alloc] initWithFrame:CGRectMake(0, UIValue(9), SCR_WIDTH, UIValue(38))];
    [self addSubview:self.rankingView];
    
}

- (void)setRankIndex:(NSInteger)index
{
    [self.rankingView setNumber:index];
}

- (void)fillData:(id)data
{
    self.rankingView.nickLabel.text = data[@"nickName"];
    [self.rankingView.avatarView sd_setImageWithURL:[NSURL URLWithString:data[@"headImage"]]];
    self.rankingView.eggsLabel.text = [data[@"total"] description];
    
}

@end
