//
//  GuideTVView.h
//  Aisport
//
//  Created by Apple on 2020/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BackGuideTVBlock)(void);
typedef void(^NextGuideTVBlock)(void);
@interface GuideTVView : UIView

@property (nonatomic, copy) BackGuideTVBlock backGuideTVBlock;
@property (nonatomic, copy) NextGuideTVBlock nextGuideTVBlock;

@end

NS_ASSUME_NONNULL_END
