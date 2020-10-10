//
//  TwoImageTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "BaseTableViewCell.h"
#import "VideoCoverView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TwoImageTableViewCell : BaseTableViewCell

@property (nonatomic, strong) VideoCoverView *videoView1;
@property (nonatomic, strong) VideoCoverView *videoView2;
@property (nonatomic, copy) void (^tapBlock) (id data);

@end

NS_ASSUME_NONNULL_END
