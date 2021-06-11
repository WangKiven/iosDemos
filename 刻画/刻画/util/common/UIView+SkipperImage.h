//
//  UIView+SkipperImage.h
//  WhereTheDragon
//
//  Created by apple on 13-11-21.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SkipperImage)
/*功能：将view内容转化为图片
 *
 *
 */
- (UIImage *) skipImage;

/*功能：将view内容指定区域rect转化为图片
 *
 *
 */
- (UIImage *) skipImageWithRect:(CGRect) rect;

/**功能：添加渐变动画，手动调用
 *
 *
 */
- (void) beginFadeAnimation;

/**功能：获取所在的controller
 *
 *
 */
- (UIViewController *) getController;

@end
