//
//  NSObject+MyExtern.m
//  FMDB 数据库
//
//  Created by Kiven Wang on 14-5-19.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "NSObject+MyExtern.h"

#import <objc/runtime.h>

@implementation NSObject (MyExtern)
/* 获取对象的所有属性及其类型 */
- (NSMutableArray *) allProperties
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        const char* attr = property_getAttributes(property);
        NSString *className = [[self class] typeOf:attr];
        if (!className) {
            className = @"";
        }
        NSDictionary *propertyInfo = [NSDictionary dictionaryWithObjectsAndKeys:propertyName, @"propertyName", className, @"propertyClass", nil];
        [props addObject:propertyInfo];
    }
    
    free(properties);
    
    return props;
}

/* 获取对象的有值属性及值和类型 */
- (NSMutableArray *)properties_aps
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue){
            //类型
            const char* attr = property_getAttributes(property);
            NSString *className = [[self class] typeOf:attr];
            if (!className) {
                className = @"";
            }
            
            //加入数组
            NSDictionary *propertyInfo = [NSDictionary dictionaryWithObjectsAndKeys:propertyName, @"propertyName", propertyValue, @"propertyValue", className, @"propertyClass", nil];
            [props addObject:propertyInfo];
        }
    }
    
    free(properties);
    
    return props;
}
/* 获取对象的所有方法 */
-(void)printMothList
{
    unsigned int mothCout_f =0;
    Method* mothList_f = class_copyMethodList([self class],&mothCout_f);
    for(int i=0;i<mothCout_f;i++)
    {
        Method temp_f = mothList_f[i];
//        IMP imp_f = method_getImplementation(temp_f);
//        SEL name_f = method_getName(temp_f);
        const char* name_s =sel_getName(method_getName(temp_f));
        int arguments = method_getNumberOfArguments(temp_f);
        const char* encoding =method_getTypeEncoding(temp_f);
        NSLog(@"方法名：%@,参数个数：%d,编码方式：%@",[NSString stringWithUTF8String:name_s],
              arguments,
              [NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

/* 获取属性类型*/
+ (NSString *)typeOf:(const char *)attr
{
	if ( attr[0] != 'T' )
		return nil;
	
	const char * type = &attr[1];
	if ( type[0] == '@' )
	{
		if ( type[1] != '"' )
			return nil;
		
		char typeClazz[128] = { 0 };
		
		const char * clazz = &type[2];
		const char * clazzEnd = strchr( clazz, '"' );
		
		if ( clazzEnd && clazz != clazzEnd )
		{
			unsigned int size = (unsigned int)(clazzEnd - clazz);
			strncpy( &typeClazz[0], clazz, size );
		}
		
		if ( 0 == strcmp((const char *)typeClazz, "NSNumber") )
		{
			return @"NSNumber";
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSString") )
		{
			return @"NSString";
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSDate") )
		{
			return @"NSDate";
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSArray") )
		{
			return @"NSArray";
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSDictionary") )
		{
			return @"NSDictionary";
		}
		else if ( 0 == strcmp((const char *)typeClazz, "NSData") )
		{
			return @"NSData";
		}
		else
		{
			return nil;
		}
	}
    else
    {
        if (type[0] == 'i')
        {
            return @"int";
        }
        else if(type[0] == 'f')
        {
            return @"float";
        }
    }
	
	return nil;
}
@end
