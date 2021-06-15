//
//  Figure_game_data.h
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-17.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBObject.h"

@interface Figure_game_data : DBObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, strong) NSNumber *second;
@property (nonatomic, strong) NSNumber *mode;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSNumber *endLevel;
@property (nonatomic, strong) NSNumber *clearNum;

- (void) resetData;

@end
