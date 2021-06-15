//
//  FigureSceneManage.h
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-16.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GameCenterManager.h"
#import "FigureScene.h"

typedef NS_ENUM(NSInteger, Figure_game_mode) {
    Figure_game_timer,//计时
    Figure_game_forever//无限
};


@interface FigureSceneManage : NSObject<GameCenterManagerDelegate, FigureSceneDelegate>


@property (nonatomic, retain) GameCenterManager *gameCenterManager;

@property (nonatomic) Figure_game_mode mode;

+ (id) shareFigureSceneManage;

- (void) showScene;

@end
