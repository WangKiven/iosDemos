//
//  FigureSprite.m
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-11.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "FigureSprite.h"

@implementation FigureSprite
{
    int _number;
    
//    SystemSoundID _bulletsndID;//声音
    
    
    CCParticleSystem *_particle;//粒子系统
}


+ (instancetype) figureSpriteWithNum:(int) number
{
    
    return [[self alloc] figureSpriteWithNum:number];
}

- (id) figureSpriteWithNum:(int) number
{
    
    id ret = [self initWithSpriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"%d_1.png",number]]];
    if (ret) {
        _number = number;
        _state = FigureSprite_Normal;
        _particle = [CCParticleSystem particleWithFile:@"particle_boom.plist"];
        _particle.position = CGPointMake(self.textureRect.size.width / 2, self.textureRect.size.height / 2);
//        _particle.duration = -1;
        [self addChild:_particle];
        
        
//        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"number" withExtension:@"mp3"];
//        AudioServicesCreateSystemSoundID((__bridge CFURLRef) fileURL, &_bulletsndID);
        
        
        
        
        NSLog(@"%@",NSStringFromCGSize(self.textureRect.size));
    }
    return  ret;
}

- (void) show
{
    _state = FigureSprite_Normal;
    
    self.visible = YES;
    self.scale = 1;
    self.opacity = 1;
}
- (void) hide
{
    _state = FigureSprite_Hide;
    
    CCActionScaleTo *scaleAction = [CCActionScaleTo actionWithDuration:0.2 scale:1.2];
    CCActionFadeOut *hideAction = [CCActionFadeOut actionWithDuration:0.2];
    CCActionCallBlock *callAction = [CCActionCallBlock actionWithBlock:^{
        self.visible = NO;
    }];
    
    CCActionSpawn *apawn = [CCActionSpawn actions:scaleAction, hideAction, nil];
    CCActionSequence *sequence = [CCActionSequence actions:apawn, callAction, nil];
    
    [self stopAllActions];
    [self runAction:sequence];

    
    [_particle resetSystem];
    
//    if (isPlayEffect) {
//        [[OALSimpleAudio sharedInstance] playEffect:@"number.mp3"];
//    }
    
}
- (void) pressing
{
    _state = FigureSprite_Pressing;
    
    [self runShakeAction];
}
- (void) upsping
{
    _state = FigureSprite_Upsping;
    
    [self runShakeAction];
}

- (void) runShakeAction
{
    CCActionScaleTo *scaleAction1 = [CCActionScaleTo actionWithDuration:0.1 scale:0.9];
    CCActionScaleTo *scaleAction2 = [CCActionScaleTo actionWithDuration:0.1 scale:1];
    CCActionSequence *action = [CCActionSequence actions:scaleAction1, scaleAction2, nil];
    
    CCActionRepeat *repeat = [CCActionRepeat actionWithAction:action times:2];
    
    [self runAction:repeat];
}

#pragma mark - touch

- (BOOL) hitTestWithWorldPos:(CGPoint)pos
{
    
    CGRect rrect = CGRectMake(self.position.x - 25, self.position.y - 25, 50, 50);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rrect];
    
    if ([path containsPoint:pos]) {
        return YES;
    }
    return NO;
}

@end

@implementation FigureSprite_Boom
{
    NSMutableArray *_sprites;
    
    BOOL _isPausing;
}

- (id) init
{
    self = [super init];
    if (self) {
        _sprites = [NSMutableArray arrayWithCapacity:10];
        _isPausing = NO;
    }
    return self;
}

+ (id) shareFigureSprite_Boom
{
    static id ret = nil;
    if (!ret) {
        ret = [[[self class] alloc] init];
    }
    return ret;
}

+ (void) boomWithFigureSprite:(FigureSprite *) figureSprite
{
    FigureSprite_Boom *ret = [[self class] shareFigureSprite_Boom];
    [ret boomWithFigureSprite:figureSprite];
}

- (void) boomWithFigureSprite:(FigureSprite *) figureSprite
{
    if (![_sprites containsObject:figureSprite]) {
        [_sprites addObject:figureSprite];
        [self boomBegin];
    }
}

- (void) boomBegin
{
    if (!_isPausing) {
        _isPausing = YES;
        
        FigureSprite *figureSprite = [_sprites firstObject];
        [figureSprite hide];
        [self performSelector:@selector(boomEnd) withObject:nil afterDelay:0.3];
    }
}

- (void) boomEnd
{
    [_sprites removeObjectAtIndex:0];
    _isPausing = NO;
    if (_sprites.count > 0) {
        [self boomBegin];
    }else{
        if (self.block) {
            self.block();
            self.block = nil;
        }
    }
}


+ (void) boomBlock:(FigureSprite_Boom_block) block
{
    FigureSprite_Boom *ret = [[self class] shareFigureSprite_Boom];
    ret.block = block;
}

@end
