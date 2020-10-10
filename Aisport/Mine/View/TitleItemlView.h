//
//  TitleItemlView.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleItemlView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

- (void)setTitle:(NSString *)title;


@end

NS_ASSUME_NONNULL_END
