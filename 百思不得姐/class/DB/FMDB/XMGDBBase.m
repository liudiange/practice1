//
//  XMGDBBase.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/22.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGDBBase.h"
#import <FMDB/FMDB.h>
#import <FMDBMigrationManager/FMDBMigrationManager.h>

@implementation XMGDBBase
/**
 *
 *   创建table
 */
- (void)creatDataBase {
 
    // 创建消息表
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabase *base = [FMDatabase databaseWithPath:path];
    [base open];
    if (![XMGGlobalTool isExistWithName:@"message" withDataBase:base]) {
        NSString *tempSql = @"CREATE TABLE 'message' ('message_id' VARCHAR(255) PRIMARY KEY NOT NULL,'content' VARCHAR(255),'send_status' INTEGER)";
        [base executeUpdate:tempSql];
    }
    [base close];
}
/**
 *
 *    执行sql
 */
- (void)executeSql:(NSString *)sql withTableName:(NSString *)tableName complte:(void (^)(BOOL))complete {
   
    if (NSStringIsNull(sql)|| tableName.length == 0) {
        return;
    }
    NSString *basePath = [XMGGlobalTool getFullPathWithStr:tableName];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:basePath];
    __block BOOL result;
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        result = [db executeUpdate:sql];
        if (complete) {
            complete(result);
        }
    }];
    [queue close];
}
/**
 *
 *   根据tablename插入或者替换
 */
- (void)insertIntoOrReplace:(NSString *)tableName field:(NSArray *)fieldArray batchValue:(NSArray *)batchValus complete:(void (^)(BOOL))complete{
    
    if (fieldArray.count == 0 || batchValus.count == 0 || NSStringIsNull(tableName)) {
        return;
    }
    NSMutableString *placeHolderStr = [NSMutableString stringWithFormat:@"("];
    NSMutableString *valueStr = [NSMutableString stringWithFormat:@"("];
    for (NSString *field in fieldArray) {
        if ([field isEqualToString:[fieldArray lastObject]]) {
            [placeHolderStr appendString:@"?)"];
            [valueStr appendString:[NSString stringWithFormat:@"%@)",field]];
        }else {
            [placeHolderStr appendString:@"?,"];
            [valueStr appendString:[NSString stringWithFormat:@"%@,",field]];
        }
    }
    NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ %@ VALUES %@;",tableName,valueStr,placeHolderStr];
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block BOOL result;
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        if (batchValus.count > 0 && fieldArray.count > 0) {
            result = [db executeUpdate:sql withArgumentsInArray:batchValus];
        }
        if (complete) {
            complete(result);
        }
        if (!result) {
            XMGLOG(@"出错了 -- 数据库的名字 %@ 出错的方法---",tableName);
            XMGLOGINFUNCTION
        }
    }];
}
#pragma mark - 插入或者创建表等等
/**
 *  根据sql获取表的数据返回的数组
 *
 */
-(void)getDataWithSql:(NSString *)sql complete:(void (^)(NSArray *))complete{
    
    if (NSStringIsNull(sql)) {
        return ;
    }
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    NSMutableArray *temArray = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *result = [db executeQuery:sql];
        while([result next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int column = 0; column < result.columnCount; column ++) {
                NSString *name = [result columnNameForIndex:column];
                [dic setObject:[result objectForColumnIndex:column] forKey:name];
            }
            [temArray addObject:dic];
        }
        if (complete) {
            complete(temArray.copy);
        }
    }];
    [queue close];
}
/**
 *
 *   根据条件来进行查询
 */
