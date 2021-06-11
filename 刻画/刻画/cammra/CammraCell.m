//
//  CammraCell.m
//  刻画
//
//  Created by Kiven Wang on 14-3-24.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "CammraCell.h"

@implementation CammraCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self beginFadeAnimation];
    selectedView.hidden = !selected;
    
}

@end
