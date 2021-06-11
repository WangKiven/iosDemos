//
//  DrawPadView.m
//  刻画
//
//  Created by apple on 13-12-20.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import "DrawPadView.h"
#import "Dot.h"
#import "Stroke.h"
#import "MarkRenderer.h"

#import "WTextView.h"

@implementation DrawPadView

@synthesize theUndoManager = undoManager;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        
        
        [self selfInit];
        
    }
    return self;
}

- (void) selfInit
{
//    undoManager = [[NSUndoManager alloc] init];
//    
//    [undoManager setLevelsOfUndo:999];
    
    self.strokeColor = [UIColor redColor];
    
    self.strokeSize = 5;
    
    self.strokeType = 1;
    
    Scribble *scribble = [[Scribble alloc] init];
    [self setScribble:scribble];
    
    
}
- (void) dealloc
{
    NSLog(@"delloc");
}

- (void) setScribble:(Scribble *)aScribble
{
    if (_scribble) {
        if (_scribble != aScribble)
        {
            [_scribble removeObserver:self forKeyPath:@"mark"];
            
            _scribble = aScribble;
            
        }
    }else{
        _scribble = aScribble;
    }

    
    [_scribble addObserver:self
                forKeyPath:@"mark"
                   options:NSKeyValueObservingOptionInitial |
     NSKeyValueObservingOptionNew
                   context:nil];
    
}

- (void) setNewScribble:(Scribble *) scribble
{
    if (!scribble)
        scribble = [[Scribble alloc] init];
    
    NSInvocation *unInvocation = [self removeAllScrobble];
    [unInvocation setArgument:&scribble atIndex:2];
    
    NSInvocation *reInvocation = [self removeAllScrobble];
    [reInvocation setArgument:&_scribble atIndex:2];
    
    [_scribble cancleAllSeleted];
    [self deleteButtonHidden:YES];
    
    [self executeInvocation:unInvocation withUndoInvocation:reInvocation];
    
}
//- (void) drawRect:(CGRect)rect forViewPrintFormatter:(UIViewPrintFormatter *)formatter
//{
//    
//}
//- (void) drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
//{
//    
//}
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 50, 50)];
//    
//    [bezierPath stroke];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // create a renderer visitor
    MarkRenderer *markRenderer = [[MarkRenderer alloc] initWithCGContext:context];
    
    // pass this renderer along the mark composite structure
    [_mark acceptMarkVisitor:markRenderer];
    
}

#pragma mark - 接收手势
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    startPoint = [touch locationInView:self];
    
}


- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self];
    
    
    
    if (CGPointEqualToPoint(lastPoint, startPoint))
    {
        
        id<Mark> aMark = [_scribble containPoint:startPoint InMark:_mark];
        if (aMark && ([aMark selected] == NO)) {
            self.isMoving = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:SelectedStroke object:nil];
            
            
            [aMark setSelected:YES];
            
            NSArray *selectedMarks = [_scribble allSelectedStroke];
            
            aVector = [[Vertex alloc] initWithLocation:CGPointZero];
            
            NSInvocation *moveInvocation = [self moveScribbleInvocation];
            [moveInvocation setArgument:&selectedMarks atIndex:2];
            [moveInvocation setArgument:&aVector atIndex:3];
            
            
            NSInvocation *unMoveInvocation = [self cancleMoveScribbleInvocation];
            [unMoveInvocation setArgument:&selectedMarks atIndex:2];
            [unMoveInvocation setArgument:&aVector atIndex:3];
            
            [self executeInvocation:moveInvocation withUndoInvocation:unMoveInvocation];
         
        
        
//        NSArray *selectedMarks = [_scribble allSelectedStroke];
//        if (selectedMarks.count > 0) {
//            self.isMoving = YES;
//            [[NSNotificationCenter defaultCenter] postNotificationName:SelectedStroke object:nil];
//            
//            
//            
//            
//            aVector = [[Vertex alloc] initWithLocation:CGPointZero];
//            
//            NSInvocation *moveInvocation = [self moveScribbleInvocation];
//            [moveInvocation setArgument:&selectedMarks atIndex:2];
//            [moveInvocation setArgument:&aVector atIndex:3];
//            
//            
//            NSInvocation *unMoveInvocation = [self cancleMoveScribbleInvocation];
//            [unMoveInvocation setArgument:&selectedMarks atIndex:2];
//            [unMoveInvocation setArgument:&aVector atIndex:3];
//            
//            [self executeInvocation:moveInvocation withUndoInvocation:unMoveInvocation];
        
            
            
        }else{
            //取消已选择的线条
            [_scribble cancleAllSeleted];
            [self deleteButtonHidden:YES];
            
            id <Mark> newStroke = [[Stroke alloc] init];
            [newStroke setColor:_strokeColor];
            [newStroke setSize:_strokeSize];
            [newStroke setStrokeType:_strokeType];
            [newStroke setText:@""];
            
            if (_strokeType == StrokeTypeWord && ![self hasTextView]) {
                [self creatTextView:lastPoint :newStroke];
            }
            
            
            
            //[scribble_ addMark:newStroke shouldAddToPreviousMark:NO];
            
            // retrieve a new NSInvocation for drawing and
            // set new arguments for the draw command
            NSInvocation *drawInvocation = [self drawScribbleInvocation];
            [drawInvocation setArgument:&newStroke atIndex:2];
            
            // retrieve a new NSInvocation for undrawing and
            // set a new argument for the undraw command
            NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
            [undrawInvocation setArgument:&newStroke atIndex:2];
            
            // execute the draw command with the undraw command
            [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
        }
        
    }
    
    if (self.isMoving) {
        
        CGPoint curPoint = [[touches anyObject] locationInView:self];
        
        NSArray *selectedMarks = [_scribble allSelectedStroke];
        
        CGPoint theVector = [aVector location];
        
        
        theVector.x = theVector.x + (curPoint.x - lastPoint.x);
        theVector.y = theVector.y + (curPoint.y - lastPoint.y);
        
        [aVector setLocation:theVector];
        
        [_scribble moveStroke:selectedMarks withVertex:aVector shouldAddToPreviousMark:YES];
    }else{
        
        CGPoint thisPoint = [[touches anyObject] locationInView:self];
        Vertex *vertex = [[Vertex alloc]
                          initWithLocation:thisPoint];
        
        // we don't need to undo every vertex
        // so we are keeping this
        [_scribble addMark:vertex shouldAddToPreviousMark:YES];
    }
    
    
    
}


- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    startPoint = CGPointZero;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self];
//    CGPoint thisPoint = [[touches anyObject] locationInView:self];
    
    if (CGPointEqualToPoint(lastPoint, startPoint))
    {
        if (![self hasTextView]) {
            id<Mark> aMark = [_scribble containPoint:startPoint InMark:_mark];
            
            NSInteger selected = [_scribble allSelectedStroke].count;
            
            if (aMark) {
                if (selected > 0) {
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:SelectedStroke object:nil];
                    [self deleteButtonHidden:NO];
                }
                
                
            }else{
                
                //取消已选择的线条
                [_scribble cancleAllSeleted];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NOSelectedStroke object:nil];
                [self deleteButtonHidden:YES];
                
                if (selected > 0) {
                    
                }else{
                    
                    if (_strokeType == StrokeTypeWord) {
                        
                        
                        CGPoint thisPoint = [[touches anyObject] locationInView:self];
                        
                        id <Mark> newStroke = [[Stroke alloc] init];
                        [newStroke setColor:_strokeColor];
                        [newStroke setSize:_strokeSize];
                        [newStroke setStrokeType:_strokeType];
                        [newStroke setText:@""];
                        
                        [self creatTextView:lastPoint :newStroke];
                        
                        NSInvocation *drawInvocation = [self drawScribbleInvocation];
                        [drawInvocation setArgument:&newStroke atIndex:2];
                        
                        // retrieve a new NSInvocation for undrawing and
                        // set a new argument for the undraw command
                        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
                        [undrawInvocation setArgument:&newStroke atIndex:2];
                        
                        // execute the draw command with the undraw command
                        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
                        
                        Vertex *vertex = [[Vertex alloc]
                                          initWithLocation:thisPoint];
                        
                        // we don't need to undo every vertex
                        // so we are keeping this
                        [_scribble addMark:vertex shouldAddToPreviousMark:YES];
                    }else if (_strokeType == StrokeTypeLine){
                        //取消已选择的线条
                        [_scribble cancleAllSeleted];
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOSelectedStroke object:nil];
                        
                        Dot *singleDot = [[Dot alloc]
                                          initWithLocation:lastPoint];
                        [singleDot setColor:_strokeColor];
                        [singleDot setSize:_strokeSize];
                        
                        //[scribble_ addMark:singleDot shouldAddToPreviousMark:NO];
                        
                        // retrieve a new NSInvocation for drawing and
                        // set new arguments for the draw command
                        NSInvocation *drawInvocation = [self drawScribbleInvocation];
                        [drawInvocation setArgument:&singleDot atIndex:2];
                        
                        // retrieve a new NSInvocation for undrawing and
                        // set a new argument for the undraw command
                        NSInvocation *undrawInvocation = [self undrawScribbleInvocation];
                        [undrawInvocation setArgument:&singleDot atIndex:2];
                        
                        // execute the draw command with the undraw command
                        [self executeInvocation:drawInvocation withUndoInvocation:undrawInvocation];
                    }
                }
                
            }
        }
        
    }
    
    startPoint = CGPointZero;
    self.isMoving = NO;
    
}
#pragma mark - 删除按钮

- (void) deleteButtonHidden:(BOOL) b
{
    [self beginFadeAnimation];
    deleteButton.hidden = b;
}

- (IBAction) deleteStrokes:(UIButton *)sender
{
    
    [self deleteButtonHidden:YES];
    
    NSArray *selectedStrokes = [_scribble allSelectedStroke];
    
    NSMethodSignature *removeSignature = [_scribble methodSignatureForSelector:@selector(removeMarks:)];
    NSInvocation *removeInvocation = [NSInvocation invocationWithMethodSignature:removeSignature];
    
    [removeInvocation setTarget:_scribble];
    [removeInvocation setSelector:@selector(removeMarks:)];
    [removeInvocation setArgument:&selectedStrokes atIndex:2];
    
    
    NSMethodSignature *addSignature = [_scribble methodSignatureForSelector:@selector(addMarks:)];
    NSInvocation *addInvocation = [NSInvocation invocationWithMethodSignature:addSignature];
    
    [addInvocation setTarget:_scribble];
    [addInvocation setSelector:@selector(addMarks:)];
    [addInvocation setArgument:&selectedStrokes atIndex:2];
    
    
    [self executeInvocation:removeInvocation withUndoInvocation:addInvocation];
    
}

#pragma mark - 创建TextView
- (void) creatTextView:(CGPoint) point :(id<Mark>) stroke
{
    WTextView *tev = [[WTextView alloc] initWithFrame:CGRectMake(point.x, point.y, 10, _strokeSize * 5 + 10)];
    
    tev.font = [UIFont boldSystemFontOfSize:_strokeSize * 5];
    
    tev.textColor = _strokeColor;
    
    [self addSubview:tev];
    
    [tev becomeFirstResponder];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BeginText object:nil];
    
    tev.endBlock = ^(NSString *text){
        [stroke setText:text];
        [self setNeedsDisplay];
    };
}
#pragma mark - 是否已有TextView
- (BOOL) hasTextView
{
    for (id view in self.subviews) {
        if ([view isKindOfClass:[WTextView class]]) {
            
            WTextView *textview = view;
            
            [textview resignFirstResponder];
            
            return YES;
        }
    }
    
    return NO;
}


#pragma mark - undoManager

- (void) undo
{
    [undoManager undo];
    
    [_scribble cancleAllSeleted];
    
    [self deleteButtonHidden:YES];
}

