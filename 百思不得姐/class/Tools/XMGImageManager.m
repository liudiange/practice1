//
//  XMGImageManager.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGImageManager.h"

@implementation XMGImageManager
/**
 *
 *   类方法
 */
+(instancetype)shareManager {
    
    static XMGImageManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
