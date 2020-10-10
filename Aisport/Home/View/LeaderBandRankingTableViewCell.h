//
//  LeaderBandRankingTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/27.
//

#import "BaseTableViewCell.h"
#import "RankingView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeaderBandRankingTableViewCell : BaseTableViewCell
@property (nonatomic, strong) RankingView *rankingView;
- (void)setRankIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
