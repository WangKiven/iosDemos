//
//  FigureScene.m
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-11.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "FigureScene.h"
#import "FigureSprite.h"
#import "IntroScene.h"
#import "FigureNumber.h"

#import "CCProcessBarNode.h"

@interface FigureScene ()
{
    BOOL _isPausing;
}

@end

@implementation FigureScene
{
    NSMutableDictionary *_figureDic;
    
    CCNode *_background;
    
    CCLabelTTF *_infoLabel;
    CCLabelTTF *_qiaLabel;
    
    CCSlider *_slider;
    
    CCProcessBarNode *_processBar;
}

@synthesize score = _score;

+ (instancetype) scene
{
    return [[[self class] alloc] init];
}
- (instancetype) init
{
    self = [super init];
    if (!self) {
        return  nil;
    }
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"number.plist"];
    
    //背景
    _background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.3 green:0.3 blue:0.3]];
    [self addChild:_background];
//    _background = [CCSprite spriteWithImageNamed:@"FigureScene_bg.png"];
//    _background.anchorPoint = ccp(0, 0);
//    [self addChild:_background];
    
    
    //初始字典
    _figureDic = [NSMutableDictionary dictionaryWithCapacity:10];
    for (int i = 8; i > 0; i--) {
        
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
        [_figureDic setObject:array forKey:[NSNumber numberWithInt:i]];
        
        for (int j = 0; j < 3; j++) {
            FigureSprite *fs = [FigureSprite figureSpriteWithNum:i];
            fs.state = FigureSprite_Hide;
            fs.visible = NO;
            [self addChild:fs];
            [array addObject:fs];
        }
    }
    
    
    CCButton *backButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"FigureScene_PauseBtn.png"]];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.92f, 0.1f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    CCSprite *qiaSprite = [CCSprite spriteWithImageNamed:@"FigureScene_qia.png"];
    qiaSprite.anchorPoint = ccp(0.5, 1);
    qiaSprite.position = ccp(35, winSize.height - 5);
    [self addChild:qiaSprite];
    
    
    _qiaLabel = [CCLabelTTF labelWithString:@"" fontName:@"ChalkboardSE-Bold" fontSize:25];
    _qiaLabel.fontColor = [CCColor colorWithRed:0.5 green:0.74 blue:0.37];
    _qiaLabel.anchorPoint = ccp(0.5, 1);
    _qiaLabel.position = ccp(35, winSize.height - 25);
    [self addChild:_qiaLabel];
    
    
    CCSprite *scoreSprite = [CCSprite spriteWithImageNamed:@"FigureScene_score.png"];
    scoreSprite.anchorPoint = ccp(0.5, 1);
    scoreSprite.position = ccp(winSize.width - 35, winSize.height - 5);
    [self addChild:scoreSprite];
    
    
    
    
    _infoLabel = [CCLabelTTF labelWithString:@"" fontName:@"ChalkboardSE-Bold" fontSize:25];
    _infoLabel.fontColor = [CCColor colorWithRed:0.5 green:0.74 blue:0.37];
    _infoLabel.anchorPoint = ccp(0.5, 1);
    _infoLabel.position = ccp(winSize.width - 35, winSize.height - 25);
    [self addChild:_infoLabel];
    
    
    
    _processBar = [[CCProcessBarNode alloc] init];
    _processBar.position = ccp(70 + _processBar.contentSize.width / 2, winSize.height - 5 - _processBar.contentSize.height / 2);
    _processBar.percentage = 30;
    [self addChild:_processBar];
    
    
    [[CCDirector sharedDirector] addObserver:self forKeyPath:@"isPaused" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:nil];
    
    _isPausing = YES;
    
    return self;
}

- (void) onEnter
{
    [super onEnter];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"resetLevel" object:nil];
    _isPausing = NO;
    
    [self showInfo];
}
- (void) onExit
{
    [super onExit];
    _isPausing = YES;
}

- (void) showInfo
{
    _processBar.percentage = _second;
    _infoLabel.string = [NSString stringWithFormat:@"%d", _score];
}

- (void) setQia:(int)qia
{
    _qia = qia;
    
    _qiaLabel.string = [NSString stringWithFormat:@"%d", _qia];
}

