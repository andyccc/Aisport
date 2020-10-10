//
//  VideoFinishView.h
//  Aisport
//
//  Created by Apple on 2020/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^CT_VideoFinishBlock)(void);
typedef void(^CT_VideoReStartPlayBlock)(void);
@interface VideoFinishView : UIView

@property (nonatomic, copy) CT_VideoFinishBlock videoFinishBlock;
@property (nonatomic, copy) CT_VideoReStartPlayBlock videoReStartPlayBlock;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *reslutID;

- (instancetype)initWithFrame:(CGRect)frame Url:(NSString *)urlStr IsReachability:(BOOL)isReachability;

@end

NS_ASSUME_NONNULL_END
