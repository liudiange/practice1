//
//  NSString+XMGFileSize.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "NSString+XMGFileSize.h"

@implementation NSString (XMGFileSize)
/**
 *
 *   计算文件／文件夹的大小
 */
- (unsigned long long)fileSize {
    
    unsigned long long size = 0;
    NSFileManager *mgr = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL isExist = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    if (!isExist) return size;
    if (isDirectory) {
        NSArray *pathArray = [mgr subpathsAtPath:self];
        for (NSString *path in pathArray) {
            NSString *sizePath = [self stringByAppendingPathComponent:path];
            NSDictionary *attrDic = [mgr attributesOfItemAtPath:sizePath error:nil];
            size += attrDic.fileSize;
        }
    }else {
        NSDictionary *attrDic = [mgr attributesOfItemAtPath:self error:nil];
        size = attrDic.fileSize;
    }
    return size;
}
@end
