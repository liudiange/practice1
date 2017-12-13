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
+ (BOOL)isString:(NSString *)str {
    if (str.length == 0 || [str isEqualToString:@""] || [str isEqualToString:@" "]) {
        return YES;
    }else {
        return NO;
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
/**
 *
 *   将xngtopicmodel 改成 xmgdbtopicmodel
 */
+ (XMGDBTopicModel *)changeTopicModelToDBTopicModel:(XMGTopicModel *)topicModel withContext:(NSManagedObjectContext *)context{
    
    XMGDBTopicModel *dbModel = [XMGDBTopicModel MR_createEntityInContext:context];
    dbModel.profile_image = topicModel.profile_image;
    dbModel.topicId = topicModel.topicId;
    dbModel.name = topicModel.name;
    dbModel.created_at = topicModel.created_at;
    dbModel.text = topicModel.text;
    dbModel.ding = topicModel.ding;
    dbModel.comment = topicModel.comment;
    dbModel.cai = topicModel.cai;
    dbModel.repost = topicModel.repost;
    dbModel.type = topicModel.type;
    dbModel.width = topicModel.width;
    dbModel.height = topicModel.height;
    dbModel.small_image = topicModel.small_image;
    dbModel.middle_image = topicModel.middle_image;
    dbModel.large_image = topicModel.large_image;
    dbModel.is_gif = topicModel.is_gif;
    dbModel.playcount = topicModel.playcount;
    dbModel.videotime = topicModel.videotime;
    dbModel.voicetime = topicModel.voicetime;
    dbModel.videourl = topicModel.videourl;
    dbModel.voiceurl = topicModel.voiceurl;
    // 付值模型
    XMGDBCommentModel *dbCommentModel = [XMGDBCommentModel MR_createEntityInContext:context];
    dbCommentModel.content = topicModel.top_cmt.content;
    XMGDBUser *dbUser = [XMGDBUser MR_createEntityInContext:context];
    dbUser.userId = topicModel.top_cmt.user.userId;
    dbUser.username = topicModel.top_cmt.user.username;
    dbCommentModel.user = dbUser;
    dbModel.top_cmt = dbCommentModel;
    
    return dbModel;
}
/**
 *
 *   将xmgdbtopicmodel 改成 xngtopicmodel
 */
+ (XMGTopicModel *)changeDBTopicModelToTopicModel:(XMGDBTopicModel *)dbModel {
    
    XMGTopicModel *model = [[XMGTopicModel alloc] init];
    model.topicId = dbModel.topicId;
    model.profile_image = dbModel.profile_image;
    model.name = dbModel.name;
    model.created_at = dbModel.created_at;
    model.text = dbModel.text;
    model.ding = dbModel.ding;
    model.comment = dbModel.comment;
    model.cai = dbModel.cai;
    model.repost = dbModel.repost;
    model.type = dbModel.type;
    model.width = dbModel.width;
    model.height = dbModel.height;
    model.small_image = dbModel.small_image;
    model.middle_image = dbModel.middle_image;
    model.large_image = dbModel.large_image;
    model.is_gif = dbModel.is_gif;
    model.playcount = dbModel.playcount;
    model.videotime = dbModel.videotime;
    model.voicetime = dbModel.voicetime;
    model.videourl = dbModel.videourl;
    model.voiceurl = dbModel.voiceurl;
    // 付值模型
    XMGUserModel *userModel = [[XMGUserModel alloc] init];
    userModel.username = dbModel.top_cmt.user.username;
    userModel.userId = dbModel.top_cmt.user.userId;
    XMGCommentModel *commentModel = [[XMGCommentModel alloc] init];
    commentModel.user = userModel;
    commentModel.content = dbModel.top_cmt.content;
    model.top_cmt = commentModel;
    
    return model;
    
}
@end
