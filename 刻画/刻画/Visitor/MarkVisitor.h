//
//  MarkVisitor.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol Mark;
@class Dot, Vertex, Stroke;

@protocol MarkVisitor <NSObject>

- (void) visitMark:(id <Mark>)mark;
- (void) visitDot:(Dot *)dot;
- (void) visitVertex:(Vertex *)vertex;
- (void) visitStroke:(Stroke *)stroke;


- (void) visitStrokeCircle:(Stroke *) stroke withStart:(CGPoint) startPoint WithEnd:(CGPoint) endPoint;
- (void) visitStrokeRect:(Stroke *) stroke WithStart:(CGPoint) startPoint WithEnd:(CGPoint) endPoint;
- (void) visitStrokeText:(Stroke *) stroke WithStart:(CGPoint) start WithText:(NSString *) text;

@end
