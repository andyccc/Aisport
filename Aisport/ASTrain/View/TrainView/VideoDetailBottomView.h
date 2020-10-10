//
//  VideoDetailBottomView.h
//  Aisport
//
//  Created by 申公安 on 2020/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailBottomView : UIView

@property (nonatomic, copy) void(^collectionVideoBlock)(void);
@property (nonatomic, copy) void(^danceActionBlock)(void);

@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIButton *danceBtn;
- (void)fillData:(BOOL)isCollection;

@end

NS_ASSUME_NONNULL_END
