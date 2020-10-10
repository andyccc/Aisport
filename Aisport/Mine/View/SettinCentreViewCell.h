//
//  SettinCentreViewCell.h
//  Aisport
//
//  Created by Apple on 2020/10/28.
//

#import <UIKit/UIKit.h>

typedef enum {
    Adress_Cell_Tag = 0,
    About_Us_Cell_Tag = 1,
    Clear_Cache_Cell_Tag = 2,
    Check_Update_Cell_Tag = 3,
}Settin_Centre_View_Cell_Tag;

NS_ASSUME_NONNULL_BEGIN

@interface SettinCentreViewCellData  : NSObject

@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *contentStr;
@property (nonatomic, assign) Settin_Centre_View_Cell_Tag tag;

@end

@interface SettinCentreViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *horiView;

- (void)fillData:(SettinCentreViewCellData *)data;

@end

NS_ASSUME_NONNULL_END
