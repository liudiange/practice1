//
//  XMGTopicServer.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/31.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGHttpBaseManager.h"
#import "XMGTopicModel.h"


@interface XMGTopicServer : XMGHttpBaseManager

// 存储数据的数组
@property (nonatomic, strong) NSArray *listArray;
@property (copy, nonatomic) NSString *maxTime;

/**
 下拉刷新的接口请求

 @param type 各种类型的数据
 @return 返回网络请求的model
 */
- (instancetype)pullRefresh:(TopicType)type;
/**
 上啦加载更多

 @param type 传递的类型
 @param maxTime 上次最大的个数
 @return 对象本身
 */
- (instancetype)loadMore:(TopicType)type withMaxTime:(NSString *)maxTime;



@end
