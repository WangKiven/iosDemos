//
//  CCAlterNode.m
//  POPGame
//
//  Created by Kiven Wang on 14-7-9.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "CCAlterNode.h"

@implementation CCAlterNode

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    CGSize s = [CCDirector sharedDirector].designSize;
    _anchorPoint = ccp(0.0f, 0.0f);
    [self setContentSize:s];
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3]];
    [self addChild:background];
    
    // done
    return(self);
}

- (void) showInScreen:(CCScene *) scene
{
    if (scene) {
        _scene = scene;
    }
    [scene addChild:self];
}

- (void) clickBtn:(CCButton *) btn
{
    
    if ( self.delegate && [self.delegate respondsToSelector:@selector(alertNode:clickBtn:)]) {
        [self.delegate alertNode:self clickBtn:btn];
    }
    
    [self removeFromParent];
}
@end
