//
//  VideoPreviewVIew.h
//  Aisport
//
//  Created by Apple on 2020/11/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CT_CanclePlayVideoBlock)(void);
@interface VideoPreviewVIew : UIView

@property (nonatomic, strong) NSString *videoUrl;

@property (nonatomic, copy) CT_CanclePlayVideoBlock canclePlayVideoBlock;

@end

NS_ASSUME_NONNULL_END
