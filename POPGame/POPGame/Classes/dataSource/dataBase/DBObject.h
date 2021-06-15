//
//  DBObject.h
//  FMDB 数据库
//
//  Created by Kiven Wang on 14-5-19.
//  Copyright (c) 2014年 Kiven Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
/*
 注意：1.在本类用于数据库的数据类型仅有NSNumber、NSString、NSData，其他数据类型将本忽略。
      2.创建表时设置是否使用主键，如使用主键本类将第一个属性设置为主键
      3.如果主键是NSNumber，会使用自增长，不能传入float类型值，如果传入float类型，会被转化为int类型值。其他NSNumber属性，可以传入float类型值
      4.子类必须有自己的属性。父类的属性不会用于子类。
 */
@interface DBObject : NSObject


- (BOOL) creatTable:(BOOL) isOpen;//isOpen:表示数据库是否已经打开，如NO,在本方法中，将打开和关闭数据库，如YES,这不会管理数据库的开关。
- (BOOL) update:(BOOL) isOpen;//以主键为查找条件跟新数据，所以必须有主键才行。直接调用insert：
- (BOOL) insert:(BOOL) isOpen;
- (BOOL) remove:(BOOL) isOpen;//仅NSNumber、NSString有用，NSData不方便用来查询
- (NSMutableArray *) select:(BOOL) isOpen;//仅NSNumber、NSString有用，NSData不方便用来查询

- (NSString *) creatTableSql;
//- (NSString *) updateSql;
//- (NSString *) insertSql;
- (NSString *) removeSql;
- (NSString *) selectSql;

/*在子类中重写，设置是否使用主键.默认使用主键*/
- (BOOL) usePrimaryKey;

/*获取主键名称*/
- (NSString *) primaryKeyName;

/*获取数据库*/
+ (FMDatabase *) dataBase;
//+ (void) clearDatabase;
@end
