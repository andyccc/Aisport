//
//  BaseCollectionViewCell.m
//  Aisport
//
//  Created by andyccc on 2020/12/24.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

+ (id)dequeueReusableCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:self.reuseIdentifier forIndexPath:indexPath];
}

+ (CGSize)sizeForItemCell
{
    return CGSizeMake(UIValue(70), UIValue(95));
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self.class);
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        [self initSelf];
 
    }
    return self;
}

- (void)initSelf
{
    
}

- (void)fillData:(id)data
{
    
}


@end
