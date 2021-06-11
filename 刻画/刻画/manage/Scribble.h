//
//  Scribble.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"
#import "ScribbleMemento.h"

@interface Scribble : NSObject
{
@private
    id <Mark> parentMark_;
    id <Mark> incrementalMark_;
    
    CGPoint bVector;//记录一次移动的向量
}

// methods for Mark management
- (void) addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void) removeMark:(id <Mark>)aMark;



//移除多个路径
- (void) removeMarks:(NSArray *) marks;

//添加多个路径
- (void) addMarks:(NSArray *) marks;

//point是否在已有路径上
- (id<Mark>) containPoint:(CGPoint) point InMark:(id <Mark>)aMark;

//所有被选择的路径
- (NSArray *) allSelectedStroke;

//取消所有选中的路径
- (void) cancleAllSeleted;


//移动选择的线条
- (void) moveStroke:(NSArray *) marks withVertex:(id<Mark>) aVector shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void) cancleMoveStroke:(NSArray *) marks withVertex:(id<Mark>) aVector;

// methods for memento
- (id) initWithMemento:(ScribbleMemento *)aMemento;
+ (Scribble *) scribbleWithMemento:(ScribbleMemento *)aMemento;
- (ScribbleMemento *) scribbleMemento;
- (ScribbleMemento *) scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot;
- (void) attachStateFromMemento:(ScribbleMemento *)memento;

@end
