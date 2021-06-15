//
//  CCProcessBarNode.h
//  POPGame
//
//  Created by Kiven Wang on 14-7-9.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "cocos2d-ui.h"
#import "cocos2d.h"

@interface CCProcessBarNode : CCNode
{
    CCSprite *_back;
    CCProgressNode *_front;
}

@property (nonatomic) CGFloat percentage;

@end
