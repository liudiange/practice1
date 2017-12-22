//
//  XMGCommentModel.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/4.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMGUserModel.h"

@interface XMGCommentModel : NSObject
/** id*/
@property (nonatomic, copy) NSString *commentId;
/** 内容*/
@property (nonatomic, copy) NSString *content;
/** user*/
@property (nonatomic, strong) XMGUserModel *user;
/** 被点赞的个数*/
@property (nonatomic, assign) NSInteger like_count;
/** 音频文件的时长*/
@property (nonatomic, assign) NSInteger voicetime;
/** 音频文件的url*/
@property (nonatomic, copy) NSString *voiceuri;



@end
