//
//  BaseViewController.h
//  aisport
//
//  Created by Apple on 2020/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

- (void)setRightNavBtnWithIcon:(NSString *)icon;
- (void)setRightNavBtnWithTitle:(NSString *)title;

- (void)rightNavBtnAction;

@end

NS_ASSUME_NONNULL_END
