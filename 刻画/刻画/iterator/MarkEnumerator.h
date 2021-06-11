//
//  MarkEnumerator.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+Stack.h"
#import "Mark.h"

@interface MarkEnumerator : NSEnumerator
{
@private
    NSMutableArray *stack_;
}

- (NSArray *)allObjects;
- (id)nextObject;

@end
