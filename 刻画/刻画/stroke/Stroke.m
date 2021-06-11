//
//  Stroke.m
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "Stroke.h"
#import "MarkEnumerator+Internal.h"

@implementation Stroke

@synthesize color=color_, size=size_;
@dynamic location;

- (id) init
{
    if (self = [super init])
    {
        children_ = [[NSMutableArray alloc] initWithCapacity:5];
    }
    
    return self;
}

- (void) setLocation:(CGPoint)aPoint
{
    // it doesn't set any arbitrary location
}

- (CGPoint) location
{
    // return the location of the first child
    if ([children_ count] > 0)
    {
        //    return [[children_ objectAtIndex:0] location];
        NSLog(@"%s",__FUNCTION__);
    }
    
    // otherwise returns the origin
    return CGPointZero;
}

- (void) addMark:(id <Mark>) mark
{
    [children_ addObject:mark];
}

- (void) removeMark:(id <Mark>) mark
{
    // if mark is at this level then
    // remove it and return
    // otherwise, let every child
    // search for it
    if ([children_ containsObject:mark])
    {
        [children_ removeObject:mark];
    }
    else
    {
        [children_ makeObjectsPerformSelector:@selector(removeMark:)
                                   withObject:mark];
    }
}


- (id <Mark>) childMarkAtIndex:(NSUInteger) index
{
    if (index >= [children_ count]) return nil;
    
    return [children_ objectAtIndex:index];
}


// a convenience method to return the last child
- (id <Mark>) lastChild
{
    return [children_ lastObject];
}

// returns number of children
- (NSUInteger) count
{
    return [children_ count];
}


- (void) acceptMarkVisitor:(id <MarkVisitor>)visitor
{
    
    
    
    switch (_strokeType) {
        case StrokeTypeNone:
        {
            for (id <Mark> dot in children_)
            {
                [dot acceptMarkVisitor:visitor];
                
            }
        }
            break;
        case StrokeTypeLine:
        {
            for (id <Mark> dot in children_)
            {
                [dot acceptMarkVisitor:visitor];
                
//                NSLog(@"%@",NSStringFromCGPoint([dot location]));
                
//                NSLog(@"%@",NSStringFromClass([dot class]));
            }
            
            [visitor visitStroke:self];
        }
            break;
            
        case StrokeTypeCircle:
        {
            if (children_.count > 1) {
                id <Mark> dot = [children_ firstObject];
                
                CGPoint start = [dot location];
                
                dot = [children_ lastObject];
                
                CGPoint end = [dot location];
                
                [visitor visitStrokeCircle:self withStart:start WithEnd:end];
            }
        }
            break;
        case StrokeTypeRound:
        {
            if (children_.count > 1) {
                id <Mark> dot = [children_ firstObject];
                
                CGPoint start = [dot location];
                
                dot = [children_ lastObject];
                
                CGPoint end = [dot location];
                
                [visitor visitStrokeRect:self WithStart:start WithEnd:end];
            }
        }
            break;
        case StrokeTypeWord:
        {
            if (children_.count > 0) {
                
                id <Mark> dot = [children_ firstObject];
                if ([self text]) {
                    [visitor visitStrokeText:self WithStart:[dot location] WithText:[self text]];
                    
                }
            }
        }
            break;
            
        default:
            break;
    }
    
    
}


#pragma mark -
#pragma mark NSCopying method


- (id)copyWithZone:(NSZone *)zone
{
    Stroke *strokeCopy = [[[self class] allocWithZone:zone] init];
    
    // copy the color
    [strokeCopy setColor:[UIColor colorWithCGColor:[color_ CGColor]]];
    
    // copy the size
    [strokeCopy setSize:size_];
    
    // copy the children
    for (id <Mark> child in children_)
    {
        id <Mark> childCopy = [child copy];
        [strokeCopy addMark:childCopy];
    }
    
    return strokeCopy;
}

#pragma mark -
#pragma mark NSCoder methods

- (id)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        color_ = [coder decodeObjectForKey:@"StrokeColor"];
        size_ = [coder decodeFloatForKey:@"StrokeSize"];
        children_ = [coder decodeObjectForKey:@"StrokeChildren"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:color_ forKey:@"StrokeColor"];
    [coder encodeFloat:size_ forKey:@"StrokeSize"];
    [coder encodeObject:children_ forKey:@"StrokeChildren"];
}

