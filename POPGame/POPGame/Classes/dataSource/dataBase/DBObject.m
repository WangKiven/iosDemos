//
//  DBObject.m
//  FMDB 数据库
//
//  Created by Kiven Wang on 14-5-19.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import "DBObject.h"

#import "NSObject+MyExtern.h"

static FMDatabase *db;

@implementation DBObject

- (id) init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark - 操作
- (BOOL) creatTable:(BOOL) isOpen
{
    FMDatabase *dataBase = [[self class] dataBase];
    if (!isOpen) {
        [dataBase open];
    }
    
    
    if (![dataBase executeUpdate:[self creatTableSql]]) {
        if (!isOpen) {
            [dataBase close];
//            db = nil;
        }
        return NO;
    }
    
    if (!isOpen) {
        [dataBase close];
//        db = nil;
    }
    return YES;
}
- (BOOL) update:(BOOL) isOpen
{
    NSString *primaryName = [self primaryKeyName];
    if (primaryName.length < 1) {
        
        NSLog(@"没有主键，无法更新");
        return NO;
    }
    
    NSMutableArray *properties = [self properties_aps];
    /* 移除错值属性 */
    [self removeErrorValue:properties];
    
    id value;
    
    if (properties.count < 2) {
        NSLog(@"参数不足，不能更新");
        return NO;
    }else{
        NSDictionary *dic = [properties firstObject];
        if (![primaryName isEqualToString:[dic objectForKey:@"propertyName"]]) {
            NSLog(@"主键无值，不能更新");
            return NO;
        }else{
            NSString *kind = [dic objectForKey:@"propertyClass"];
            if ([kind isEqualToString:@"NSNumber"]) {
                NSNumber *value2 = [dic objectForKey:@"propertyValue"];
                if ([value2 intValue] < 1) {
                    NSLog(@"主键值不正确，不能更新");
                    return NO;
                }
            }
            
            value = [dic objectForKey:@"propertyValue"];
            [properties removeObject:dic];
        }
    }
    
    
    FMDatabase *dataBase = [[self class] dataBase];
    
    if (!isOpen) {
        [dataBase open];
    }
    
    NSMutableString *sql = [NSMutableString string];
    NSMutableArray *args = [NSMutableArray array];
    
    
    
    int count = properties.count;
    
    if (count > 0) {
        
        NSMutableArray *names = [NSMutableArray array];
        NSMutableArray *values = [NSMutableArray array];
        
        for (NSDictionary *dic in properties) {
            [names addObject:[dic objectForKey:@"propertyName"]];
            [values addObject:[dic objectForKey:@"propertyValue"]];
        }
        
        NSMutableString *sql1 = [NSMutableString stringWithFormat:@"update %@ set ", NSStringFromClass([self class])];
        
        int i = 0;
        for ( ; i < count; i++) {
            
            [sql1 appendFormat:@"%@ = ?", [names objectAtIndex:i]];
            
            if (i >= count - 1) {
                [sql1 appendFormat:@" where %@ = ?", primaryName];
            }else{
                [sql1 appendString:@", "];
            }
        }
        
        [values addObject:value];
        [sql appendString:sql1];
        [args addObjectsFromArray:values];
    }
    
    
    if ([dataBase executeUpdate:sql withArgumentsInArray:args]) {
        //        NSString *sql3 = [NSString stringWithFormat:@""]
    }
    
    if (!isOpen) {
        [dataBase close];
//        db = nil;
    }
    return YES;
}
- (BOOL) insert:(BOOL) isOpen
{
//    NSLog(@"%@", [self insertSql]);
    
    FMDatabase *dataBase = [[self class] dataBase];
    
    if (!isOpen) {
        [dataBase open];
    }
    
    NSMutableString *sql = [NSMutableString string];
    NSMutableArray *args = [NSMutableArray array];
    
    
    
    
    
    NSMutableArray *properties = [self properties_aps];
    /* 移除错值属性 */
    [self removeErrorValue:properties];
    
    int count = properties.count;
    
    if (count > 0) {
        
        NSMutableArray *names = [NSMutableArray array];
        NSMutableArray *values = [NSMutableArray array];
        
        for (NSDictionary *dic in properties) {
            [names addObject:[dic objectForKey:@"propertyName"]];
            [values addObject:[dic objectForKey:@"propertyValue"]];
        }
        
        NSMutableString *sql1 = [NSMutableString stringWithFormat:@"insert into %@(", NSStringFromClass([self class])];
        NSMutableString *sql2 = [NSMutableString stringWithString:@"values("];
        
        int i = 0;
        for ( ; i < count; i++) {
            
            [sql1 appendFormat:@"%@", [names objectAtIndex:i]];
            [sql2 appendString:@"?"];
            
            if (i >= count - 1) {
                [sql1 appendString:@") "];
                [sql2 appendString:@")"];
            }else{
                [sql1 appendString:@", "];
                [sql2 appendString:@", "];
            }
        }
        
        [sql1 appendString:sql2];
        
        
        [sql appendString:sql1];
        [args addObjectsFromArray:values];
    }
    
    
    if ([dataBase executeUpdate:sql withArgumentsInArray:args]) {
//        NSString *sql3 = [NSString stringWithFormat:@""]
    }
    
    if (!isOpen) {
        [dataBase close];
//        db = nil;
    }
    return YES;
}
- (BOOL) remove:(BOOL) isOpen
{
    
    FMDatabase *dataBase = [[self class] dataBase];
    if (!isOpen) {
        [dataBase open];
    }
    
    NSString *sql = [self removeSql];
    if (sql.length < 1) {
        
    }else{
        
        if (![dataBase executeUpdate:sql]) {
            if (!isOpen) {
                [dataBase close];
//                db = nil;
            }
            
            return NO;
        }
        
    }
    
    
    if (!isOpen) {
        [dataBase close];
//        db = nil;
    }
    
    return YES;
}

