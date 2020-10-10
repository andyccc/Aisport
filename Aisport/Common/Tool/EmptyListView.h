//
//  EmptyListView.h
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EmptyViewStyleHeJiList,
} EmptyViewStyle;

NS_ASSUME_NONNULL_BEGIN

@interface EmptyListView : UIView

- (instancetype)initWithFrame:(CGRect)frame AndType:(EmptyViewStyle)style;

@end

NS_ASSUME_NONNULL_END
