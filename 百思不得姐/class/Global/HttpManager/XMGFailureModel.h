//
//  XMGFailureModel.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/29.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGFailureModel : NSObject

/** 错误码*/
@property (nonatomic, assign) NSInteger errorCode;
/** 错误的信息*/
@property (nonatomic, copy) NSString *errorMessage;
/** 错误*/
@property (nonatomic, strong) NSError *error;

@end