- (NSMutableArray *) select:(BOOL) isOpen
{
    NSMutableArray *allProperties = [self allProperties];
    /*移除不用属性*/
    [self removeNOUsedProperties:allProperties];
    if (allProperties.count < 1) {
        return [NSMutableArray array];
    }
    
    NSMutableArray *objs = [NSMutableArray array];
    
    FMDatabase *dataBase = [[self class] dataBase];
    
    if (!isOpen) {
        [dataBase open];
    }
    NSString *sql = [self selectSql];
    if (!sql) {
        
        if (!isOpen) {
            [dataBase close];
//            db = nil;
        }
        
        return objs;
    }
    FMResultSet *set = [dataBase executeQuery:sql];
    while ([set next]) {
        id obj = [[[self class] alloc] init];
        for (NSDictionary *property in allProperties) {
            NSString *name = [property objectForKey:@"propertyName"];
            id value = [set objectForColumnName:name];
            
            if ((NSNull *)value != [NSNull null]) {
                [obj setValue:value forKey:name];
            }
        }
        [objs addObject:obj];
    }
    if (!isOpen) {
        [dataBase close];
//        db = nil;
    }
    NSLog(@"%@查询数据条数为%ld",NSStringFromClass([self class]),objs.count);
    return objs;
}
#pragma mark - sql
- (NSString *) creatTableSql
{
    
    NSMutableArray *allProperties = [self allProperties];
    
    /*移除不用属性*/
    [self removeNOUsedProperties:allProperties];
    
    int count = allProperties.count;
    if (count > 0) {
        
        NSMutableString *sql = [NSMutableString stringWithFormat:@"create table if not exists %@(", NSStringFromClass([self class])];
        int i = 0;
        
        for (NSDictionary *property in allProperties) {
            i ++ ;
            
            /*SQL语句添加属性，创建表时用*/
            [self sqlAddProperty:property SQL:sql];
            
            if (i == 1 && [self usePrimaryKey]) {
                [sql appendString:@"primary key"];
            }
            
            if (i < count) {
                [sql appendString:@", "];
            }else{
                [sql appendString:@")"];
            }
        }
        return sql;
    }
    
    return nil;
}
- (NSString *) updateSql
{
    
    return nil;
}


- (NSString *) removeSql
{
    //delete from tablename where id = 3 and name = 'kiven'
    NSMutableArray *properties = [self properties_aps];
    
    /* 移除NSData属性  移除错值属性 */
    [self removeNSDataAndErrorValue:properties];
    
    
    int count = properties.count;
    
    NSMutableString *sql = [NSMutableString string];
    if (count < 1) {
        return sql;
    }else{
        [sql appendFormat:@"delete from %@ where ",NSStringFromClass([self class])];
        
        int i = 0;
        for (NSDictionary *property in properties) {
            i ++ ;
            
            if ([[property objectForKey:@"propertyClass"] isEqualToString:@"NSNumber"]) {
                [sql appendFormat:@"%@ = %@ ",[property objectForKey:@"propertyName"], [property objectForKey:@"propertyValue"]];
            }else if ([[property objectForKey:@"propertyClass"] isEqualToString:@"NSString"]){
                
                [sql appendFormat:@"%@ = '%@' ",[property objectForKey:@"propertyName"], [property objectForKey:@"propertyValue"]];
            }
            
            if (i < count) {
                [sql appendString:@"and "];
            }
        }
    }
    
    return sql;
}
- (NSString *) selectSql
{
    NSMutableArray *properties = [self properties_aps];
    /* 移除错值属性 */
    [self removeErrorValue:properties];
    
    int count = properties.count;
    
    NSMutableString *sql = [NSMutableString string];
    if (count < 1) {
        [sql appendFormat:@"select * from %@",NSStringFromClass([self class])];
    }else{
        [sql appendFormat:@"select * from %@ where ",NSStringFromClass([self class])];
        
        int i = 0;
        for (NSDictionary *property in properties) {
            i ++ ;
            
            if ([[property objectForKey:@"propertyClass"] isEqualToString:@"NSNumber"]) {
                [sql appendFormat:@"%@ = %@ ",[property objectForKey:@"propertyName"], [property objectForKey:@"propertyValue"]];
            }else if ([[property objectForKey:@"propertyClass"] isEqualToString:@"NSString"]){
                
                [sql appendFormat:@"%@ = '%@' ",[property objectForKey:@"propertyName"], [property objectForKey:@"propertyValue"]];
            }
            
            if (i < count) {
                [sql appendString:@"and "];
            }
        }
    }
    
    return sql;
}

