//
//  ProfileTableViewCell.h
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *subTf;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIImageView *arrowView;

@end

NS_ASSUME_NONNULL_END
