//
//  VariableThumbView.m
//  刻画
//
//  Created by Kiven Wang on 14-3-31.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "VariableThumbView.h"

@implementation VariableThumbView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    UIImage *image = [UIImage imageNamed:@"thumb"];
    
    [image drawInRect:rect];
}


- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self beginFadeAnimation];
    selectedView.hidden = !selected;
    
}
@end