- (void)getDataWithTableName:(NSString *)tableName condition:(NSDictionary *)conDic complete:(void (^)(NSArray *))complete {
    
    if (NSStringIsNull(tableName)) {
        return;
    }
    NSString *sql = nil;
    if (conDic.allKeys > 0) {
        NSMutableString *conStr = [NSMutableString stringWithString:@"WHERE"];
        NSArray *keyArray = conDic.allKeys;
        NSArray *valuesArray = conDic.allValues;
        if (keyArray.count > 0 && valuesArray.count > 0) {
            for (NSString *key in keyArray) {
                if ([key isEqualToString:[keyArray lastObject]]) {
                    [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\"",key,conDic[key]]];
                }else{
                    [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\" AND",key,conDic[key]]];
                }
            }
        }
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@;",tableName,conStr];
    }else {
        sql = [NSString stringWithFormat:@"SELECT * FROM %@;",tableName];
    }
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    NSMutableArray *temArray = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int column = 0; column < result.columnCount; column ++) {
                NSString *name = [result columnNameForIndex:column];
                [dic setObject:[result objectForColumnIndex:column] forKey:name];
            }
            [temArray addObject:dic];
        }
        if (complete) {
            complete(temArray);
        }
    }];
    [queue close];
}
/**
 *
 *   更具条件栏进行查询 condition @{@"identifier": groupIdentifer, @"address": accountInfo.address}
 */
- (void)getCountWithTableName:(NSString *)tableName condition:(NSDictionary *)conDic complete:(void (^)(NSInteger))complete {
  
    if (NSStringIsNull(tableName)) {
        return;
    }
    NSMutableString *conStr = [NSMutableString stringWithString:@"WHERE"];
    NSArray *keyArray = conDic.allKeys;
    NSArray *valuesArray = conDic.allValues;
    if (keyArray.count > 0 && valuesArray.count > 0) {
        for (NSString *key in keyArray) {
            if ([key isEqualToString:[keyArray lastObject]]) {
                [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\"",key,conDic[key]]];
            }else{
                [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\" AND",key,conDic[key]]];
            }
        }
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ %@;",tableName,conStr];
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    __block NSInteger count = 0;
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
        
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            count = [result intForColumnIndex:0];
            if (complete) {
                complete(count);
            }
        }
    }];
    [queue close];
    
}

/**
 *
 *   根据表来进行插入数据
 */
- (void)saveDataToDBWithTableName:(NSString *)tableName fieldsValues:(NSDictionary *)fieldValues complete:(void (^)(BOOL result))complete {
   
    if (NSStringIsNull(tableName)||fieldValues.allValues.count == 0) {
        return;
    }
    NSArray *keyArrays = fieldValues.allKeys;
    NSArray *valuesArrays = fieldValues.allValues;
    [self insertIntoOrReplace:tableName field:keyArrays batchValue:valuesArrays complete:complete];
}
/**
 *
 *   升或者降序输出 orderBy:@"message_id" sortway:1 2 3 (分别为升序 降序 )
 */
- (void)getDataWithName:(NSString *)tableName condition:(NSDictionary *)conDic orderBy:(NSString *)orderBy sortWay:(int)sortWay complete:(void (^)(NSArray *))complete {
    if (NSStringIsNull(tableName)|| NSStringIsNull(orderBy) ||(sortWay > 2 || sortWay < 0)) {
        return;
    }
    NSMutableString *conStr = [NSMutableString stringWithString:@"WHERE"];
    NSArray *keyArray = conDic.allKeys;
    NSArray *valuesArray = conDic.allValues;
    if (keyArray.count > 0 && valuesArray.count > 0) {
        for (NSString *key in keyArray) {
            if ([key isEqualToString:[keyArray lastObject]]) {
                [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\"",key,conDic[key]]];
            }else{
                [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\" AND",key,conDic[key]]];
            }
        }
    }
    // 升降序语句
    NSString *orderStr = nil;
    if (!NSStringIsNull(orderBy)) {
        orderStr = [NSMutableString stringWithFormat:@"ORDER BY %@ ",orderBy];
        NSString *sortStr = nil;
        switch (sortWay) {
            case 1: // 生序
            {
                sortStr = @"ASC";
            }
                break;
            case 2:  // 降序
            {
                sortStr = @"DESC";
            }
                break;
            default:
            {
                sortStr = @"ASC";
            }
                break;
        }
        orderStr = [orderStr stringByAppendingString:sortStr];
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ %@;",tableName,conStr,orderStr];
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    NSMutableArray *temArray = [NSMutableArray array];
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
       FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int index = 0; index < result.columnCount; index ++) {
                NSString *key = [result columnNameForIndex:index];
                if (!NSStringIsNull(key)) {
                    dic[key] = [result objectForColumnIndex:index];
                }
            }
            [temArray addObject:dic];
        }
        if (complete) {
            complete(temArray);
        }
    }];
}
/**
 *
 *   获取数据limit 限制 有升降序之分 
 */
