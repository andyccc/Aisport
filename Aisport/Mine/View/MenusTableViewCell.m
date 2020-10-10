//
//  MenusTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import "MenusTableViewCell.h"

@interface MenusTableViewCell ()

@property (nonatomic, strong) UIView *bgView;


@end

@implementation MenusTableViewCell


+ (CGFloat)cellHeight
{
    return UIV(77 + 16);
}

- (void)initSelf
{

    self.bgView = [[UIView alloc] init];
    self.bgView.width = UIScreenWidth - UIV(16 *2);
    self.bgView.height = UIV(77);
    self.bgView.left = UIV(16);
    self.bgView.top = UIV(8);
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = UIV(10);
    
    [self.contentView addSubview:self.bgView];
    CGFloat space = self.bgView.width / 4.0;

    {
        UIButton *btn = [self createBtnWithTitle:@"最近跳过" icon:@"icon_recent"];
        btn.centerX = space * 0.5;
        [self.bgView addSubview:btn];

    }
    
    {
        UIButton *btn = [self createBtnWithTitle:@"我的背包" icon:@"icon_my_bag"];
        btn.centerX = space * 1.5;
        btn.tag = 1;
        [self.bgView addSubview:btn];

    }
    
    {
        UIButton *btn = [self createBtnWithTitle:@"积分明细" icon:@"icon_score_detail"];
        btn.centerX = space * 2.5;
        btn.tag = 2;
        [self.bgView addSubview:btn];

    }
    
    {
        UIButton *btn = [self createBtnWithTitle:@"积分商城" icon:@"icon_shop"];
        btn.centerX = space * 3.5;
        btn.tag = 3;
        [self.bgView addSubview:btn];

    }
}

- (void)btnAction:(UIButton *)btn
{
    !self.btnBlock ?: self.btnBlock(btn.tag);
}

- (UIButton *)createBtnWithTitle:(NSString *)title icon:(NSString *)icon
{
    UIButton *btn = [[UIButton alloc] init];
    btn.width = uiv(50);
    btn.height = uiv(31 + 16 + 3);
    btn.centerY = UIV(77/2.0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor colorWithHex:@"#666666"] forState:UIControlStateNormal];
    UILabel *titleLabel = btn.titleLabel;
    titleLabel.font = FontBoldR(11);
    
    [titleLabel sizeToFit];
    titleLabel.width = btn.width ;
    
    
    CGSize imageSize = btn.imageView.size;
    
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.height - titleLabel.height, -imageSize.width * 1.5, 0, 0)];
    //图片距离右边框距离减少图片的宽度，其它不边
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-(btn.height - imageSize.height), 0, 0, -titleLabel.bounds.size.width)];


    
    return btn;
}


@end
