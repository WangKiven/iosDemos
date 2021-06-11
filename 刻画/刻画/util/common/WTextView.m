//
//  WTextView.m
//  刻画
//
//  Created by Kiven Wang on 14-3-11.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "WTextView.h"

@implementation WTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x - 10, frame.origin.y - 10, frame.size.width, frame.size.height)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
        
        self.scrollEnabled = NO;
        
        self.delegate = self;
        
        for (UIView *view in self.subviews) {
            view.hidden = YES;
        }
        
        [self initData];
    }
    return self;
}

- (void) initData
{
    //-----监听键盘切换-----
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextSetFillColorWithColor(context, [self.textColor CGColor]);
//    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
//    
//    CGContextSelectFont(context, "Helvetica", 36.0, kCGEncodingMacRoman);
//    
//    CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0, -1.0));
//    
//    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
//    
//    [self.text drawAtPoint:CGPointMake(0, 0) withFont:self.font];
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    CGRect frame = textView.frame;
    
    NSArray *texts = [textView.text componentsSeparatedByString:@"\n"];
    
    CGFloat hh = self.font.lineHeight;
    
    CGSize size = CGSizeMake(hh + 20, hh + 20);
    
    if (texts.count > 1)
        size.height = hh * texts.count + 20;
        
    for (NSString *subText in texts) {
        
        CGSize subSize = [subText sizeWithFont:self.font];
        
        if (subSize.width + 20 > size.width) {
            size.width = subSize.width + 20;
        }
    }
    
//    CGSize size = [textView.text sizeWithFont:self.font];
    
    
    frame.size = size;
    
    textView.frame = frame;
    
    textView.scrollsToTop = YES;
    
    CGFloat ff = self.frame.size.height - aRect.origin.y;
    if (ff > 0) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        
        CGRect frame = self.superview.superview.frame;
        
        frame.origin.y -= ff;
        
        self.superview.superview.frame = frame;
        
        [UIView commitAnimations];
        
        aRect.origin.y += ff;
    }
    
    if (_endBlock) {
        _endBlock(self.text);
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EndText object:nil];
    [self removeFromSuperview];
}


//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

#pragma mark - keyboard notification


- (void)keyboardWillShow:(NSNotification*)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    CGRect keyboardFrame = [self convertRect:keyboardRect fromView:[[UIApplication sharedApplication] keyWindow]];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    if (keyboardFrame.origin.y < self.frame.size.height) {
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect frame = self.superview.superview.frame;
        
        frame.origin.y -= self.frame.size.height - keyboardFrame.origin.y;
        
        self.superview.superview.frame = frame;
        
        [UIView commitAnimations];
    }
    
    aRect = keyboardFrame;
}

- (void)keyboardWillHide:(NSNotification*)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    CGRect frame = self.superview.superview.bounds;
    
    self.superview.superview.frame = frame;
    
    
    [UIView commitAnimations];
}

- (void) keyboardWillChange:(NSNotification *) notification{
    [self keyboardWillShow:notification];
}

@end
