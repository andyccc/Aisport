//
//  CodeTextField.m
//  Aisport
//
//  Created by Apple on 2020/10/30.
//

#import "CodeTextField.h"

@implementation CodeTextField

- (void)deleteBackward
{
    [super deleteBackward];
    if (_keyInputDelegate && [_keyInputDelegate respondsToSelector:@selector(deleteBackward)]) {
        [_keyInputDelegate deleteBackward];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