#pragma mark - 显示数字
- (void) showFigureWithNumber:(int) number two:(int) two three:(int) three
{
    
    NSMutableArray *normalNums = [NSMutableArray arrayWithCapacity:number];
    for ( int i = number; i > 0; i--) {
        FigureNumber *aNumber = [[FigureNumber alloc] initWithInt:i];
        [normalNums addObject:aNumber];
    }
    
    for ( ; two > 0; two--) {
        [self addFigureType:normalNums Type:FigureNumberTwo];
    }

    for ( ; three > 0; three--) {
        [self addFigureType:normalNums Type:FigureNumberThree];
    }
    
    
    for ( int i = number; i > 0; i--) {
        FigureNumber *aNumber = [normalNums objectAtIndex:i - 1];
        
        int n;
        if (aNumber.type == FigureNumberNormal) {
            n = 1;
        }else if(aNumber.type == FigureNumberTwo){
            n = 2;
        }else{
            n = 3;
        }
        
        int randomColor = 1 + (arc4random() % 5);
        CCColor *color = [CCColor colorWithRed:(randomColor & 1) green:(randomColor >> 1 & 1) blue:(randomColor >> 2 & 1) alpha:0.1];
//        CCColor *color = [CCColor colorWithRed:(arc4random()%256) / 255.0 green:(arc4random()%256) / 255.0 blue:(arc4random()%256) / 255.0];
        for ( ; n > 0; n--) {
            FigureSprite *fs = [self getAvailableFigureSprite:i];
            fs.position = [self getAvilablePosition];
            fs.color = color;
            [fs show];
        }
    }
}

- (void) addFigureType:(NSArray *) nums Type:(FigureNumberType) type
{
    int i = arc4random() % nums.count;
    BOOL b = NO;
    do {
        FigureNumber *number = [nums objectAtIndex:i];
        if (number.type == FigureNumberNormal) {
            number.type = type;
            b = NO;
        }else{
            i = (i + 1) % nums.count;
            b = YES;
        }
    } while (b);
}

- (FigureSprite *) getAvailableFigureSprite:(int) number
{
    FigureSprite *fs ;
    NSMutableArray *numArray = [_figureDic objectForKey:[NSNumber numberWithInt:number]];
    for (FigureSprite *figureSprite in numArray) {
        if (figureSprite.state == FigureSprite_Hide) {
            fs.visible = YES;
            fs = figureSprite;
            break ;
        }
    }
    
    if (!fs) {
        fs = [FigureSprite figureSpriteWithNum:number];
        
        [self addChild:fs];
        [numArray addObject:fs];
    }
    
    [fs stopAllActions];
    
    return fs;
}
- (CGPoint) getAvilablePosition
{
    CGSize winSize = [CCDirector sharedDirector].viewSize;
    CGPoint point = ccp(arc4random()%(int)(winSize.width - 60) + 30, arc4random()%(int)(winSize.height * 0.8 - 60) + 30);
    
    if (sqrt((point.x - winSize.width + 40)*(point.x - winSize.width + 40) + (point.y - 40)* (point.y - 40)) < 60 ) {
        return [self getAvilablePosition];
    }
    
    BOOL inFs = NO;
    for (NSNumber *number in _figureDic) {
        for (FigureSprite *fs in [_figureDic objectForKey:number]) {
            if (fs.state != FigureSprite_Hide) {
                int length = sqrt((point.x - fs.position.x)*(point.x - fs.position.x) + (point.y - fs.position.y)* (point.y - fs.position.y));
                if (length < 50) {
                    inFs = YES;
                    break ;
                }
            }
        }
        if (inFs) {
            break ;
        }
    }
    if (inFs) {
        return [self getAvilablePosition];
    }else{
        return point;
    }
}
- (void) hideAllFigures
{
    for (NSNumber *number in _figureDic) {
        for (FigureSprite *fs in [_figureDic objectForKey:number]) {
            if (fs.state != FigureSprite_Hide) {
                fs.state = FigureSprite_Hide;
                [FigureSprite_Boom boomWithFigureSprite:fs];
//                [fs hide];
            }
        }
    }
}
#pragma mark - touch
- (void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [self convertToNodeSpace:touch.locationInWorld];
    
    for (NSNumber *number in _figureDic) {
        for (FigureSprite *fs in [_figureDic objectForKey:number]) {
            if (fs.state != FigureSprite_Hide) {
                if ([fs hitTestWithWorldPos:point]) {
                    [fs pressing];
                }
            }
        }
    }
    
}

