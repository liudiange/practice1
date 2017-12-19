//
//  XMGImageManager.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGImageManager : NSObject
/**
 *
 *   类方法
 */
+(instancetype)shareManager;
/** 当前的image*/
@property (nonatomic, strong) NSMutableArray *smallImageArray;
/** 当前的image*/
@property (nonatomic, strong) NSMutableArray *bigImageArray;
@end
