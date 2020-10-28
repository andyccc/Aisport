//
//  PlaceMobileView.h
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackPlaceMobileBlock)(void);
typedef void(^ClickPlaceOKlBlock)();
@interface PlaceMobileView : UIView

@property (nonatomic, copy) BackPlaceMobileBlock backPlaceMobileBlock;
@property (nonatomic, copy) ClickPlaceOKlBlock clickPlaceOKlBlock;

@end

NS_ASSUME_NONNULL_END
