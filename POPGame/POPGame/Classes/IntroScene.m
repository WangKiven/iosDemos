//
//  IntroScene.m
//  POPGame
//
//  Created by Kiven Wang on 14-6-17.
//  Copyright Kiven Wang 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "FigureSceneManage.h"



// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"numberUI.plist"];
    
    // Create a colored background (Dark Grey)
//    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
//    [self addChild:background];
    
    CCSprite *background = [CCSprite spriteWithImageNamed:@"IntroScene_bg.png"];
//    background.anchorPoint = ccp(0.5, 0);
    background.position = ccp(winSize.width / 2, winSize.height / 2);
    [self addChild:background];

    
    // Hello world
//    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Chalkduster" fontSize:36.0f];
//    label.positionType = CCPositionTypeNormalized;
//    label.color = [CCColor redColor];
//    label.position = ccp(0.5f, 0.5f); // Middle of screen
//    [self addChild:label];
    
    // Helloworld scene button
//    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ 计时 ]" fontName:@"Verdana-Bold" fontSize:18.0f];
//    helloWorldButton.positionType = CCPositionTypeNormalized;
//    helloWorldButton.position = ccp(0.5f, 0.35f);
//    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
//    [self addChild:helloWorldButton];
    
    
    CCButton *helloWorldButton2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"IntroScene_startBtn.png"]];
    helloWorldButton2.positionType = CCPositionTypeNormalized;
    helloWorldButton2.position = ccp(0.5f, 0.5f);
    [helloWorldButton2 setTarget:self selector:@selector(onSpinningClicked2:)];
    [self addChild:helloWorldButton2];
    
//    CCButton *helloWorldButton3 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"xx.png"]];
//    helloWorldButton3.positionType = CCPositionTypeNormalized;
//    helloWorldButton3.position = ccp(0.5f, 0.15f);
//    [helloWorldButton3 setTarget:self selector:@selector(onSpinningClicked3:)];
//    [self addChild:helloWorldButton3];
    
    
    CCButton *settingBttton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"IntroScene_settingBtn.png"]];
    settingBttton.positionType = CCPositionTypeNormalized;
    settingBttton.position = ccp(0.9f, 0.15f);
    [settingBttton setTarget:self selector:@selector(onSettingClicked:)];
    [self addChild:settingBttton];
    
    
    FigureSceneManage *f = [FigureSceneManage shareFigureSceneManage];
    
    self.gameCenterManager= [[GameCenterManager alloc] init];
    [self.gameCenterManager setDelegate: f];
    f.gameCenterManager = self.gameCenterManager;
    if ([GameCenterManager isGameCenterAvailable]) {
        [_gameCenterManager authenticateLocalUser];
        
    }

    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    FigureSceneManage *f = [FigureSceneManage shareFigureSceneManage];
    f.mode = Figure_game_timer;
    
    
    [f showScene];
}

- (void)onSpinningClicked2:(id)sender
{
    FigureSceneManage *f = [FigureSceneManage shareFigureSceneManage];
    f.mode = Figure_game_forever;
    
    
    [f showScene];
}

- (void)onSpinningClicked3:(id)sender
{
    static int i = 1;
    
    //    [_gameCenterManager submitAchievement:@"com.suinapp.POPGame.EmigratedMode" percentComplete:5];
    [self.gameCenterManager reportScore: 6 forCategory: @"com.suinapp.POPGame.EmigratedMode"];
//    [_gameCenterManager resetAchievements];
    
    
//    [self.gameCenterManager reportScore: i forCategory: @"com.suinapp.POPGame.ScoreForEd"];
    
//    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
//	if (achievements != NULL)
//	{
//		achievements.achievementDelegate = self;
//		[self presentModalViewController: achievements animated: YES];
//        
//	}
    
    i++;
}

- (void) onSettingClicked:(CCButton *) sender
{
    SettingNode *alter = [[SettingNode alloc] init];
    alter.delegate = self;
    [alter showInScreen:self];
}
// -----------------------------------------------------------------------

#pragma mark - CCAlterNodeDelegate
- (void) alertNode:(CCAlterNode *)alterNode clickBtn:(CCButton *)btn
{
    
    
}
@end
