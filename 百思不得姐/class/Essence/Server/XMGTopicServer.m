//
//  XMGTopicServer.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/31.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGTopicServer.h"
#import "XMGobject.h"

@implementation XMGTopicServer
/**
 下拉刷新的接口请求
 
 @param type 各种类型的数据
 @return 返回网络请求的model
 */
-(instancetype)pullRefresh:(TopicType)type {
    if (self == [super init]) {
        
        NSMutableDictionary *parma = [NSMutableDictionary dictionary];
        parma[@"a"] = @"list";
        parma[@"c"] = @"data";
        parma[@"type"] = @(type);
        self.requestUrl = GetEssenceData;
        self.paramDic = parma;
        self.requestMethod = @"GET";
    }
    return self;
}
/**
 上啦加载更多
 
 @param type 传递的类型
 @param maxTime 上次最大的个数
 @return 对象本身
 */
- (instancetype)loadMore:(TopicType)type withMaxTime:(NSString *)maxTime {
    if (self == [super init]) {
        NSMutableDictionary *parma = [NSMutableDictionary dictionary];
        parma[@"a"] = @"list";
        parma[@"c"] = @"data";
        parma[@"type"] = @(type);
        parma[@"maxtime"] = maxTime;
        self.requestUrl = GetEssenceData;
        self.paramDic = parma;
        self.requestMethod = @"GET";
    }
    return self;
    
}
/**
 重写父类的方法

 @param responseDic 后台给的字典
 @param complete 回调的block
 */
- (void)parseData:(NSDictionary * __nonnull)responseDic complete:(void (^)(NSError *_Null_unspecified error))complete{
    self.maxTime= responseDic[@"info"][@"maxtime"];
    self.listArray = responseDic[@"list"];
    complete(nil);
}
@end
