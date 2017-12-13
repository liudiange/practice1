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
#import "XMGDBTopicModel+CoreDataClass.h"
#import "XMGDBUser+CoreDataClass.h"
#import "XMGDBCommentModel+CoreDataClass.h"
#import "XMGTopicModel.h"

@interface XMGGlobalTool : NSObject
/**
 *
 *   判断是否是str
 */
+ (BOOL)isString:(NSString *)str;
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
/**
 *
 *   将xngtopicmodel 改成 xmgdbtopicmodel
 */
+ (XMGDBTopicModel *)changeTopicModelToDBTopicModel:(XMGTopicModel *)topicModel withContext:(NSManagedObjectContext *)context;
/**
 *
 *   将xmgdbtopicmodel 改成 xngtopicmodel
 */
+ (XMGTopicModel *)changeDBTopicModelToTopicModel:(XMGDBTopicModel *)dbModel;



@end
