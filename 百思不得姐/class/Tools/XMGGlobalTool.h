//
//  XMGGlobalTool.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/22.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
#import "XMGDBBase.h"

@interface XMGGlobalTool : NSObject
/**
 *
 *   判断是否是str
 */
+ (BOOL)isString:(id )str;
/**
 *
 *   拼接全路径
 */
+ (NSString *)getFullPathWithStr:(NSString *)str;
/**
 *
 *   判断一个表是否存在了
 */
+ (BOOL)isExistWithName:(NSString *)tableName withDataBase:(FMDatabase *)base;



@end
