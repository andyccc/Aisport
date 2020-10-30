//
//  SettinCentreViewCell.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettinCentreViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UITextField *subTf;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
