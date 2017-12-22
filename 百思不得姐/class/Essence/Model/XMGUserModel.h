//
//  XMGUserModel.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/4.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGUserModel : NSObject

/** 名字*/
@property (nonatomic, copy) NSString *username;
/** id*/
@property (nonatomic, copy) NSString *userId;
/** 用户的头像*/
@property (nonatomic, copy) NSString *profile_image;
/** 用户的性别*/
@property (nonatomic, copy) NSString *sex;


@end
