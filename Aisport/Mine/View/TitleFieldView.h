//
//  TitleFieldView.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "TitleItemlView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TitleFieldView : TitleItemlView

@property (nonatomic, strong) UITextField *textField;

- (void)setText:(NSString *)Text;
- (void)setPlaceholder:(NSString *)placeholder;


@end


NS_ASSUME_NONNULL_END