- (void) redo
{
    [undoManager redo];
    
    [_scribble cancleAllSeleted];
    
    [self deleteButtonHidden:YES];
}
//画图
- (NSInvocation *) drawScribbleInvocation
{
    NSMethodSignature *executeMethodSignature = [_scribble
                                                 methodSignatureForSelector:
                                                 @selector(addMark:
                                                           shouldAddToPreviousMark:)];
    NSInvocation *drawInvocation = [NSInvocation
                                    invocationWithMethodSignature:
                                    executeMethodSignature];
    [drawInvocation setTarget:_scribble];
    [drawInvocation setSelector:@selector(addMark:shouldAddToPreviousMark:)];
    BOOL attachToPreviousMark = NO;
    [drawInvocation setArgument:&attachToPreviousMark atIndex:3];
    
    return drawInvocation;
}

- (NSInvocation *) undrawScribbleInvocation
{
    NSMethodSignature *unexecuteMethodSignature = [_scribble
                                                   methodSignatureForSelector:
                                                   @selector(removeMark:)];
    NSInvocation *undrawInvocation = [NSInvocation
                                      invocationWithMethodSignature:
                                      unexecuteMethodSignature];
    [undrawInvocation setTarget:_scribble];
    [undrawInvocation setSelector:@selector(removeMark:)];
    
    return undrawInvocation;
}
//全部移除全部线条用
- (NSInvocation *) removeAllScrobble
{
    NSMethodSignature *removeSignature = [self methodSignatureForSelector:@selector(setScribble:)];
    NSInvocation *removeInvocation = [NSInvocation invocationWithMethodSignature:removeSignature];
    
    [removeInvocation setTarget:self];
    [removeInvocation setSelector:@selector(setScribble:)];
    
    return removeInvocation;
}

//移动线条
- (NSInvocation *) moveScribbleInvocation
{
    NSMethodSignature *executeMethodSignature = [_scribble
                                                 methodSignatureForSelector:
                                                 @selector(moveStroke:withVertex:shouldAddToPreviousMark:)];
    NSInvocation *drawInvocation = [NSInvocation
                                    invocationWithMethodSignature:
                                    executeMethodSignature];
    [drawInvocation setTarget:_scribble];
    [drawInvocation setSelector:@selector(moveStroke:withVertex:shouldAddToPreviousMark:)];
    BOOL attachToPreviousMark = NO;
    [drawInvocation setArgument:&attachToPreviousMark atIndex:4];
    
    return drawInvocation;
}
- (NSInvocation *) cancleMoveScribbleInvocation
{
    NSMethodSignature *unexecuteMethodSignature = [_scribble
                                                   methodSignatureForSelector:
                                                   @selector(cancleMoveStroke:withVertex:)];
    NSInvocation *undrawInvocation = [NSInvocation
                                      invocationWithMethodSignature:
                                      unexecuteMethodSignature];
    [undrawInvocation setTarget:_scribble];
    [undrawInvocation setSelector:@selector(cancleMoveStroke:withVertex:)];
    
    return undrawInvocation;
}
//
- (void) executeInvocation:(NSInvocation *)invocation
        withUndoInvocation:(NSInvocation *)undoInvocation
{
    [invocation retainArguments];
    
    [[undoManager prepareWithInvocationTarget:self]
     unexecuteInvocation:undoInvocation
     withRedoInvocation:invocation];
    
    [invocation invoke];
}

- (void) unexecuteInvocation:(NSInvocation *)invocation
          withRedoInvocation:(NSInvocation *)redoInvocation
{
    [[undoManager prepareWithInvocationTarget:self]
     executeInvocation:redoInvocation
     withUndoInvocation:invocation];
    
    [invocation invoke];
}

#pragma mark -
#pragma mark Scribble observer method

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
    if ([object isKindOfClass:[Scribble class]] &&
        [keyPath isEqualToString:@"mark"])
    {
        id <Mark> mark = [change objectForKey:NSKeyValueChangeNewKey];
        [self setMark:mark];
        [self setNeedsDisplay];
        
    }
}

#pragma mark - method




@end
