//
//  UIMessageBox.h
//  Passenger
//
//  Created by apple on 12-10-31.
//  Copyright (c) 2012年 MagicZhang. All rights reserved.
//

#import <Foundation/Foundation.h>


static  NSInteger const kBlackTransParentViewTag    = 269;
static  NSInteger const kActivityIndicatorTag       = 270;
static  NSInteger const kCustomAlViewTag            = 271;
static  NSInteger const kMessageBoxTag              = 272;

int     _animeTime;
UIView  *_tempView;


@interface UIMessageBox : NSObject

//显示提示消息

//显示居中，高度为150，宽度为50的消息框
+ (void)showMessageBoxInView:(UIView *)view withText:(NSString *)text;
//可自定义消息框的frame，如果view中有正在显示的消息框，则新的消息框不会显示。
+ (void)showMessageBoxInView:(UIView *)view withFrame:(CGRect)frame andText:(NSString *)text;
//调用次方法2秒以后remove掉以显示的消息框
+ (void)hideMessageBoxInView:(UIView *)view;
+ (void)hideMessageBoxInViewImmediate:(UIView *) view;


//用alertview的形式显示等待窗口
+ (void)alertActivityIndicator:(NSString*)title;
+ (void)dismissActivityIndicator;


//用直接显示的方式显示等待窗口
+ (void)showActivityIndicatorInView:(UIView*)view;
+ (void)hideActivityIndicatorInView:(UIView*)view;


//用背景的方式显示等待窗口
+ (void)showBlackTransparentActivityIndicatorInView:(UIView*)view withTitle:(NSString *)title;
+ (void)hideBlackTransparentActivityIndicatorInView:(UIView*)view;


//用自定义文字的方式显示等待窗口
//显示一个居中的100*100的消息框，可以自定义文字和图片
+ (void)showCustomAlViewInView:(UIView *)view withImage:(UIImage *)image andTitle:(NSString *)title;
+ (void)hideCustomAlViewInView:(UIView *)view;

@end


