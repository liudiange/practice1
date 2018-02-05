//
//  XMGSubscribeServer.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/2/1.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGHttpBaseManager.h"

@interface XMGSubscribeServer : XMGHttpBaseManager

/** 返回的字典*/
@property (nonatomic, strong) NSDictionary *responDic;

/**
 初始化

 @return 返回对象本身
 */
-(instancetype)init;
@end
