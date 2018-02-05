//
//  XMGDetailpullRefreshServer.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/2/1.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGDetailpullRefreshServer.h"

@implementation XMGDetailpullRefreshServer
/**
 初始化

 @param topicId id
 @return 返回对象本身
 */
-(instancetype)pullRefreshTopicId:(NSString *)topicId {
    if (self == [super init]) {
        NSMutableDictionary *parma = [NSMutableDictionary dictionary];
        parma[@"a"] = @"dataList";
        parma[@"c"] = @"comment";
        parma[@"data_id"] = topicId;
        parma[@"hot"] = @(1);
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
    self.hotArray = responseDic[@"hot"];
    self.totalStr = responseDic[@"total"];
    complete(nil);
    
}


@end
