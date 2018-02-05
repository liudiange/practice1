//
//  XMGDetailLoadMoreServer.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/2/2.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGDetailLoadMoreServer.h"

@implementation XMGDetailLoadMoreServer
/**
 初始化

 @param topicId topicid
 @param commentId 评论的id
 @return 对象本身
 */
- (instancetype)loadMore:(NSString *)topicId commentId:(NSString *)commentId {
    
    if (self == [super init]) {
        NSMutableDictionary *parma = [NSMutableDictionary dictionary];
        parma[@"a"] = @"dataList";
        parma[@"c"] = @"comment";
        parma[@"data_id"] = topicId;
        parma[@"lastcid"] = commentId;
        self.requestUrl = GetEssenceData;
        self.paramDic = parma;
        self.requestMethod = @"GET";
    }
    return self;
}
/**
 重写父类的方法
 
 @param responseDic 返回的数据
 @param complete 回调
 */
- (void)parseData:(NSDictionary *)responseDic complete:(void (^)(NSError * _Null_unspecified))complete {
    if (![responseDic isKindOfClass:[NSDictionary class]]) {
        NSError *error = [NSError errorWithDomain:@"已经没有数据了" code:100 userInfo:nil];
        complete(error);
    }
    self.dataArray = responseDic[@"data"];
    complete(nil);
    
}

@end
