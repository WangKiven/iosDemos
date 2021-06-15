//
//  CCAlterNode.h
//  POPGame
//
//  Created by Kiven Wang on 14-7-9.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "cocos2d-ui.h"
#import "cocos2d.h"

@class CCAlterNode;
@protocol CCAlterNodeDelegate <NSObject>

- (void) alertNode:(CCAlterNode *) alterNode clickBtn:(CCButton *) btn;

@end

@interface CCAlterNode : CCControl
{
    CCScene *_scene;
}

@property (nonatomic, strong) id<CCAlterNodeDelegate> delegate;

- (void) showInScreen:(CCScene *) scene;

@end
