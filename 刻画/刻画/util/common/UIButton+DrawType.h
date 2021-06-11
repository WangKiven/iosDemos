//
//  UIButton+DrawType.h
//  刻画
//
//  Created by Kiven Wang on 14-4-1.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (DrawType)

//- (void) setImage:(UIImage *)image;

@end


@interface WButton : UIButton
{
    UIImage *sourceImage;
}

+ (void) SetButtonColor:(UIColor *) color;

@end