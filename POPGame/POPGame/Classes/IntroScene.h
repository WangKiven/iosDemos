//
//  IntroScene.h
//  POPGame
//
//  Created by Kiven Wang on 14-6-17.
//  Copyright Kiven Wang 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"

#import "GameCenterManager.h"
#import "SettingNode.h"
// -----------------------------------------------------------------------



/**
 *  The intro scene
 *  Note, that scenes should now be based on CCScene, and not CCLayer, as previous versions
 *  Main usage for CCLayer now, is to make colored backgrounds (rectangles)
 *
 */
@interface IntroScene : CCScene <CCAlterNodeDelegate>


@property (nonatomic, retain) GameCenterManager *gameCenterManager;

// -----------------------------------------------------------------------

+ (IntroScene *)scene;
- (id)init;

// -----------------------------------------------------------------------
@end