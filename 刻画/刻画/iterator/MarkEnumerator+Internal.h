//
//  MarkEnumerator+Internal.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "MarkEnumerator.h"

@interface MarkEnumerator (Internal)
- (id) initWithMark:(id <Mark>)mark;
- (void) traverseAndBuildStackWithMark:(id <Mark>)mark;
@end
