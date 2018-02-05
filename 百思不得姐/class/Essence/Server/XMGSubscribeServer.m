//
//  XMGSubscribeServer.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/2/1.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGSubscribeServer.h"
#import "XMGTopicModel.h"

@implementation XMGSubscribeServer
/**
 初始化
 
 @return 返回对象本身
 */
-(instancetype)init{
    if (self == [super init]) {
        NSMutableDictionary *parma = [NSMutableDictionary dictionary];
        parma[@"a"] = @"tag_recommend";
        parma[@"action"] = @"sub";
        parma[@"c"] = @"topic";
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
   
    self.responDic = responseDic;
    complete(nil);
    
}


@end
