//
//  Scribble.m
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "ScribbleMemento+Friend.h"
#import "Scribble.h"
#import "Stroke.h"

// A private category for Scribble
// that contains a mark property available
// only to its objects
@interface Scribble ()

@property (nonatomic, retain) id <Mark> mark;

@end


@implementation Scribble

@synthesize mark=parentMark_;

- (id) init
{
    if (self = [super init])
    {
        // the parent should be a composite
        // object (i.e. Stroke)
        parentMark_ = [[Stroke alloc] init];
    }
    
    return self;
}

#pragma mark -
#pragma mark Methods for Mark management

- (void) addMark:(id <Mark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark
{
    // manual KVO invocation
    [self willChangeValueForKey:@"mark"];
    
    // if the flag is set to YES
    // then add this aMark to the
    // *PREVIOUS*Mark as part of an
    // aggregate.
    // Based on our design, it's supposed
    // to be the last child of the main
    // parent
    if (shouldAddToPreviousMark)
    {
        [[parentMark_ lastChild] addMark:aMark];
    }
    // otherwise attach it to the parent
    else
    {
        [parentMark_ addMark:aMark];
        incrementalMark_ = aMark;
    }
    
    // manual KVO invocation
    [self didChangeValueForKey:@"mark"];
}

- (void) removeMark:(id <Mark>)aMark
{
    // do nothing if aMark is the parent
    if (aMark == parentMark_) return;
    
    // manual KVO invocation
    [self willChangeValueForKey:@"mark"];
    
    [parentMark_ removeMark:aMark];
    
    // we don't need to keep the
    // incrementalMark_ reference
    // as it's just removed in the parent
    if (aMark == incrementalMark_)
    {
        incrementalMark_ = nil;
    }
    
    // manual KVO invocation
    [self didChangeValueForKey:@"mark"];
}

//移除多个路径
- (void) removeMarks:(NSArray *) marks
{
    [self willChangeValueForKey:@"mark"];
    
    for (id<Mark> mark in marks) {
        [parentMark_ removeMark:mark];
    }
    
    [self didChangeValueForKey:@"mark"];
}

//添加多个路径
- (void) addMarks:(NSArray *) marks
{
    [self willChangeValueForKey:@"mark"];
    
    for (id<Mark> mark in marks) {
        [self addMark:mark shouldAddToPreviousMark:NO];
    }
    
    [self didChangeValueForKey:@"mark"];
}

//point是否在已有路径上
- (id<Mark>) containPoint:(CGPoint) point InMark:(id <Mark>)aMark
{
    id<Mark> tMark = [parentMark_ containPoint:point];
    if (tMark) {
        
        [self willChangeValueForKey:@"mark"];
        
        
        [self didChangeValueForKey:@"mark"];
    }
    
    return tMark;
}

//所有被选择的路径
- (NSArray *) allSelectedStroke
{
    return [parentMark_ allSelectedStroke];
}

//取消所有选中的路径
- (void) cancleAllSeleted
{
    [self willChangeValueForKey:@"mark"];
    
    [parentMark_ cancleAllSeleted];
    
    [self didChangeValueForKey:@"mark"];
}

//移动选择的线条
- (void) moveStroke:(NSArray *) marks withVertex:(id<Mark>) aVector shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark
{
    CGPoint vector = [aVector location];
    
    [self willChangeValueForKey:@"mark"];
    if (shouldAddToPreviousMark) {
        
        for (id<Mark> dot in marks) {
            [dot moveAsPoint:CGPointMake(vector.x - bVector.x, vector.y - bVector.y)];
        }
        
    }else{
        
        for (id<Mark> dot in marks) {
            [dot moveAsPoint:vector];
        }
        
    }
    
    bVector = vector;
    
    [self didChangeValueForKey:@"mark"];
}
- (void) cancleMoveStroke:(NSArray *) marks withVertex:(id<Mark>) aVector
{
    CGPoint vector = [aVector location];
    
    [self willChangeValueForKey:@"mark"];
    for (id<Mark> dot in marks) {
        [dot moveAsPoint:CGPointMake(-vector.x, -vector.y)];
    }
    
    [self didChangeValueForKey:@"mark"];
}

#pragma mark -
#pragma mark Methods for memento

- (id) initWithMemento:(ScribbleMemento*)aMemento
{
    if (self = [super init])
    {
        if ([aMemento hasCompleteSnapshot])
        {
            [self setMark:[aMemento mark]];
        }
        else
        {
            // if the memento contains only
            // incremental mark, then we need to
            // create a parent Stroke object to
            // hold it
            parentMark_ = [[Stroke alloc] init];
            [self attachStateFromMemento:aMemento];
        }
    }
    
    return self;
}


- (void) attachStateFromMemento:(ScribbleMemento *)memento
{
    // attach any mark from a memento object
    // to the main parent
    [self addMark:[memento mark] shouldAddToPreviousMark:NO];
}


- (ScribbleMemento *) scribbleMementoWithCompleteSnapshot:(BOOL)hasCompleteSnapshot
{
    id <Mark> mementoMark = incrementalMark_;
    
    // if the resulting memento asks
    // for a complete snapshot, then
    // set it with parentMark_
    if (hasCompleteSnapshot)
    {
        mementoMark = parentMark_;
    }
    // but if incrementalMark_
    // is nil then we can't do anything
    // but bail out
    else if (mementoMark == nil)
    {
        return nil;
    }
    
    ScribbleMemento *memento = [[ScribbleMemento alloc]
                                 initWithMark:mementoMark];
    [memento setHasCompleteSnapshot:hasCompleteSnapshot];
    
    return memento;
}


- (ScribbleMemento *) scribbleMemento
{
    return [self scribbleMementoWithCompleteSnapshot:YES];
}


+ (Scribble *) scribbleWithMemento:(ScribbleMemento *)aMemento
{
    Scribble *scribble = [[Scribble alloc] initWithMemento:aMemento];
    return scribble;
}



@end
