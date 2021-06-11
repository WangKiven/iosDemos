//
//  ThemeCell.m
//  刻画
//
//  Created by Kiven Wang on 14-3-18.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "ThemeCell.h"

@implementation ThemeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}

- (void) setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    selectedView.hidden = !selected;
    
}

@end
