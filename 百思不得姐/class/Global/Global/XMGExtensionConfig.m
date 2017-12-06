//
//  XMGExtensionConfig.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/4.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGExtensionConfig.h"
#import "XMGUserModel.h"
#import "XMGCommentModel.h"
#import "XMGTopicModel.h"

@implementation XMGExtensionConfig
+ (void)load {
    
    // user Model 的配置
    [XMGUserModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"userId" : @"id",
                 };
    }];
    // XMGTopicModel 曲数组中第一个
    [XMGTopicModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                  @"top_cmt" : @"top_cmt[0]"
                 };
    }];
}
@end
