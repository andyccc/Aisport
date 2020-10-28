//
//  CGSizeExtension.h
//  sport
//
//  Created by YANS on 2020/10/18.
//

#ifndef CGSizeExtension_h
#define CGSizeExtension_h



static inline CGAffineTransform CGSizeTransformKeepAspect(CGSize src, CGSize dest)
{
  /// Returns `CGAfineTransform` to resize `self` to fit in destination size, keeping aspect ratio
  /// of `self`. `self` image is resized to be inscribe to destination size and located in center of
  /// destination.
  ///
  /// - Parameter toFitIn: destination size to be filled.
  /// - Returns: `CGAffineTransform` to transform `self` image to `dest` image.
    CGFloat sourceRatio = src.height / src.width;
    CGFloat destRatio = dest.height / dest.width;

    // Calculates ratio `self` to `dest`.
    CGFloat ratio;
    CGFloat x = 0;
    CGFloat y = 0;
    if (sourceRatio > destRatio) {
      // Source size is taller than destination. Resized to fit in destination height, and find
      // horizontal starting point to be centered.
        ratio = dest.height / src.height;
        x = (dest.width - src.width * ratio) / 2;
    } else {
        ratio = dest.width / src.width;
        y = (dest.height - src.height * ratio) / 2;
    }

    return CGAffineTransformMake(ratio, 0, 0, ratio, x, y);
  }







#endif /* CGSizeExtension_h */
