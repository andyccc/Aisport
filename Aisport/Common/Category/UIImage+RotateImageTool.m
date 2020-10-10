//
//  UIImage+RotateImageTool.m
//  Aisport
//
//  Created by Apple on 2020/11/23.
//

#import"UIImage+RotateImageTool.h"
#import<QuartzCore/QuartzCore.h>
#import<Accelerate/Accelerate.h>

@implementation UIImage (RotateImageTool)

- (UIImage*)rotateImageWithDegree:(CGFloat)degree
{
    //将image转化成context
    //获取图片像素的宽和高
    size_t width =self.size.width*self.scale;
    size_t height =self.size.height*self.scale;
    //颜色通道为8因为0-255经过了8个颜色通道的变化
    //每一行图片的字节数因为我们采用的是ARGB/RGBA所以字节数为width * 4
    size_t bytesPerRow =width *4;
    //图片的透明度通道
    CGImageAlphaInfo info =kCGImageAlphaPremultipliedFirst;
    //配置context的参数:
    CGContextRef context =CGBitmapContextCreate(nil, width, height,8, bytesPerRow,CGColorSpaceCreateDeviceRGB(),kCGBitmapByteOrderDefault|info);
    if(!context) {
    return nil;
    }
    //将图片渲染到图形上下文中
    CGContextDrawImage(context,CGRectMake(0,0, width, height),self.CGImage);
    uint8_t* data = (uint8_t*)CGBitmapContextGetData(context);
    //旋转欠的数据
    vImage_Buffer src = { data,height,width,bytesPerRow};
    //旋转后的数据
    vImage_Buffer dest= { data,height,width,bytesPerRow};
    //背景颜色
    Pixel_8888 backColor = {0,0,0,0};
    //填充颜色
    vImage_Flags flags = kvImageBackgroundColorFill;
    //旋转context
    vImageRotate_ARGB8888(&src, &dest,nil, degree *M_PI/180.f, backColor, flags);
    //将conetxt转换成image
    CGImageRef imageRef =CGBitmapContextCreateImage(context);
//    UIImage imageWithCGImage:<#(nonnull CGImageRef)#> scale:<#(CGFloat)#> orientation:<#(UIImageOrientation)#>
    UIImage* rotateImage =[UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    return rotateImage;
}
@end
