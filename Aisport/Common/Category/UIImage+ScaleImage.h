//
//  UIImage+ScaleImage.h
//  Snail
//
//  Created by 田桔 on 2019/8/13.
//  Copyright © 2019 田桔. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ScaleImage)

+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;


+ (NSData *)lubanCompressImage:(UIImage *)image;
+ (NSData *)lubanCompressImage:(UIImage *)image withMask:(NSString *)maskName;
+ (NSData *)lubanCompressImage:(UIImage *)image withCustomImage:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
