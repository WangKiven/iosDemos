//
//  FigureScene.h
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-11.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "cocos2d-ui.h"
#import "cocos2d.h"

#import "PauseNode.h"
#import "PlayEndNode.h"

@protocol FigureSceneDelegate <NSObject>

@property (nonatomic) BOOL isPasing;

- (void) gamePause:(NSNotification *) notification;

- (void) gameStart:(NSNotification *) notification;


- (void) nextLevel:(NSNotification *) notification;

@end

@interface FigureScene : CCScene<UIAlertViewDelegate, CCAlterNodeDelegate>
{
    
}

@property (nonatomic) id<FigureSceneDelegate> figureSceneDelegate;

@property (nonatomic) int qia;
@property (nonatomic) int score;
@property (nonatomic) float second;

//@property (nonatomic, strong) FigureSceneManage *manage;

+ (instancetype) scene;

- (void) showFigureWithNumber:(int) number two:(int) two three:(int) three;

- (void) gameOver;

- (void) showInfo;

@end
