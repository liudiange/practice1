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
/** 内容*/
@property (nonatomic, copy) NSString *content;
/** user*/
@property (nonatomic, strong) XMGUserModel *user;


@end
