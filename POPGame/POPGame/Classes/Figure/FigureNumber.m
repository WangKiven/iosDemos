//
//  FigureNumber.m
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-15.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "FigureNumber.h"

@implementation FigureNumber


- (id) initWithInt:(int) value
{
    self = [super init];
    if (self) {
        self.value = value;
        self.type = FigureNumberNormal;
    }
    return self;
}

@end
