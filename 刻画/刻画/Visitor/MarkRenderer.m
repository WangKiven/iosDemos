//
//  MarkRenderer.m
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "MarkRenderer.h"
#import <CoreText/CoreText.h>


@implementation MarkRenderer

- (id) initWithCGContext:(CGContextRef)context
{
    if (self = [super init])
    {
        context_ = context;
        shouldMoveContextToDot_ = YES;
    }
    
    return self;
}

- (void) visitMark:(id <Mark>)mark
{
    // default behavior
}

- (void) visitDot:(Dot *)dot
{
    CGFloat x = [dot location].x;
    CGFloat y = [dot location].y;
    CGFloat frameSize = [dot size];
    CGRect frame = CGRectMake(x - frameSize / 2.0,
                              y - frameSize / 2.0,
                              frameSize,
                              frameSize);
    
    if (dot.selected) {
        
        CGContextSetFillColorWithColor (context_,[[[dot color] colorWithAlphaComponent:0.5] CGColor]);
    }else{
        
        CGContextSetFillColorWithColor (context_,[[dot color] CGColor]);
    }
    
    CGContextFillEllipseInRect(context_, frame);
    
    
}

- (void) visitVertex:(Vertex *)vertex
{
    CGFloat x = [vertex location].x;
    CGFloat y = [vertex location].y;
    
    if (shouldMoveContextToDot_)
    {
        CGContextMoveToPoint(context_, x, y);
        shouldMoveContextToDot_ = NO;
    }
    else
    {
        CGContextAddLineToPoint(context_, x, y);
    }
}

- (void) visitStroke:(Stroke *)stroke
{
    if (stroke.selected) {
        
        CGContextSetStrokeColorWithColor (context_,[[[stroke color] colorWithAlphaComponent:0.5] CGColor]);
    }else{
        
        CGContextSetStrokeColorWithColor (context_,[[stroke color] CGColor]);
    }
    CGContextSetLineWidth(context_, [stroke size]);
    CGContextSetLineCap(context_, kCGLineCapRound);
    CGContextSetLineJoin(context_, kCGLineJoinRound);
    
    
    CGContextStrokePath(context_);
    shouldMoveContextToDot_ = YES;
}


- (void) visitStrokeCircle:(Stroke *) stroke withStart:(CGPoint) startPoint WithEnd:(CGPoint) endPoint
{
    [[UIColor clearColor] setFill];
    if (stroke.selected) {
        
        CGContextSetStrokeColorWithColor (context_,[[[stroke color] colorWithAlphaComponent:0.5] CGColor]);
    }else{
        
        CGContextSetStrokeColorWithColor (context_,[[stroke color] CGColor]);
    }
    
    
    CGRect rrect = CGRectMake(startPoint.x,startPoint.y,endPoint.x - startPoint.x,endPoint.y - startPoint.y);
    
//    if (abs(rrect.size.width) < 20) {
//        rrect.size.width = rrect.size.width > 0 ? 20 : -20;
//    }
//    
//    if (abs(rrect.size.height) < 20) {
//        rrect.size.height = rrect.size.height > 0 ? 20 : -20;
//    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rrect];
    
    path.lineWidth = stroke.size;
    
    [path stroke];
}

- (void) visitStrokeRect:(Stroke *)stroke WithStart:(CGPoint)startPoint WithEnd:(CGPoint)endPoint{
    
    CGContextSetFillColorWithColor(context_, [[UIColor clearColor] CGColor]);
    
    if (stroke.selected) {
        
        CGContextSetStrokeColorWithColor (context_,[[[stroke color] colorWithAlphaComponent:0.5] CGColor]);
    }else{
        
        CGContextSetStrokeColorWithColor (context_,[[stroke color] CGColor]);
    }
    
    
    
    CGContextSetLineWidth(context_, [stroke size]);
    
    CGRect rrect = CGRectMake(startPoint.x,startPoint.y,endPoint.x - startPoint.x,endPoint.y - startPoint.y);
    if (abs(rrect.size.width) < 20) {
        rrect.size.width = rrect.size.width > 0 ? 20 : -20;
    }
    
    if (abs(rrect.size.height) < 20) {
        rrect.size.height = rrect.size.height > 0 ? 20 : -20;
    }
    
    CGFloat radius = 10.0;
    
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect);
	CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect);
    
    // Start at 1
	CGContextMoveToPoint(context_, minx, midy);
	// Add an arc through 2 to 3
	CGContextAddArcToPoint(context_, minx, miny, midx, miny, radius);
	// Add an arc through 4 to 5
	CGContextAddArcToPoint(context_, maxx, miny, maxx, midy, radius);
	// Add an arc through 6 to 7
	CGContextAddArcToPoint(context_, maxx, maxy, midx, maxy, radius);
	// Add an arc through 8 to 9
	CGContextAddArcToPoint(context_, minx, maxy, minx, midy, radius);
	// Close the path
	CGContextClosePath(context_);
	// Fill & stroke the path
    
    
	CGContextDrawPath(context_, kCGPathFillStroke);
    
}

- (void) visitStrokeText:(Stroke *)stroke WithStart:(CGPoint)start WithText:(NSString *)text
{
    
    
    if (stroke.selected) {
        
        CGContextSetFillColorWithColor (context_,[[[stroke color] colorWithAlphaComponent:0.5] CGColor]);
    }else{
        
        CGContextSetFillColorWithColor (context_,[[stroke color] CGColor]);
    }
    CGContextSetStrokeColorWithColor(context_, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context_, 1);
    
    CGContextSetTextDrawingMode(context_, kCGTextFillStroke);
    
    NSArray *texts = [text componentsSeparatedByString:@"\n"];
    
    CGPoint newPoint = start;
    for (NSString *subText in texts) {
        [subText drawAtPoint:newPoint withFont:[UIFont boldSystemFontOfSize:stroke.size * 5]];
        
        newPoint = CGPointMake(newPoint.x, newPoint.y + stroke.size * 5 + 5);
    }
    
}

@end
