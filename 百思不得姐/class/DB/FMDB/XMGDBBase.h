//
//  XMGDBBase.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/22.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DATABASE_NAME @"migration.db"

@interface XMGDBBase : NSObject
#pragma mark - 插入或者创建表等等
/**
 *
 *   创建table
 *   判断表格是否存在：sql: [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName];
 */
- (void)creatDataBase;
/**
 *
 *    执行sql
 */
- (void)executeSql:(NSString *)sql withTableName:(NSString *)tableName complte:(void (^)(BOOL result))complete;
/**
 *
 *   根据tablename插入或者替换
 *   sql :INSERT OR REPLACE INTO message ('message_id','content','message_status') VALUES (?,?,?);
 */
- (void)insertIntoOrReplace:(NSString *)tableName field:(NSArray *)fieldArray batchValue:(NSArray *)batchValus complete:(void(^)(BOOL result))complete;
/**
 *
 *   根据表来进行插入数据
 *   INSERT OR REPLACE INTO message ('message_id','content','message_status') VALUES (?,?,?);
 */
- (void)saveDataToDBWithTableName:(NSString *)tableName fieldsValues:(NSDictionary *)fieldValues complete:(void (^)(BOOL result))complete;
#pragma mark - 获取数据等等
/**
 *  根据sql获取表的数据返回的数组
 *
 */
-(void)getDataWithSql:(NSString *)sql complete:(void (^)(NSArray *array))complete;
/**
 *
 *   根据条件来进行查询 condition @{@"identifier": groupIdentifer, @"address": accountInfo.address}
 *   sql :SELECT * FROM message WHERE message_id = "asdasd" AND content = "啊是个大公司的"
 */
- (void)getDataWithTableName:(NSString *)tableName condition:(NSDictionary *)conDic complete:(void (^)(NSArray *dataArray))complete;
/**
 *
 *   更具条件栏进行查询 condition @{@"identifier": groupIdentifer, @"address": accountInfo.address}
 */
- (void)getCountWithTableName:(NSString *)tableName condition:(NSDictionary *)conDic complete:(void (^)(NSInteger count))complete;
/**
 *
 *   升或者降序输出 orderBy:@"message_id" sortway:1 2 3 (分别为升序 降序 )
 *   sql :SELECT * FROM message WHERE message_id = "asdasd" AND content = "啊是个大公司的" ORDER BY message_id DESC(ASC)
 */
- (void)getDataWithName:(NSString *)tableName condition:(NSDictionary *)conDic orderBy:(NSString *)orderBy sortWay:(int)sortWay complete:(void (^)(NSArray *dataArray))complete;
/**
 *
 *   获取数据limit 限制
 *   sql :SELECT * FROM message WHERE message_id = "asdasd" AND content = "啊是个大公司的" ORDER BY message_id DESC(ASC) LIMIT 20 OFFSET 10
 */
- (void)getDataWithName:(NSString *)tableName condition:(NSDictionary *)conDic limit:(int)limitCount offset:(int)offsetCount orderBy:(NSString *)orderBy sortWay:(int)sortWay complete:(void(^)(NSArray *dataArray))complete;
#pragma mark - 更新
/**
 *
 *   根据表名字更新需要更新的字段
 *   sql : update message set content = "asdasdasd",send_status = "3" where message_id = "122" and send_status = "4";
 */
- (void)updateWithName:(NSString *)tableName field:(NSDictionary *)fieldDic condition:(NSDictionary *)conDic complete:(void(^)(BOOL result))complete;
#pragma mark - 删除
/**
 *
 *  删除某一个方法
 *  sql: delete from message where message_id = "122" and content = "阿什顿哈说的";
 */
- (void)deleteWithName:(NSString *)tableName condition:(NSDictionary *)conDic complete:(void (^)(BOOL resule))complete;
/**
 *
 *   删除一个表格
 *   sql: drop table message
 */
- (void)dropTableName:(NSString *)name complete:(void (^)(BOOL result))complete;
#pragma mark - 牵移函数
/**
 *
 *   fmdb迁移函数
 */
- (BOOL)migrationWithPath:(NSString *)pathName;




@end
