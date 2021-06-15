//
//  FigureSceneManage.m
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-16.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "FigureSceneManage.h"
#import "cocos2d-ui.h"
#import "cocos2d.h"
#import "Figure_game_data.h"

#import "Header.h"

@implementation FigureSceneManage
{
    FigureScene *_scene;
    
    int _curLevel;
    
    Figure_game_data *_gameData;
    
    NSTimer *_timer;
    float _second;
    float _levelTime;
    float _levelTolTime;
    BOOL _isPasing;
}

- (id) init
{
    self = [super init];
    if (self) {
        _gameData = [[Figure_game_data alloc] init];
        [_gameData creatTable:NO];
        
        _scene = [FigureScene scene];
        _scene.figureSceneDelegate = self;
        [_scene addObserver:_gameData forKeyPath:@"score" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
        
        _isPasing = YES;
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerRepeats:) userInfo:nil repeats:YES];
        [_timer fire];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextLevel:) name:@"nextLevel" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetLevel:) name:@"resetLevel" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gamePause:) name:@"gamePause" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameStart:) name:@"gameStart" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noOrder:) name:@"NOOrder" object:nil];
        
        [[OALSimpleAudio sharedInstance] preloadEffect:@"number.mp3"];
//        isPlayEffect = ![[NSUserDefaults standardUserDefaults] boolForKey:NSUserDefaults_Effect];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:NSUserDefaults_Music]) {
            [[OALSimpleAudio sharedInstance] playBg:@"bg.mp3" loop:YES];
        }
        
    }
    return self;
}

+ (id) shareFigureSceneManage
{
    static id ret;
    if (!ret) {
        ret = [[[self class] alloc] init];
    }
    return ret;
}

- (void) setMode:(Figure_game_mode)mode
{
    _mode = mode;
    _curLevel = 0;
    _scene.qia = _curLevel;
    _gameData.mode = [NSNumber numberWithInt:mode];
}

- (BOOL) isPasing
{
    return _isPasing;
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) showScene
{
    
    
    [[CCDirector sharedDirector] replaceScene:_scene withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:0.5f]];
}



//- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    if ([keyPath isEqualToString:@"score"]) {
//        NSNumber *num = [change objectForKey:NSKeyValueChangeNewKey];
//        int score = num.intValue;
//        //......分数处理
//        NSLog(@"score:%d", score);
//    }
//}

#pragma mark - NSNotification
- (void) nextLevel:(NSNotification *) notification
{
//    [self performSelector:@selector(nextLevelShow) withObject:nil afterDelay:0.5];
    [self nextLevelShow];
}

- (void) resetLevel:(NSNotification *) notification
{
    _curLevel = 0;
    _scene.qia = _curLevel;
    
    [self nextLevelShow];
}


- (void) nextLevelShow
{
    if (_curLevel == 0) {
        [_gameData resetData];
        
        _second = 0;
        _isPasing = NO;
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRepeats:) userInfo:nil repeats:YES];
//        [_timer fire];
    }
    _curLevel ++;
    _scene.qia = _curLevel;
    
    _gameData.endLevel = [NSNumber numberWithInt:_curLevel];
    //...根据模式计算当前关卡数据并显示游戏界面
    int number = 5 , two = 2, three = 1;
    
    _levelTolTime = 10.0;
    _levelTime = 0;
    switch (_mode) {
        case Figure_game_timer:
        {
            number = arc4random() % 5 + 4;
            two = arc4random() % 3;
            three = arc4random() % 3;
            
        }
            break;
        case Figure_game_forever:
        {
            if (_curLevel < 6) {
                number = arc4random() % 3 + 2;
                two = arc4random() % 2;
                three = 0;
                
            }else if(_curLevel < 11){
                number = arc4random() % 4 + 3;
                two = arc4random() % 3;
                three = 0;
                
            }else if(_curLevel < 21){
                number = arc4random() % 4 + 4;
                two = arc4random() % 3;
                three = arc4random() % 2;
                
            }else if(_curLevel < 31){
                number = arc4random() % 4 + 4;
                two = arc4random() % 4;
                if (number - two == 1) {
                    three = 1;
                }else{
                    three = arc4random() % 2 + 1;
                }
                
            }else{
                number = arc4random() % 4 + 5;
                two = arc4random() % 4 + 1;
                if (number - two == 1) {
                    three = 1;
                }else if(number - two < 3){
                    three = arc4random() % (number - two + 1) + 1;
                }else{
                    three = arc4random() % 3 + 1;
                }
                
            }
        }
            break;
            
        default:
            break;
    }
    
    
    
    [_scene showFigureWithNumber:number two:two three:three];
    //---------------------------
    _gameData.endLevel = [NSNumber numberWithInt:_curLevel];
}
- (void) timerRepeats:(NSTimer *) theTimer
{
    if (_isPasing) {
        return ;
    }
    _second += 0.1 ;
    _levelTime += 0.1;
    _gameData.second = [NSNumber numberWithInt:_second];
    switch (_mode) {
        case Figure_game_timer:
        {
            _scene.second = 80 - _second;
            
            if (_second >= 80) {
                _isPasing = YES;
                [_scene gameOver];
            }
        }
            break;
        case Figure_game_forever:
        {
            float per = _levelTime / _levelTolTime;
            _scene.second = per > 1.0 ? 100 : per*100.0;
            if (_levelTime >= _levelTolTime) {
                _isPasing = YES;
                [_scene gameOver];
            }
        }
            break;
            
        default:
            break;
    }
    [_scene showInfo];
}
- (void) gamePause:(NSNotification *) notification
{
    _isPasing = YES;
    
    Figure_game_data *aData = [[Figure_game_data alloc] init];
    for (Figure_game_data *data in [aData select:NO]) {
        NSLog(@"%@, %@ , %@ , %@, %@", data.ID, data.score, data.second, data.endLevel, data.mode);
    }
}
- (void) gameStart:(NSNotification *) notification
{
    _isPasing = NO;
}

- (void) noOrder:(NSNotification *) notification
{
    switch (_mode) {
        case Figure_game_timer:
        {
            
        }
            break;
        case Figure_game_forever:
        {
            _isPasing = YES;
            [_scene gameOver];
        }
            break;
            
        default:
            break;
    }
}




- (void) processGameCenterAuth: (NSError*) error
{
	if(error == NULL)
	{
		[self.gameCenterManager reloadHighScoresForCategory: @"com.appledts.EasyTapList"];
	}
	else
	{
		UIAlertView* alert= [[UIAlertView alloc] initWithTitle: @"Game Center Account Required"
                                                       message: [NSString stringWithFormat: @"Reason: %@", [error localizedDescription]]
                                                      delegate: self cancelButtonTitle: @"Try Again..." otherButtonTitles: NULL];
		[alert show];
	}
	
}


- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error;
{
	if((error == NULL) && (ach != NULL))
	{
		if(ach.percentComplete == 100.0)
		{
            
		}
		else
		{
			if(ach.percentComplete > 0)
			{
                
			}
		}
	}
	else
	{
        
	}
}
- (void) reloadScoresComplete: (GKLeaderboard*) leaderBoard error: (NSError*) error;
{
	if(error == NULL)
	{
		int64_t personalBest= leaderBoard.localPlayerScore.value;
		NSLog(@"%lld", personalBest);
	}
	else
	{
		
	}
    
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}
@end
