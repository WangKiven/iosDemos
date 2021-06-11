//
//  UIButton+DrawType.m
//  刻画
//
//  Created by Kiven Wang on 14-4-1.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "UIButton+DrawType.h"

@implementation UIButton (DrawType)
//- (void) didMoveToSuperview
//{
//    UIImage *image = [self currentImage];
//    
//    image = [image imageWithTintColor:[BackgroundData naviBarTextColor] blendMode:kCGBlendModeOverlay];
//    [self setImage:image forState:UIControlStateNormal];
//}

@end

static UIColor *buttonColor;

@implementation WButton
- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}
- (void) initData
{
    if (!buttonColor) {
        buttonColor = [UIColor blackColor];
    }
    
    
    
    sourceImage = [self imageForState:UIControlStateNormal];
    if (!sourceImage) {
        return ;
    }
    
    UIImage *image = [sourceImage imageWithTintColor:buttonColor];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setTitleColor:buttonColor forState:UIControlStateNormal];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImageColor) name:ChangeImageColor object:nil];
}
- (void) changeImageColor
{
    
    if (!sourceImage) {
        
        sourceImage = [self imageForState:UIControlStateNormal];
        if (!sourceImage) {
            return ;
        }
    }
    
    UIImage *image = [sourceImage imageWithTintColor:buttonColor];
    
    [self setImage:image forState:UIControlStateNormal];
    [self setTitleColor:buttonColor forState:UIControlStateNormal];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (void) SetButtonColor:(UIColor *)color
{
    buttonColor = color;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ChangeImageColor object:nil];
}

@end
