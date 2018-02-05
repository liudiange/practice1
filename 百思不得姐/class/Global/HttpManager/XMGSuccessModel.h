//
//  XMGSuccessModel.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/29.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGSuccessModel : NSObject

/** 成功的返回吗*/
@property (nonatomic, copy) NSString *successCode;
/** 成功的返回的字典*/
@property (nonatomic, strong) NSDictionary *successDic;






@end
