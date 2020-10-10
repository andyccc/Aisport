//
//  CourseShareView.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^CancleBtnClickBlock)(void);

@interface CourseShareView : UIView

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, copy) CancleBtnClickBlock cancleBtnClickBlock;

- (instancetype)initWithFrame:(CGRect)frame HomeListModel:(HomeListModel *)model WithImage:(UIImage *)coverImage;

@end

NS_ASSUME_NONNULL_END
