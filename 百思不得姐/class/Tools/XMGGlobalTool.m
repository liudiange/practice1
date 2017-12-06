//
//  XMGGlobalTool.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/22.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGGlobalTool.h"

@implementation XMGGlobalTool
/**
 *
 *   判断是否是str
 */
+ (BOOL)isString:(id )str {
    if (![str isKindOfClass:[NSString class]]) {
        return NO;
    }else {
        NSString * temStr = (NSString *)str;
        if (temStr.length == 0 || [temStr isEqualToString:@""] || [temStr isEqualToString:@" "]) {
            return YES;
        }else {
            return NO;
        }
    }
}
/**
 *
 *   拼接全路径
 */
+ (NSString *)getFullPathWithStr:(NSString *)str{
    // 拼接全路径
    NSString * tableName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:str];
    if (![[NSFileManager defaultManager] fileExistsAtPath:tableName]) {
        [[NSFileManager defaultManager] createFileAtPath:tableName contents:nil attributes:nil];
    }
    return tableName;
}
/**
 *
 *   判断一个表是否存在了
 */
+ (BOOL)isExistWithName:(NSString *)tableName withDataBase:(FMDatabase *)base {
    // 创建消息表
    NSString *existsSql = [NSString stringWithFormat:@"select count(name) as countNum from sqlite_master where type = 'table' and name = '%@'", tableName];
    FMResultSet *rs = [base executeQuery:existsSql];
    if ([rs next]) {
        NSInteger count = [rs intForColumn:@"countNum"];
        if (count == 1) {
            return YES;
        }
    }
    return NO;
}

@end
