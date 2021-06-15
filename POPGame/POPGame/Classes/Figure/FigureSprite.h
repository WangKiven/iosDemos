//
//  FigureSprite.h
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-11.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "cocos2d-ui.h"
#import "cocos2d.h"

//#define FigureSprite_Zero @""
//#define FigureSprite_One @""
//#define FigureSprite_Two @""
//#define FigureSprite_Three @""
//#define FigureSprite_Four @""
//#define FigureSprite_Five @""
//#define FigureSprite_Six @""
//#define FigureSprite_Seven @""
//#define FigureSprite_Eight @""
//#define FigureSprite_Nine @""

typedef NS_ENUM(NSInteger, FigureSpriteState) {
    FigureSprite_Normal,
    FigureSprite_Pressing,
    FigureSprite_Upsping,
    FigureSprite_Hide
};

@interface FigureSprite : CCSprite

@property (nonatomic) FigureSpriteState state;

+ (instancetype) figureSpriteWithNum:(int) number;
- (id) figureSpriteWithNum:(int) number;

- (void) show;
- (void) hide;
- (void) pressing;
- (void) upsping;

- (void) runShakeAction;
@end



typedef void(^FigureSprite_Boom_block)();

@interface FigureSprite_Boom : NSObject

+ (id) shareFigureSprite_Boom;

+ (void) boomWithFigureSprite:(FigureSprite *) figureSprite;

+ (void) boomBlock:(FigureSprite_Boom_block) block;

@property (nonatomic, strong) FigureSprite_Boom_block block;

@end
