//
//  NSObject+MyExtern.h
//  FMDB 数据库
//
//  Created by Kiven Wang on 14-5-19.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MyExtern)

/* 获取对象的所有属性及类型, 未知类型用@“”为值 */
- (NSMutableArray *) allProperties;

/* 获取对象的有值属性及值和类型, 未知类型用@“”为值  */
- (NSMutableArray *)properties_aps;

/* 获取对象的所有方法 */
-(void)printMothList;

/* 获取属性类型, 在allProperties中使用过*/
+ (NSString *)typeOf:(const char *)attr;

@end
