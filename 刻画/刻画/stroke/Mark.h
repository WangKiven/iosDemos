//
//  Mark.h
//  刻画
//
//  Created by Kiven Wang on 14-3-10.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarkVisitor.h"



#define LineWidth self.size //设置点击先的域，方便选择。主要在 containPoint 中使用


typedef enum {
    StrokeTypeNone,
    StrokeTypeLine,
    StrokeTypeCircle,
    StrokeTypeRound,
    StrokeTypeWord,
    
    
    
    //与画图无关，用于记录
    
    StrokeTypeCliperImage,//剪切图片
    StrokeTypePsImage
}StrokeType;


@protocol Mark <NSObject, NSCopying, NSCoding>

@optional

@property (nonatomic, retain) UIColor *color;
@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, readonly) NSUInteger count;
@property (nonatomic, readonly) id <Mark> lastChild;


@property (nonatomic, assign) StrokeType strokeType;
@property (nonatomic, strong) NSString *text;
@property (nonatomic,assign) BOOL selected;




- (id) copy;
- (void) addMark:(id <Mark>) mark;
- (void) removeMark:(id <Mark>) mark;
- (id <Mark>) childMarkAtIndex:(NSUInteger) index;

// for the Visitor pattern
- (void) acceptMarkVisitor:(id <MarkVisitor>) visitor;

// for the Iterator pattern
- (NSEnumerator *) enumerator;

// for internal iterator implementation
- (void) enumerateMarksUsingBlock:(void (^)(id <Mark> item, BOOL *stop)) block;

// for a bad example
- (void) drawWithContext:(CGContextRef) context;



//point是否在已有路径上
- (id<Mark>) containPoint:(CGPoint) point;
//按向量point移动
- (void) moveAsPoint:(CGPoint) point;

//-------Stroke------
//所有被选择的路径
- (NSArray *) allSelectedStroke;

//取消所有选中的路径
- (void) cancleAllSeleted;

@end