- (void)getDataWithName:(NSString *)tableName condition:(NSDictionary *)conDic limit:(int)limitCount offset:(int)offsetCount orderBy:(NSString *)orderBy sortWay:(int)sortWay complete:(void (^)(NSArray *))complete {
    
    if (NSStringIsNull(tableName) || conDic.allValues.count == 0 || (sortWay > 2 || sortWay < 0)) {
        return;
    }
    // 条件语句
    NSMutableString *conStr = [NSMutableString stringWithString:@"WHERE"];
    NSArray *keyArray = conDic.allKeys;
    NSArray *valuesArray = conDic.allValues;
    if (keyArray.count > 0 && valuesArray.count > 0) {
        for (NSString *key in keyArray) {
            if ([key isEqualToString:[keyArray lastObject]]) {
                [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\"",key,conDic[key]]];
            }else{
                [conStr appendString:[NSString stringWithFormat:@" %@ = \"%@\" AND",key,conDic[key]]];
            }
        }
    }
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@;",tableName,conStr];
    // 升降序语句
    NSString *orderStr = nil;
    if (!NSStringIsNull(orderBy)) {
        orderStr =[NSMutableString stringWithFormat:@"ORDER BY %@ ",orderBy];
        NSString *sortStr = nil;
        switch (sortWay) {
            case 1: // 生序
            {
                sortStr = @"ASC";
            }
                break;
            case 2:  // 降序
            {
                sortStr = @"DESC";
            }
                break;
            default:
            {
                sortStr = @"ASC";
            }
                break;
        }
        orderStr = [orderStr stringByAppendingString:sortStr];
        sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ %@;",tableName,conStr,orderStr];
    }
    // limit 语句
    NSString *limitStr = nil;
    if (limitCount) {
        limitStr = [NSMutableString stringWithFormat:@"LIMIT %d ",limitCount];
        if (offsetCount) {
            limitStr = [limitStr stringByAppendingString:[NSString stringWithFormat:@"OFFSET %d",offsetCount]];
        }
        if (!NSStringIsNull(orderStr)) {
           sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ %@ %@;",tableName,conStr,orderStr,limitStr];
        }else {
           sql = [NSString stringWithFormat:@"SELECT * FROM %@ %@ %@;",tableName,conStr,limitStr];
        }
    }
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    NSMutableArray *temArray = [NSMutableArray array];
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            for (int index = 0; index < result.columnCount; index ++) {
                NSString *key = [result columnNameForIndex:index];
                if (!NSStringIsNull(key)) {
                    dic[key] = [result objectForColumnIndex:index];
                }
            }
            [temArray addObject:dic];
        }
        if (complete) {
            complete(temArray);
        }
    }];
}
#pragma mark - 更新
/**
 *
 *   根据表名字更新需要更新的字段
 */
