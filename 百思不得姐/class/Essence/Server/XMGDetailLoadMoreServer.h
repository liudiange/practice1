//
//  XMGDetailLoadMoreServer.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/2/2.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGHttpBaseManager.h"

@interface XMGDetailLoadMoreServer : XMGHttpBaseManager

/** data*/
@property (nonatomic, strong) NSArray *dataArray;




/**
 初始化
 
 @param topicId topicid
 @param commentId 评论的id
 @return 对象本身
 */
- (instancetype)loadMore:(NSString *)topicId commentId:(NSString *)commentId;



@end
