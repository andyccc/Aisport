//
//  SearchReusableView.h
//  Aisport
//
//  Created by sga on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchReusableView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, copy) void(^clearSearchHistory)();

- (void)fillData:(NSString *)content isClear:(BOOL)isClear;
+ (CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
