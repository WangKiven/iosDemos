//
//  ScribbleMemento+Friend.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import"ScribbleMemento.h"

@interface ScribbleMemento ()

- (id) initWithMark:(id <Mark>)aMark;

@property (nonatomic, copy) id <Mark> mark;
@property (nonatomic, assign) BOOL hasCompleteSnapshot;

@end
