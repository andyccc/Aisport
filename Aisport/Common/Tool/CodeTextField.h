//
//  CodeTextField.h
//  Aisport
//
//  Created by Apple on 2020/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CodeTextFieldDelegate <NSObject>

@optional
- (void)deleteBackward;

@end

@interface CodeTextField : UITextField

@property (nonatomic, weak) id<CodeTextFieldDelegate> keyInputDelegate;

@end

NS_ASSUME_NONNULL_END
