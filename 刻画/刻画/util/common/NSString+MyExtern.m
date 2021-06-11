//
//  NSString+extern.m
//  CardHelper
//
//  Created by apple on 14-1-8.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import "NSString+MyExtern.h"

@implementation NSString (MyExtern)

- (BOOL) isBankWhenNoSpace
{
    
    NSString *subStr = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    subStr = [subStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if ([subStr isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

- (NSString *) stringByReplaceFirstString:(NSString *) aString With:(NSString *) theString
{
    NSRange range = [self rangeOfString:aString];
    
    if (range.location != NSNotFound) {
        
        NSMutableString *ns = [NSMutableString stringWithString:self];
        
        [ns replaceCharactersInRange:range withString:theString];
        
        return [NSString stringWithString:ns];
    }
    return self;
}


- (BOOL) containsSubString1:(NSString *) aString
{
    NSString *sss = [aString lowercaseString];
    NSString *ssx = [self lowercaseString];
    NSRange range = [ssx rangeOfString:sss];
    if (range.length > 0) {
        return YES;
    }
    return NO;
}


- (BOOL) containsSubString2:(NSString *) aString
{
    NSRange range = [self rangeOfString:aString];
    if (range.length > 0) {
        return YES;
    }
    return NO;
}
@end
