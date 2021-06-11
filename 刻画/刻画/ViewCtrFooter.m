//
//  ViewCtrFooter.m
//  刻画
//
//  Created by Kiven Wang on 14-3-26.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "ViewCtrFooter.h"

@implementation ViewCtrFooter

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction) clickButton:(id)sender
{
    if (_footerBlock) {
        _footerBlock();
    }
}

@end
