//
//  DrawPadView.h
//  刻画
//
//  Created by apple on 13-12-20.
//  Copyright (c) 2013年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectorView.h"

#import "Scribble.h"


@interface DrawPadView : UIView
{
    NSUndoManager *undoManager;
    
    CGPoint startPoint;
    
    NSInteger num;
    
    id<Mark> aVector;
    
    
    IBOutlet UIButton *deleteButton;//删除按钮
}

@property (nonatomic, strong) NSUndoManager *theUndoManager;

@property (nonatomic, strong) Scribble *scribble;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeSize;

@property (nonatomic,assign) BOOL isMoving;//判断是在移动线条等图案

@property (nonatomic) SelectorSubType currentNibType;//未使用
@property (nonatomic) SelectorSubType currentPathType;//未使用

@property (nonatomic, retain) id <Mark> mark;

@property (nonatomic) StrokeType strokeType;

- (void) undo;

- (void) redo;

- (void) setNewScribble:(Scribble *) scribble;//在清除全部路径时用

- (void) deleteButtonHidden:(BOOL) b;//删除按钮的显示与隐藏

//NewController也会用到
- (void) executeInvocation:(NSInvocation *)invocation
        withUndoInvocation:(NSInvocation *)undoInvocation;


- (void) unexecuteInvocation:(NSInvocation *)invocation
          withRedoInvocation:(NSInvocation *)redoInvocation;

@end
