//
//  Dot.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vertex.h"

@protocol MarkVisitor;

@interface Dot : Vertex
{
@private
    UIColor *color_;
    CGFloat size_;
}

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;

// for the Visitor pattern
- (void) acceptMarkVisitor:(id <MarkVisitor>)visitor;

// for the Prototype pattern
- (id) copyWithZone:(NSZone *)zone;

// for the Memento pattern
- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;

@end
