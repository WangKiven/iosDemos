//
//  UIImage+MyExtern.h
//  扩展
//
//  Created by apple on 14-1-21.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MyExtern)

/**功能：生成一张颜色color,尺寸size的图片
 *
 *
 */
+ (UIImage *) ImageWithColor:(UIColor *)color Rect:(CGSize) size;



/**功能：剪切一张尺寸size的image
 *
 *
 */
- (UIImage *) CliperWithRect:(CGRect) rect;

/**功能：剪切一张全屏图片
 *
 *
 */
- (UIImage *) cliperFullImage;

/**功能：获取改变尺寸为size的image
 *
 *注意：未测试
 */
- (UIImage *) ImageInSize:(CGSize) size;

/**功能：iOS程序中使用系统相机拍照和从相册选取图片，直接上传后在非mac系统下看到的图片会发生旋转的现象，那是因为我们没有通过图片的旋转属性修改图片倒置的。下面的方法可以很简单的解决旋转问题：
 *
 *注意：未测试
 */
- (UIImage *)fixOrientation;

/**功能：这里要分享的是将image旋转，而不是将imageView旋转，原理就是使用quartz2D来画图片，然后使用ctm变幻来实现旋转。
 注：quartz2D的绘图左边和oc里面的绘图左边不一样，导致绘画出的图片是反转的。所以一上来得使它转正再进行进一步的旋转等
 *
 *注意：未测试
 */
- (UIImage *) imageRotation:(UIImageOrientation) orientatiion;

/**功能：获取纯色图片
 *kCGBlendModeOverlay
 *kCGBlendModeDestinationIn
 */
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
