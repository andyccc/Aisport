//
//  BaseTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/23.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

+ (id)dequeueReusableWith:(UITableView *)tableView
{
    NSString *identifier = NSStringFromClass([self class]);
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self.class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initSelf];
    }
    return self;
}

+ (CGFloat)cellHeight:(id)data
{
    return 0;
}

+ (CGFloat)cellHeight
{
    return [self cellHeight:nil];
}

- (void)initSelf
{
    
}

- (void)fillData:(id)data
{
    
}



@end
