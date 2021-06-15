//
//  CCProcessBarNode.m
//  POPGame
//
//  Created by Kiven Wang on 14-7-9.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "CCProcessBarNode.h"

@implementation CCProcessBarNode

- (instancetype) init
{
    
    self = [super init];
    if (!self) return(nil);
    
    _back = [CCSprite spriteWithImageNamed:@"processBar_timebg.png"];
    [self addChild:_back];
    self.contentSize = _back.contentSize;
    
    CCSprite *frontSprite = [CCSprite spriteWithImageNamed:@"processBar_time.png"];
    _front = [CCProgressNode progressWithSprite:frontSprite];
    _front.type = CCProgressNodeTypeBar;
    _front.midpoint = ccp(0, 0.5);
    _front.barChangeRate = ccp(1, 0);
    _front.reverseDirection = YES;
    [self addChild:_front];
    
    
    // done
    return(self);
}

- (void) setPercentage:(CGFloat)percentage
{
    _front.percentage = 100 - percentage;
}
- (CGFloat) percentage
{
    return 100.0 - _front.percentage;
}
@end