#pragma mark -
#pragma mark enumerator methods

- (NSEnumerator *) enumerator
{
    return [[MarkEnumerator alloc] initWithMark:self];
}

- (void) enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block
{
    BOOL stop = NO;
    
    NSEnumerator *enumerator = [self enumerator];
    
    for (id <Mark> mark in enumerator)
    {
        block (mark, &stop);
        if (stop)
            break;
    }
}

#pragma mark -
#pragma mark An Extended Direct-draw Example

// for a direct draw example
- (void) drawWithContext:(CGContextRef)context
{
    CGContextMoveToPoint(context, self.location.x, self.location.y);
    
    for (id <Mark> mark in children_)
    {
        [mark drawWithContext:context];
    }
    
    CGContextSetLineWidth(context, self.size);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context,[self.color CGColor]);
    CGContextStrokePath(context);
}

#pragma mark -
#pragma mark 添加
- (id<Mark>) containPoint:(CGPoint) point
{
    
    switch (_strokeType) {
        case StrokeTypeNone:
        {
            NSInteger n = children_.count;
            
            for (; n > 0; n --) {
                id <Mark> dot = [children_ objectAtIndex:n-1];
                
                id<Mark> tMark = [dot containPoint:point];
                if (tMark) {
                    return tMark;
                }
            }
        }
            break;
        case StrokeTypeLine:
        {
            UIBezierPath *path = [[UIBezierPath alloc] init];
            
            NSInteger i = 0;
            
            for (id <Mark> dot in children_)
            {
                if (i == 0) {
                    [path moveToPoint:[dot location]];
                }else{
                    [path addLineToPoint:[dot location]];
                }
                i++;
            }
            
            path.lineWidth = LineWidth;
            path.lineJoinStyle = kCGLineJoinRound;
            path.lineCapStyle = kCGLineCapRound;
            
            
            
            
            CGPathRef pathRef = [path CGPath];
            
            pathRef = CGPathCreateCopyByStrokingPath(pathRef, &CGAffineTransformIdentity, 10, kCGLineCapRound, kCGLineJoinRound, 0);
            
            path = [UIBezierPath bezierPathWithCGPath:pathRef];
            
            CGPathRelease(pathRef);
            
            BOOL b = [path containsPoint:point];
            if (b) {
                self.selected = !self.selected;
                return self;
            }
            
            
        }
            break;
        case StrokeTypeCircle:
        {
            if (children_.count > 1) {
                id <Mark> dot = [children_ firstObject];
                
                CGPoint start = [dot location];
                
                dot = [children_ lastObject];
                
                CGPoint end = [dot location];
                
                CGRect rrect = CGRectMake(start.x,start.y,end.x - start.x,end.y - start.y);
                
//                if (abs(rrect.size.width) < 20) {
//                    rrect.size.width = rrect.size.width > 0 ? 20 : -20;
//                }
//                
//                if (abs(rrect.size.height) < 20) {
//                    rrect.size.height = rrect.size.height > 0 ? 20 : -20;
//                }
                
                UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rrect];
                
                path.lineWidth = LineWidth;
                
                
                CGPathRef pathRef = [path CGPath];
                
                pathRef = CGPathCreateCopyByStrokingPath(pathRef, &CGAffineTransformIdentity, 10, kCGLineCapRound, kCGLineJoinRound, 0);
                
                path = [UIBezierPath bezierPathWithCGPath:pathRef];
                
                
                CGPathRelease(pathRef);
                
                BOOL b = [path containsPoint:point];
                if (b) {
                    self.selected = !self.selected;
                    return self;
                }
                
            }
        }
        case StrokeTypeRound:
        {
            
            if (children_.count > 1) {
                id <Mark> dot = [children_ firstObject];
                
                CGPoint start = [dot location];
                
                dot = [children_ lastObject];
                
                CGPoint end = [dot location];
                
                CGRect rrect = CGRectMake(start.x,start.y,end.x - start.x,end.y - start.y);
                
                if (abs(rrect.size.width) < 20) {
                    rrect.size.width = rrect.size.width > 0 ? 20 : -20;
                }
                
                if (abs(rrect.size.height) < 20) {
                    rrect.size.height = rrect.size.height > 0 ? 20 : -20;
                }
                
                CGFloat radius = LineWidth;
                
//                CGFloat minx = CGRectGetMinX(rrect), maxx = CGRectGetMaxX(rrect);
//                CGFloat miny = CGRectGetMinY(rrect), maxy = CGRectGetMaxY(rrect);
//                
//                
//                UIBezierPath *path = [[UIBezierPath alloc] init];
//                
//                path.lineWidth = 10;
//                path.lineJoinStyle = kCGLineJoinRound;
//                path.lineCapStyle = kCGLineCapRound;
//                
//                
//                
//                [path addArcWithCenter:CGPointMake(minx + radius, miny + radius) radius:radius startAngle:-M_PI endAngle:-M_PI_2 clockwise:YES];
//                [path addArcWithCenter:CGPointMake(maxx - radius, miny + radius) radius:radius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
//                [path addArcWithCenter:CGPointMake(maxx - radius, maxy - radius) radius:radius startAngle:0 endAngle:M_PI_2 clockwise:YES];
//                [path addArcWithCenter:CGPointMake(minx + radius, maxy - radius) radius:radius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
//                
//                
//                [path closePath];
                
//                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rrect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rrect cornerRadius:radius];
                
                
                CGPathRef pathRef = [path CGPath];
                
                pathRef = CGPathCreateCopyByStrokingPath(pathRef, &CGAffineTransformIdentity, 10, kCGLineCapRound, kCGLineJoinRound, 0);
                
                path = [UIBezierPath bezierPathWithCGPath:pathRef];
                
                
                CGPathRelease(pathRef);
                
                BOOL b = [path containsPoint:point];
                if (b) {
                    self.selected = !self.selected;
                    return self;
                }
                
            }
            
            
        }
            break;
        case StrokeTypeWord:
        {
            if (children_.count > 0) {
                
                id <Mark> dot = [children_ firstObject];
                if ([self text]) {
                    
                    NSArray *texts = [self.text componentsSeparatedByString:@"\n"];
                    
                    CGPoint newPoint = dot.location;
                    
                    
                    UIFont *font = [UIFont boldSystemFontOfSize:self.size * 5];
                    
                    
                    CGFloat hh = font.lineHeight;
                    
                    CGSize size = CGSizeMake(hh + 20, hh + 20);
                    
                    
                    if (texts.count > 1)
                        size.height = hh * texts.count + 20;
                    
                    for (NSString *subText in texts) {
                        
                        CGSize subSize = [subText sizeWithFont:font];
                        
                        if (subSize.width + 20 > size.width) {
                            size.width = subSize.width + 20;
                        }
                    }
                    
                    CGRect rect = CGRectZero;
                    rect.origin = newPoint;
                    rect.size = size;
                    
                    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
                    
                    BOOL b = [path containsPoint:point];
                    if (b) {
                        self.selected = !self.selected;
                        return self;
                    }
                    
                    
                }
            }
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}


- (void) moveAsPoint:(CGPoint) point
{
    switch (_strokeType) {
        case StrokeTypeNone:
        {
            for (id <Mark> dot in children_)
            {
                [dot moveAsPoint:point];
                
            }
        }
            break;
        case StrokeTypeLine:
        {
            if(self.selected)
            for (id <Mark> dot in children_)
            {
                [dot moveAsPoint:point];
                
            }
            
        }
            break
            ;
        case StrokeTypeCircle:
        {
            
        }
        case StrokeTypeRound:
        {
            if(self.selected)
            if (children_.count > 1) {
                
                [[children_ firstObject] moveAsPoint:point];
                
                
                [[children_ lastObject] moveAsPoint:point];
            }
        }
            break;
        case StrokeTypeWord:
        {
            if(self.selected)
            if (children_.count > 0) {
                
                id <Mark> dot = [children_ firstObject];
                
                [dot moveAsPoint:point];
            }
        }
            break;
            
        default:
            break;
    }
}


//所有被选择的路径
- (NSArray *) allSelectedStroke
{
    NSMutableArray *allStroke = [NSMutableArray array];
    for (id <Mark> dot in children_)
    {
        if (dot.selected) {
            [allStroke addObject:dot];
        }
        
    }
    return allStroke;
}


//取消所有选中的路径
- (void) cancleAllSeleted
{
    for (id <Mark> dot in children_)
    {
        [dot setSelected:NO];
        
    }
}

@end
