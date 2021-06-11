//
//  UIView+SkipperImage.m
//  WhereTheDragon
//
//  Created by apple on 13-11-21.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "UIView+SkipperImage.h"

@implementation UIView (SkipperImage)



- (UIImage *) skipImage
{
    //支持retina高分的关键
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(self.frame.size);
    }
    
    //获取图像
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *) skipImageWithRect:(CGRect) rect
{
    
    
    //支持retina高分的关键
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(rect.size);
    }
    
    //获取图像
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

- (void) beginFadeAnimation
{
    //-----渐变显示、隐藏-----
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    [self.layer addAnimation:animation forKey:nil];
}

- (UIViewController *) getController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    
    return nil;
}

@end
