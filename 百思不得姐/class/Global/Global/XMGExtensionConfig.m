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
                 @"userId" : @"id"
                 };
    }];
    // comment Model
    [XMGCommentModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"commentId" : @"id"
                 };
    }];
    // comment Model 限制用户model
//    [XMGCommentModel mj_setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"user" : [XMGUserModel class]
//                 };
//    }];
    // XMGTopicModel 曲数组中第一个
    [XMGTopicModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                  @"top_cmt" : @"top_cmt[0]",
                  @"small_image" : @"image0",
                  @"middle_image" : @"image2",
                  @"large_image" : @"image1",
                  @"videourl" : @"videouri",
                  @"voiceurl" : @"voiceuri",
                  @"topicId" : @"id"
                 };
    }];
}
@end
