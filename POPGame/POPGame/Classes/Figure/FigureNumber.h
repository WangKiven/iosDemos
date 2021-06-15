//
//  FigureNumber.h
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-15.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FigureNumberType) {
    FigureNumberNormal,
    FigureNumberTwo,
    FigureNumberThree
};

@interface FigureNumber : NSObject

@property (nonatomic) int value;

@property (nonatomic) FigureNumberType type;

- (id) initWithInt:(int) value;

@end
