//
//  WTextView.h
//  刻画
//
//  Created by Kiven Wang on 14-3-11.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WTextViewEndBlock)(NSString *text);

@interface WTextView : UITextView<UITextViewDelegate>
{
    CGRect aRect;//记录键盘宇textview 的相对位置
}

@property (nonatomic, strong) WTextViewEndBlock endBlock;

@end