- (void)updateWithName:(NSString *)tableName field:(NSDictionary *)fieldDic condition:(NSDictionary *)conDic complete:(void (^)(BOOL))complete {
    
    if (NSStringIsNull(tableName) || fieldDic.allValues.count == 0 || conDic.allKeys.count == 0) {
        return;
    }
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inDatabase:^(FMDatabase * _Nonnull db) {
    
        NSMutableString *setStr = [[NSMutableString alloc] init];
        NSArray *keyArray = fieldDic.allKeys;
        NSArray *valueArray = fieldDic.allValues;
        for (int index = 0; index < keyArray.count; index ++) {
            NSString *name = keyArray[index];
            if ([name isEqualToString:[keyArray lastObject]]) {
                [setStr appendFormat:@"%@ = \"%@\"",name,valueArray[index]];
            }else {
                [setStr appendFormat:@"%@ = \"%@\",",name,valueArray[index]];
            }
        }
        NSMutableString *conditionStr = [NSMutableString stringWithString:@"where "];
        NSArray *conKeyArray = conDic.allKeys;
        NSArray *conValueArray = conDic.allValues;
        for (int index = 0; index < conKeyArray.count; index ++) {
            NSString *name = conKeyArray[index];
            if ([name isEqualToString:[conKeyArray lastObject]]) {
                [conditionStr appendFormat:@"%@ = \"%@\"",name,conValueArray[index]];
            }else {
                [conditionStr appendFormat:@"%@ = \"%@\" AND ",name,conValueArray[index]];
            }
        }
         NSString *sql = [NSString stringWithFormat:@"update %@ set %@ %@;",tableName,setStr,conditionStr];
         BOOL result = [db executeUpdate:sql];
         if (complete) {
            complete(result);
         }
        if (!result) {
            XMGLOG(@"出错了 -- 数据库的名字 %@ 出错的方法---",tableName);
            XMGLOGINFUNCTION
        }
    }];
    [queue close];
}
#pragma mark - 删除
/**
 *
 *  删除某一个方法
 *  sql:
 */
- (void)deleteWithName:(NSString *)tableName condition:(NSDictionary *)conDic complete:(void (^)(BOOL))complete {
    if (NSStringIsNull(tableName)|| conDic.allKeys.count == 0) {
        return;
    }
    NSMutableString *conditionStr = [NSMutableString stringWithString:@"where "];
    NSArray *conKeyArray = conDic.allKeys;
    NSArray *conValueArray = conDic.allValues;
    for (int index = 0; index < conKeyArray.count; index ++) {
        NSString *name = conKeyArray[index];
        if ([name isEqualToString:[conKeyArray lastObject]]) {
            [conditionStr appendFormat:@"%@ = \"%@\"",name,conValueArray[index]];
        }else {
            [conditionStr appendFormat:@"%@ = \"%@\" AND ",name,conValueArray[index]];
        }
    }
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ %@;",tableName,conditionStr];
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        BOOL result = [db executeUpdate:sql];
        if (complete) {
            complete(result);
        }
        if (!result) {
            XMGLOG(@"出错了 -- 数据库的名字 %@ 出错的方法---",tableName);
            XMGLOGINFUNCTION
        }
    }];
    [queue close];
}
/**
 *
 *   删除一个表格
 *   sql: drop table message
 */
- (void)dropTableName:(NSString *)name complete:(void (^)(BOOL))complete {
    if (NSStringIsNull(name)) {
        return;
    }
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@;",name];
    NSString *path = [XMGGlobalTool getFullPathWithStr:DATABASE_NAME];
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:path];
    [queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        BOOL result = [db executeUpdate:sql];
        if (complete) {
            complete(result);
        }
        if (!result) {
            XMGLOG(@"出错了 -- 数据库的名字 %@ 出错的方法---",name);
            XMGLOGINFUNCTION
        }
    }];
    [queue close];
}
#pragma mark - 牵移函数
/**
 *
 *   fmdb迁移函数
 */
- (BOOL)migrationWithPath:(NSString *)pathName {
    
    if (NSStringIsNull(pathName)) {
        return NO;
    }
    NSString *path = [XMGGlobalTool getFullPathWithStr:pathName];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    [db open];
    // 数据库加密
    [db setKey:@"123"];
    // 新的数据库的路径
    FMDBMigrationManager *manager = [FMDBMigrationManager managerWithDatabase:db migrationsBundle:[NSBundle mainBundle]];
    BOOL resultStatus = NO;
    NSError *error = nil;
    if (!manager.hasMigrationsTable) {
        // 创建表
        [manager createMigrationsTable:&error];
    }
    // 执行迁移函数
    resultStatus = [manager migrateDatabaseToVersion:UINT64_MAX progress:nil error:&error];
    return resultStatus;
}


@end
