//
//  XMGUserModel.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/4.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGUserModel.h"
#import <MJExtension/MJExtension.h>

@implementation XMGUserModel
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"userId":@"id"
             };
}



@end