#pragma mark - 其他方法

/*移除不用属性*/
- (void) removeNOUsedProperties:(NSMutableArray *) proprities
{
    NSMutableArray *noUseds = [NSMutableArray array];
    
    for (NSMutableDictionary *property in proprities) {
        NSString *propertyClass = [property objectForKey:@"propertyClass"];
        
        BOOL isUsed = NO;
        
        if (propertyClass) {
            if ([propertyClass isEqualToString:@"NSNumber"]) {
                isUsed = YES;
            }else if([propertyClass isEqualToString:@"NSString"]){
                isUsed = YES;
            }else if ([propertyClass isEqualToString:@"NSData"]){
                isUsed = YES;
            }
            
        }
        
        if (!isUsed) {
            [noUseds addObject:property];
        }
    }
    
    [proprities removeObjectsInArray:noUseds];
}

/*SQL语句添加属性，创建表时用*/
- (void) sqlAddProperty:(NSDictionary *) property SQL:(NSMutableString *) sql
{
    NSString *propertyClass = [property objectForKey:@"propertyClass"];
    if (propertyClass) {
        if ([propertyClass isEqualToString:@"NSNumber"]) {
            [sql appendFormat:@"%@ INTEGER ", [property objectForKey:@"propertyName"]];
        }else if([propertyClass isEqualToString:@"NSString"]){
            [sql appendFormat:@"%@ TEXT ", [property objectForKey:@"propertyName"]];
        }else if ([propertyClass isEqualToString:@"NSData"]){
            [sql appendFormat:@"%@ BLOB ", [property objectForKey:@"propertyName"]];
        }
        
    }
}

/* 移除错值属性 */
- (void) removeErrorValue:(NSMutableArray *) properties
{
//    NSLog(@"%@",properties);
    NSMutableArray *ErrorProperties = [NSMutableArray array];
    for (NSMutableDictionary *property in properties) {
        id value = [property objectForKey:@"propertyValue"];
        
        BOOL isError = YES;
        
        if (value) {
            if ([value isKindOfClass:[NSNumber class]]) {
                isError = NO;
            }else if([value isKindOfClass:[NSString class]]){
                isError = NO;
            }else if ([value isKindOfClass:[NSData class]]){
                isError = NO;
            }
        }
        
        if (isError) {
            [ErrorProperties addObject:property];
        }
    }
    
    [properties removeObjectsInArray:ErrorProperties];
}
/* 移除NSData属性  移除错值属性 */
- (void) removeNSDataAndErrorValue:(NSMutableArray *) properties
{
    NSMutableArray *ErrorProperties = [NSMutableArray array];
    for (NSMutableDictionary *property in properties) {
        id value = [property objectForKey:@"propertyValue"];
        
        BOOL isError = YES;
        
        if (value) {
            if ([value isKindOfClass:[NSNumber class]]) {
                isError = NO;
            }else if([value isKindOfClass:[NSString class]]){
                isError = NO;
            }
        }
        
        if (isError) {
            [ErrorProperties addObject:property];
        }
    }
    
    [properties removeObjectsInArray:ErrorProperties];
}

/*在子类中重写，设置是否使用主键*/
- (BOOL) usePrimaryKey
{
    return YES;
}

- (NSString *) primaryKeyName
{
    if ([self usePrimaryKey]) {
        NSMutableArray *ps = [self allProperties];
        [self removeNOUsedProperties:ps];
        NSDictionary *property = [ps firstObject];
        return [property objectForKey:@"propertyName"];
    }else{
        return @"";
    }
}
/*获取数据库*/
+ (FMDatabase *) dataBase
{
    if (!db) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentDirectory = [paths objectAtIndex:0];
        
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:@"MyDatabase.sqlite"];
        
        db = [FMDatabase databaseWithPath:dbPath] ;
    }
    return db;
}

//+ (void) clearDatabase
//{
//    db = nil;
//}

@end