- (void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint point = [self convertToNodeSpace:touch.locationInWorld];
    
    NSNumber *pressedNumber;
    BOOL isOrder = YES;//是否按序消除
    for (int i = 1 ; i < 9  ;i ++) {
        
        NSNumber *number = [NSNumber numberWithInt:i];
        BOOL hasVisible = NO;
        for (FigureSprite *fs in [_figureDic objectForKey:number]) {
            if (fs.state == FigureSprite_Pressing) {
                if ([fs hitTestWithWorldPos:point]) {
                    pressedNumber = number;
                    break ;
                }
            }else if(fs.state != FigureSprite_Hide){
                hasVisible = YES;
            }
        }
        if (pressedNumber) {
            break ;
        }else if(hasVisible){
            isOrder = NO;
        }
    }
    
    
    if (pressedNumber) {
        BOOL allPressed = YES;
        for (FigureSprite *fs in [_figureDic objectForKey:pressedNumber]) {
            if (fs.state != FigureSprite_Hide && fs.state != FigureSprite_Pressing) {
                allPressed = NO;
                break ;
            }
        }
        if (allPressed) {
            
            int pressNum = 0;
            for (FigureSprite *fs in [_figureDic objectForKey:pressedNumber]) {
                if (fs.state == FigureSprite_Pressing) {
                    pressNum ++ ;
                    
                    fs.state = FigureSprite_Hide;
                    [FigureSprite_Boom boomWithFigureSprite:fs];
                }
            }
            float ff = (isOrder ? 1.0f : 0.5f);
            switch (pressNum) {
                case 1:
                    self.score += 10 * ff;
                    break;
                case 2:
                    self.score += 20 * ff;
                    break;
                case 3:
                    self.score += 40 * ff;
                    break;
                    
                default:
                    break;
            }
            NSLog(@"%d", self.score);
            if (!isOrder) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NOOrder" object:nil];
            }
            [self showInfo];
            
            //是否还有数字
            BOOL hasFigure = NO;
            for (NSNumber *number in _figureDic) {
                for (FigureSprite *fs in [_figureDic objectForKey:number]) {
                    if (fs.state != FigureSprite_Hide) {
                        hasFigure = YES;
                        break ;
                    }
                }
                if (hasFigure) {
                    break;
                }
            }
            if (!hasFigure) {
                //......关卡完成
                if (!self.figureSceneDelegate.isPasing) {
                    [self.figureSceneDelegate gamePause:nil];
                    [FigureSprite_Boom boomBlock:^{
                        [self.figureSceneDelegate nextLevel:nil];
                        [self.figureSceneDelegate gameStart:nil];
                    }];
                }
                
            }
        }else{
            for (FigureSprite *fs in [_figureDic objectForKey:pressedNumber]) {
                if (fs.state != FigureSprite_Hide) {
                    [fs upsping];
                }
            }
            
            
            for (NSNumber *number in _figureDic) {
                for (FigureSprite *fs in [_figureDic objectForKey:number]) {
                    if (fs.state == FigureSprite_Pressing) {
                        [fs upsping];
                        
                    }
                }
            }
        }
    }
    
    
}

#pragma mark - 退出
- (void)onBackClicked:(id)sender
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"gamePause" object:nil];
    [self.figureSceneDelegate gamePause:nil];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"继续游戏" otherButtonTitles:@"回主菜单", @"重新开始", nil];
//    alert.tag = 111;
//    [alert show];
    _isPausing = YES;
    PauseNode *alter = [[PauseNode alloc] init];
    alter.delegate = self;
    [alter showInScreen:self];
}

- (void) gameOver
{
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"游戏结束。得%d分", _score] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//    
//    alert.tag = 222;
//    
//    [alert show];
    _isPausing = YES;
    PlayEndNode *alter = [[PlayEndNode alloc] init];
    alter.score = self.score;
    alter.delegate = self;
    alter.name = @"PlayEndNode";
    [alter showInScreen:self];
}
#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            if (alertView.tag == 111) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"gameStart" object:nil];
            }else{
                [self hideAllFigures];
                
                [FigureSprite_Boom boomBlock:^{
                    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
                    _score = 0;
                }];
            }
        }
            break;
        case 1:
        {
            [self gameOver];
        }
            break;
        case 2:
        {
            [self hideAllFigures];
            [FigureSprite_Boom boomBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"resetLevel" object:nil];
                _score = 0;
            }];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - CCAlterNodeDelegate
- (void) alertNode:(CCAlterNode *)alterNode clickBtn:(CCButton *)btn
{
    _isPausing = NO;
    if ([btn.name isEqualToString:CCAlterNodeBack]) {
        if ([alterNode.name isEqualToString:@"PlayEndNode"]) {
            [self hideAllFigures];
            
            [FigureSprite_Boom boomBlock:^{
                [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                                           withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
                _score = 0;
            }];
        }else{
            [self gameOver];
        }
    }else if([btn.name isEqualToString:CCAlterNodeContinue]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gameStart" object:nil];
    }else{
        [self hideAllFigures];
        [FigureSprite_Boom boomBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"resetLevel" object:nil];
            _score = 0;
        }];
    }
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isPaused"]) {
        NSNumber *bNum = [change objectForKey:NSKeyValueChangeNewKey];
        
        if (bNum.boolValue && self.visible && !_isPausing) {
            [self onBackClicked:nil];
        }
    }
}
@end
