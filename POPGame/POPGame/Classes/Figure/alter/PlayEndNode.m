//
//  PlayEndNode.m
//  POPGame
//
//  Created by Kiven Wang on 14-7-11.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "PlayEndNode.h"

@implementation PlayEndNode
{
    CCLabelTTF *_scoreLabel;
}
- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    
    CGSize s = [CCDirector sharedDirector].designSize;
    
    
    CCSprite *bgSprite = [CCSprite spriteWithImageNamed:@"PlayEndNode_kuang.png"];
    bgSprite.position = ccp(s.width / 2, s.height / 2);
    [self addChild:bgSprite];
    
    CCSprite *scoreSprite = [CCSprite spriteWithImageNamed:@"FigureScene_score.png"];
    scoreSprite.anchorPoint = ccp(1, 0.5);
    scoreSprite.position = ccp(bgSprite.contentSize.width * 0.49, bgSprite.contentSize.height * 0.7);
    [bgSprite addChild:scoreSprite];
    
    _scoreLabel = [CCLabelTTF labelWithString:@"" fontName:@"ChalkboardSE-Bold" fontSize:25];
    _scoreLabel.fontColor = [CCColor colorWithRed:0.5 green:0.74 blue:0.37];
    _scoreLabel.anchorPoint = ccp(0, 0.5);
    _scoreLabel.position = ccp(bgSprite.contentSize.width * 0.51, bgSprite.contentSize.height * 0.71);
    [bgSprite addChild:_scoreLabel];
    
    
    CCButton *okBtn2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseNode_again.png"]];
    okBtn2.name = PlayEndNodeAgain;
    okBtn2.positionType = CCPositionTypeNormalized;
    okBtn2.position = ccp(0.5f, 0.5f);
    [okBtn2 setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:okBtn2];
    
    CCButton *okBtn1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseNode_backBtn.png"]];
    okBtn1.name = PlayEndNodeBack;
    okBtn1.positionType = CCPositionTypeNormalized;
    okBtn1.position = ccp(0.5f, 0.255f);
    [okBtn1 setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:okBtn1];
    
    
    
    // done
    return(self);
}


- (void) setScore:(int)score
{
    _score = score;
    
    _scoreLabel.string = [NSString stringWithFormat:@"%d", _score];
}

@end
