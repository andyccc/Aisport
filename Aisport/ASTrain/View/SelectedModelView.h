//
//  SelectedModelView.h
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackSelectedModelBlock)(void);
typedef void(^ClickOKModelBlock)(BOOL isSelecedTV);

@interface SelectedModelView : UIView

@property (nonatomic, copy) BackSelectedModelBlock backSelectedBlock;
@property (nonatomic, copy) ClickOKModelBlock clickOKModelBlock;

@end

NS_ASSUME_NONNULL_END
