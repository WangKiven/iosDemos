//
//  UIMessageBox.m
//  Passenger
//
//  Created by apple on 12-10-31.
//  Copyright (c) 2012年 MagicZhang. All rights reserved.
//

#import "UIMessageBox.h"
#import <QuartzCore/QuartzCore.h>


#define ANIME_TIME 1.0
#define ANIME_DELAY_TIME 1.0


@implementation UIMessageBox


+ (void)showMessageBoxInView:(UIView *)view withText:(NSString *)text
{
    [UIMessageBox showMessageBoxInView:view withFrame:CGRectMake((view.frame.size.width - 150) / 2, (view.frame.size.height - 50) / 2, 150, 50) andText:text];
    
}


+ (void)showMessageBoxInView:(UIView *)view withFrame:(CGRect)frame andText:(NSString *)text
{
    UIView *v = [view viewWithTag:kMessageBoxTag];
    if (!v)
    {
        UIView *messageView             = [[UIView alloc] initWithFrame:frame];
        messageView.clipsToBounds       = YES;
        messageView.backgroundColor     = [UIColor clearColor];
        messageView.tag                 = kMessageBoxTag;
        messageView.layer.cornerRadius  = 6.0f;
        
        UIImageView *bgImageView        = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        bgImageView.backgroundColor     = [UIColor blackColor];
        bgImageView.alpha               = 0.5f;
        [messageView addSubview:bgImageView];
        
        UILabel *textLable              = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
        [textLable setFont:[UIFont fontWithName:@"DFPShaoNvW5" size:16]];
        textLable.backgroundColor       = [UIColor clearColor];
//        textLable.font                  = [UIFont boldSystemFontOfSize:15];
        textLable.textColor             = [UIColor whiteColor];
        textLable.textAlignment         = NSTextAlignmentCenter;
        textLable.numberOfLines         = 0;
        textLable.text                  = text;
        [messageView addSubview:textLable];
        
        
        [view addSubview:messageView];
        [view bringSubviewToFront:messageView];
    }
}

+ (void)hideMessageBoxInView:(UIView *)view
{
    UIView *messageView = [view viewWithTag:kMessageBoxTag];
    if (messageView)
    {
        [UIView animateWithDuration:ANIME_TIME
                              delay:ANIME_DELAY_TIME
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             messageView.alpha   = 0.0f;
                         }
                         completion:^(BOOL finished){
                             [messageView removeFromSuperview];
                         }
         ];
    }
}


+ (void)hideMessageBoxInViewImmediate:(UIView *) view
{
    UIView *messageView = [view viewWithTag:kMessageBoxTag];
    if (messageView)
    {
        [messageView.layer removeAllAnimations];
        [messageView removeFromSuperview];
        
        sleep(0.2);
    }
}

UIAlertView *alert = nil;
+ (void)alertActivityIndicator:(NSString*)title
{
	if (nil == alert)
    {
		alert = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
		[alert show];
		
		UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		//Adjust the indicator so it is up a few pixels from the bottom of the alert
		indicator.center = CGPointMake(alert.bounds.size.width/2, alert.bounds.size.height - 50);
		[indicator startAnimating];
		[alert addSubview:indicator];
	}
}


+ (void)dismissActivityIndicator
{
	[alert dismissWithClickedButtonIndex:0 animated:NO];
}



+ (void)showActivityIndicatorInView:(UIView*)view
{
	UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	CGRect frame = activityIndicator.frame;
	frame.origin = view.center;
	activityIndicator.frame = frame;
	activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	activityIndicator.tag = kActivityIndicatorTag;
	
	[view addSubview:activityIndicator];
  	[activityIndicator startAnimating];
}


+ (void)hideActivityIndicatorInView:(UIView*)view
{
	UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[view viewWithTag:kActivityIndicatorTag];
	if (activityIndicator != nil) {
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
	}
}



+ (void)showBlackTransparentActivityIndicatorInView:(UIView*)view withTitle:(NSString *)title
{
    UIView *v = [view viewWithTag:kBlackTransParentViewTag];
    if (!v)
    {
        //CGRect parentRect = view.bounds;
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(view.center.x - 50, view.center.y - 50, 100, 100)];
        UIColor *bgColor = [[UIColor alloc] initWithWhite:0.2 alpha:0.5];
        blackView.backgroundColor = bgColor;
        blackView.tag = kBlackTransParentViewTag;
        blackView.layer.cornerRadius = 6.0;
        
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGRect indicatorFrame = activityIndicator.frame;
        activityIndicator.tag = kActivityIndicatorTag;
        activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [blackView addSubview:activityIndicator];
        indicatorFrame.origin = CGPointMake(blackView.frame.size.width/2 - indicatorFrame.size.width/2,
                                            blackView.frame.size.height/2 - indicatorFrame.size.height/2 - 10);
        activityIndicator.frame = indicatorFrame;
        [activityIndicator startAnimating];
        
        
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, blackView.frame.size.height - 30, blackView.frame.size.width, 20)];
        [lable setFont:[UIFont fontWithName:@"DFPShaoNvW5" size:16]];
        lable.text  = title;
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor whiteColor];
        [blackView addSubview:lable];
        
        
        [view addSubview:blackView];
        [view bringSubviewToFront:blackView];
    }
}

+ (void)hideBlackTransparentActivityIndicatorInView:(UIView*)view
{
	UIView *blackView = [view viewWithTag:kBlackTransParentViewTag];
	if (blackView != nil) {
		UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[blackView viewWithTag:kActivityIndicatorTag];
		if (activityIndicator != nil) {
			[activityIndicator stopAnimating];
			[activityIndicator removeFromSuperview];
		}
		[blackView removeFromSuperview];
	}
}



#pragma mark -
#pragma mark custom alview

+ (void)showCustomAlViewInView:(UIView *)view withImage:(UIImage *)image andTitle:(NSString *)title
{
    _animeTime  = 0;
    
    UIView *alView                  = [[UIView alloc] initWithFrame:CGRectMake((view.frame.size.width - 100) / 2, (view.frame.size.height - 100) / 2, 100, 100)];
    [alView setBackgroundColor:[UIColor clearColor]];
    alView.tag                      = kCustomAlViewTag;
    CALayer *lay                    = alView.layer;
    lay.masksToBounds               = YES;
    lay.cornerRadius                = 6.0f;
    [view addSubview:alView];
    
    UIImageView *colorImageView     = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    colorImageView.alpha            = 0.5f;
    colorImageView.backgroundColor  = [UIColor blackColor];
    [alView addSubview:colorImageView];
    
    UIImageView *iconImageView      = [[UIImageView alloc] initWithImage:image];
    iconImageView.frame             = CGRectMake(0, 0, 100, 80);
    iconImageView.contentMode       = UIViewContentModeCenter;
    [alView addSubview:iconImageView];
    
    UILabel *alLable                = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 100, 20)];
    [alLable setFont:[UIFont fontWithName:@"DFPShaoNvW5" size:16]];
    alLable.text                    = title;
    alLable.backgroundColor         = [UIColor clearColor];
    alLable.textColor               = [UIColor whiteColor];
    alLable.textAlignment           = NSTextAlignmentCenter;
//    alLable.font                    = [UIFont systemFontOfSize:12];
    [alView addSubview:alLable];
}

+ (void)hideCustomAlViewInView:(UIView *)view
{
    UIView *customAlView = [view viewWithTag:kCustomAlViewTag];
    if (customAlView != nil) {
        [customAlView removeFromSuperview];
    }
}

@end
