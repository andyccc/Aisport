//
//  MyAddressTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "MyAddressTableViewCell.h"

@interface MyAddressTableViewCell()
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation MyAddressTableViewCell


+ (CGFloat)cellHeight
{
    return uiv(118 + 16);
}

- (void)initSelf
{
    self.bgView = [[UIView alloc] init];
    self.bgView.width = UIScreenWidth - UIV(16 *2);
    self.bgView.height = UIV(118);
    self.bgView.left = UIV(16);
    self.bgView.top = UIV(8);
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = UIV(10);
    self.bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.bgView];
    
    self.userLabel = [[UILabel alloc] init];
    self.userLabel.width = self.bgView.width;
    self.userLabel.height = uiv(22);
    self.userLabel.top = uiv(17);
    self.userLabel.left = uiv(22);
    self.userLabel.font = FontR(15);
    self.userLabel.textColor = [UIColor colorWithHex:@"#333333"];
    [self.bgView addSubview:self.userLabel];
    
    
    self.addressLabel = [[UILabel alloc] init];
    self.addressLabel.width = self.bgView.width;
    self.addressLabel.height = uiv(22);
    self.addressLabel.left = uiv(22);
    self.addressLabel.top = self.userLabel.bottom + uiv(7);
    self.addressLabel.textColor = [UIColor colorWithHex:@"#999999"];
    self.addressLabel.font = FontR(12);
    [self.bgView addSubview:self.addressLabel];
    
    self.selectBtn = [[UIButton alloc] init];
    self.selectBtn.width = uiv(15 + 5 + 48);
    self.selectBtn.height = uiv(20);
    self.selectBtn.left = uiv(22);


    self.selectBtn.bottom = self.bgView.height - uiv(14);
    [self.selectBtn setImage:[UIImage imageNamed:@"icon_un_selected"] forState:UIControlStateNormal];
    [self.selectBtn setImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
    [self.selectBtn setTitle:@"默认地址" forState:UIControlStateNormal];
    [self.selectBtn setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
    self.selectBtn.titleLabel.font = FontR(12);
    [self.bgView addSubview:self.selectBtn];
    [self.selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];

    self.deleteBtn = [[UIButton alloc] init];
    self.deleteBtn.width = uiv(45);
    self.deleteBtn.height = uiv(45);
    self.deleteBtn.bottom = self.bgView.height;
    self.deleteBtn.right = self.bgView.width;
    [self.deleteBtn setImage:[UIImage imageNamed:@"icon_delete2"] forState:UIControlStateNormal];
    [self.bgView addSubview:self.deleteBtn];
    [self.deleteBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];

    self.editBtn = [[UIButton alloc] init];
    self.editBtn.width = uiv(45);
    self.editBtn.height = uiv(45);
    self.editBtn.bottom = self.bgView.height;
    self.editBtn.right = self.deleteBtn.left;
    [self.editBtn setImage:[UIImage imageNamed:@"icon_edit2"] forState:UIControlStateNormal];
    [self.bgView addSubview:self.editBtn];
    [self.editBtn addTarget:self action:@selector(editedAction) forControlEvents:UIControlEventTouchUpInside];

}


- (void)fillData:(id)data
{
    NSString *user = data[@"name"];
    NSString *phone = data[@"tel"];
    
    if ([phone length] > 7) {
        phone = [phone stringByReplacingOccurrencesOfString:[phone substringWithRange:NSMakeRange(3,4)] withString:@"****"];
    }
    
    NSString *area = [NSString stringWithFormat:@"%@%@%@%@",
                      data[@"provinceName"],
                      data[@"cityName"],
                      data[@"countyName"],
                      data[@"addressDetail"]
                      ];

    self.userLabel.text = [NSString stringWithFormat:@"%@ %@", user, phone];
    self.addressLabel.text = area;
    self.selectBtn.selected = [data[@"isDefault"] intValue];
    
}

- (void)editedAction
{
    !self.actionBlock ?: self.actionBlock(1);
}

- (void)deleteAction
{
    !self.actionBlock ?: self.actionBlock(2);
}

- (void)selectAction
{
    !self.actionBlock ?: self.actionBlock(0);
}







@end
