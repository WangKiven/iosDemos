//
//  PlayEndNode.h
//  POPGame
//
//  Created by Kiven Wang on 14-7-11.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "CCAlterNode.h"


#define PlayEndNodeAgain @"CCAlterNodeAgain"
#define PlayEndNodeBack @"CCAlterNodeBack"
@interface PlayEndNode : CCAlterNode

@property (nonatomic) int score;

@end
