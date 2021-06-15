//
//  Figure_game_data.m
//  cocos2d-iPhone-test2
//
//  Created by Kiven Wang on 14-6-17.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "Figure_game_data.h"

@implementation Figure_game_data

- (id) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"score"]) {
//        NSNumber *num = [change objectForKey:NSKeyValueChangeNewKey];
//        int score = num.intValue;
        //......分数处理
        self.score = [change objectForKey:NSKeyValueChangeNewKey];
        [self update:NO];
    }
}

- (void) resetData
{
    _ID = [NSNumber numberWithInt:[self newID]];
    _score = [NSNumber numberWithInt:0];
//    _mode = nil;
    _time = @"";
    _endLevel = [NSNumber numberWithInt:0];
    _clearNum = [NSNumber numberWithInt:0];
    
    [self insert:NO];
}

- (int) newID
{
    FMDatabase *dataBase = [[self class] dataBase];
    [dataBase open];
    
    NSString *sql = [NSString stringWithFormat:@"select max(ID) as maxID from %@", NSStringFromClass([self class])];
    FMResultSet *set = [dataBase executeQuery:sql];
    
    int count = 1;
    while ([set next]) {
        
        NSNumber* value = [set objectForColumnName:@"maxID"];
        if ((NSNull *)value != [NSNull null]) {
            count = value.intValue;
        }
        
    }
    
    [dataBase close];
    return count + 1;
}

@end
