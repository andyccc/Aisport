//
//  AreaSelectTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/25.
//

#import "AreaSelectTableViewCell.h"

@implementation AreaSelectTableViewCell


+ (CGFloat)cellHeight
{
    return UIValue(44);
}

- (void)initSelf
{
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = FontR(14);
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.width = SCR_WIDTH / 3.0;
    self.textLabel.height = UIValue(44);

    self.selectionStyle = UITableViewCellSelectionStyleDefault;

}

- (void)fillData:(id)data
{
    self.textLabel.text = data[@"name"];
    [self.textLabel sizeToFit];
}

@end
