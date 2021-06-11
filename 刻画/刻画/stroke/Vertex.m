//
//  Vertex.m
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "Vertex.h"


@implementation Vertex
@synthesize location=location_;
@dynamic color, size;

- (id) initWithLocation:(CGPoint) aLocation
{
    if (self = [super init])
    {
        [self setLocation:aLocation];
    }
    
    return self;
}

// default properties do nothing
- (void) setColor:(UIColor *)color {}
- (UIColor *) color { return nil; }
- (void) setSize:(CGFloat)size {}
- (CGFloat) size { return 0.0; }

// Mark operations do nothing
- (void) addMark:(id <Mark>) mark {}
- (void) removeMark:(id <Mark>) mark {}
- (id <Mark>) childMarkAtIndex:(NSUInteger) index { return nil; }
- (id <Mark>) lastChild { return nil; }
- (NSUInteger) count { return 0; }
- (NSEnumerator *) enumerator { return nil; }


- (void) acceptMarkVisitor:(id <MarkVisitor>)visitor
{
    [visitor visitVertex:self];
}

#pragma mark -
#pragma mark NSCopying method

// it needs to be implemented for memento
- (id)copyWithZone:(NSZone *)zone
{
    Vertex *vertexCopy = [[[self class] allocWithZone:zone] initWithLocation:location_];
    
    return vertexCopy;
}


#pragma mark -
#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        location_ = [(NSValue *)[coder decodeObjectForKey:@"VertexLocation"] CGPointValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:[NSValue valueWithCGPoint:location_] forKey:@"VertexLocation"];
}

#pragma mark -
#pragma mark MarkIterator methods

// for internal iterator implementation
- (void) enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block {}

#pragma mark -
#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    
    CGContextAddLineToPoint(context, x, y);
}


#pragma mark -
#pragma mark 添加
- (id<Mark>) containPoint:(CGPoint) point
{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.location radius:self.size / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [path closePath];
    
    if ([path containsPoint:point]) {
        self.selected = !self.selected;
        
        return self;
    }
    
    
    
//    if (CGPointEqualToPoint(self.location, point)) {
//        return self;
//    }
    
    return nil;
}


- (void) moveAsPoint:(CGPoint) point
{
    CGPoint location = self.location;
    
    location.x += point.x;
    
    location.y += point.y;
    
    [self setLocation:location];
}

@end