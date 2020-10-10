//
//  ThreeSlideTableViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/26.
//

#import "ThreeSlideTableViewCell.h"
#import "VideoCoverView2.h"


@implementation ThreeSlideTableViewCell
{
    NSMutableArray *btns;
}

+ (CGFloat)cellHeight
{
    return UIValue(122 + 20 + 10);
}

- (void)initSelf
{
    btns = [NSMutableArray array];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.width = SCR_WIDTH;
    self.scrollView.height = UIValue(122 + 20);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
 
//
}

- (void)fillData:(id)data
{
    NSArray *list = data[@"data"];
    self.tapBlock = data[@"block"];
    [self setDataList:list];
}

- (void)setDataList:(NSArray *)list
{
    NSInteger count = [list count];
    CGFloat width = UIValue(122);
    CGFloat height = UIValue(122 + 20);
    CGFloat left = UIValue(16);
    
    for (int i = 0; i < count; i++) {
        VideoCoverView2 *btn = [self getBtnByIndex:i];
        if (!btn) {
            btn = [[VideoCoverView2 alloc] initWithFrame:CGRectMake(0, 0, width, height)];
            [btn layout];
            [btns addObject:btn];
            [self.scrollView addSubview:btn];
            [btn.tapBtn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        btn.tapBtn.tag = i;
        
        btn.left = left;
        
        left = btn.right + UIValue(13);
        
        
        id data = list[i];
        
        [self setViewData:data view:btn];
        
    }
    
    self.scrollView.contentSize = CGSizeMake(left + UIValue(3), self.scrollView.height);
}

- (void)setViewData:(id)data view:(VideoCoverView2 *)view
{
    NSString *cover = data[@"cover"];
    NSString *name = data[@"name"];
    NSNumber *lever = data[@"lever"];
    
    [view setLev:[lever intValue]];
    
    view.titleLabel.text = name;
    
    [view.coverView sd_setImageWithURL:[NSURL URLWithString:StringForId(cover)] placeholderImage:nil];

}

- (VideoCoverView2 *)getBtnByIndex:(int)index
{
    if ([btns count] > index) {
        return [btns objectAtIndex:index];
    }
    return nil;
}


- (void)tapAction:(UIButton *)btn
{
    !self.tapBlock ?: self.tapBlock(btn.tag);
}




@end
