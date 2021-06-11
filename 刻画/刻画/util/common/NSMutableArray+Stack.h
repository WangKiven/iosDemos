//
//  NSMutableArray+Stack.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSMutableArray (Stack)

- (void) push:(id)object;
- (id) pop;
- (void) dropBottom;

@end
