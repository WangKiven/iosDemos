//
//  NSString+extern.h
//  CardHelper
//
//  Created by apple on 14-1-8.
//  Copyright (c) 2014年 suin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyExtern)

/**功能：是否有除空格以外的其他字符
 *
 *
 */
- (BOOL) isBankWhenNoSpace;

/**功能：返回aString替换第一个匹配后的字符串
 *
 *
 */
- (NSString *) stringByReplaceFirstString:(NSString *) aString With:(NSString *) theString;

/**功能：判断是否包含某个子串
 *
 *
 */
//不区分大小写
- (BOOL) containsSubString1:(NSString *) aString;

//区分大小写
- (BOOL) containsSubString2:(NSString *) aString;

@end
