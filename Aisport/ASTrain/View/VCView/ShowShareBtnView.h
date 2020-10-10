//
//  ShowShareBtnView.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ClickShareBlock)(NSInteger index);
@interface ShowShareBtnView : UIView

@property (nonatomic, copy) ClickShareBlock clickShareBlock;

@end

NS_ASSUME_NONNULL_END
