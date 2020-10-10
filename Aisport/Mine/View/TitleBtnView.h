//
//  TitleBtnView.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "TitleItemlView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TitleBtnView : TitleItemlView

@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *textField;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIImageView *markView;

@property (nonatomic, copy) void (^btnBlock) (void);


- (void)setText:(NSString *)Text;
- (void)setPlaceholder:(NSString *)placeholder;

- (void)setSelected:(BOOL)flag;


@end

NS_ASSUME_NONNULL_END
