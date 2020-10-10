//
//  RecentJumpTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "RecentJumpTableViewCell.h"

@interface RecentJumpTableViewCell ()

@property (nonatomic, strong) UIImageView *coverView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *authorLabel;


@end

@implementation RecentJumpTableViewCell

+ (CGFloat)cellHeight
{
    return uiv(71 + 30);
}

- (void)initSelf
{
    self.coverView = [[UIImageView alloc] init];
    self.coverView.width = uiv(101);
    self.coverView.height = uiv(71);
    self.coverView.top = uiv(15);
    self.coverView.left = uiv(20);
    self.coverView.layer.cornerRadius = 4;
    self.coverView.layer.masksToBounds = YES;
    
    [self.contentView addSubview:self.coverView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.width = SCR_WIDTH;
    self.titleLabel.height = uiv(20);
    self.titleLabel.left = self.coverView.right + uiv(12);
    self.titleLabel.top = self.coverView.top + 3;
    self.titleLabel.font = FontBoldR(19);
    self.titleLabel.textColor = [UIColor colorWithHex:@"#333333"];

    [self.contentView addSubview:self.titleLabel];

    
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.width = self.titleLabel.width;
    self.authorLabel.height = uiv(16);
    
    self.authorLabel.left = self.titleLabel.left;
    self.authorLabel.top = self.titleLabel.bottom + uiv(12);
    self.authorLabel.font = FontBoldR(15);
    self.authorLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];

    [self.contentView addSubview:self.authorLabel];
    
}

- (void)fillData:(id)data
{
    NSString *cover = data[@"cover"];
    NSString *title = data[@"name"];
    NSString *author = data[@"author"];
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:StringForId(cover)] placeholderImage:nil];
    self.titleLabel.text = title;
    self.authorLabel.text = author;
    
}


@end
