//
//  PauseNode.m
//  POPGame
//
//  Created by Kiven Wang on 14-7-10.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "PauseNode.h"

@implementation PauseNode
- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    
    
    CGSize s = [CCDirector sharedDirector].designSize;
    
    
    CCSprite *bgSprite = [CCSprite spriteWithImageNamed:@"PauseNode_kuang.png"];
    bgSprite.position = ccp(s.width / 2, s.height / 2);
    [self addChild:bgSprite];
    
    CCButton *okBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseNode_contineBtn.png"]];
    okBtn.name = CCAlterNodeContinue;
    okBtn.positionType = CCPositionTypeNormalized;
    okBtn.position = ccp(0.5f, 0.745f);
    [okBtn setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:okBtn];
    
    CCButton *okBtn2 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseNode_again.png"]];
    okBtn2.name = CCAlterNodeAgain;
    okBtn2.positionType = CCPositionTypeNormalized;
    okBtn2.position = ccp(0.5f, 0.5f);
    [okBtn2 setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:okBtn2];
    
    CCButton *okBtn1 = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"PauseNode_backBtn.png"]];
    okBtn1.name = CCAlterNodeBack;
    okBtn1.positionType = CCPositionTypeNormalized;
    okBtn1.position = ccp(0.5f, 0.255f);
    [okBtn1 setTarget:self selector:@selector(clickBtn:)];
    [bgSprite addChild:okBtn1];
    
    
    
    // done
    return(self);
}
@end
