//
//  VariableView.m
//  刻画
//
//  Created by Kiven Wang on 14-3-24.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "VariableView.h"

@implementation VariableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
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
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    _visiScale = 0.5;
    
    
    _visiCenter = CGPointMake(getScreenSize().width / 2, getScreenSize().height / 2);
}

- (void) setVisiScale:(CGFloat)visiScale
{
    _visiScale *= visiScale;
    
    
    
    
    if (_visiScale < 0.3) {
        _visiScale = 0.3;
    }else if(_visiScale > 1){
        _visiScale = 1;
    }
    
    [self adjustFrame];
    [self setNeedsDisplay];
}

- (void) setVisiCenter:(CGPoint)visiCenter
{
    
    _visiCenter = visiCenter;
    
    [self adjustFrame];
    [self setNeedsDisplay];
}

- (void) adjustFrame
{
    
    CGFloat with;
    CGFloat height;
    
    
    CGSize selfSize = getScreenSize();
    
    with = selfSize.width * self.visiScale;
    height = selfSize.height * self.visiScale;
    
    
    CGRect frame = CGRectMake(_visiCenter.x - with / 2, _visiCenter.y - height / 2, with, height);
    
    if (frame.origin.x < 0) {
        _visiCenter.x = with / 2;
    }else if (frame.origin.x + with > selfSize.width){
        _visiCenter.x = selfSize.width - with / 2;
    }
    
    if (frame.origin.y < 0) {
        _visiCenter.y = height / 2;
    }else if (frame.origin.y + height > selfSize.height){
        _visiCenter.y = selfSize.height - height / 2;
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    UIView *view = self.superview;
    
    if (view) {
        
        CGFloat with;
        CGFloat height;
        
        
        CGSize selfSize = getScreenSize();
        
        with = selfSize.width * self.visiScale;
        height = selfSize.height * self.visiScale;
        
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(_visiCenter.x - with / 2, _visiCenter.y - height / 2, with, height)];
        
        [path fillWithBlendMode:kCGBlendModeClear alpha:1];
        
        [[UIColor blueColor] setStroke];
        path.lineWidth = 1.0;
        
        [path stroke];
    }
    
    
    
}


@end
