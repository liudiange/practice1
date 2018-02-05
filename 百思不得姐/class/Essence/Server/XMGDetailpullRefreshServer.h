//
//  XMGDetailpullRefreshServer.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/2/1.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGHttpBaseManager.h"

@interface XMGDetailpullRefreshServer : XMGHttpBaseManager
/** 热门数据*/
@property (nonatomic, strong) NSArray *hotArray;
/** data*/
@property (nonatomic, strong) NSArray *dataArray;
/** 总数*/
@property (copy, nonatomic) NSString *totalStr;


/**
 初始化
 
 @param topicId id
 @return 返回对象本身
 */
-(instancetype)pullRefreshTopicId:(NSString *)topicId;
@end
