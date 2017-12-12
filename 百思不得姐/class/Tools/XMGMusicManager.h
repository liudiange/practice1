//
//  XMGMusicManager.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/11.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGMusicManager : NSObject
/** 播放的url*/
@property (copy, nonatomic) NSString *currentUrl;
/**
 *
 *   类方法
 */
+(instancetype)shareManager;
/**
 *
 *   播放音乐
 */
- (void)playMusicWithUrl:(NSString *)playUrl;
/**
 *
 *   暂停音乐
 */
- (void)pauseWithUrl:(NSString *)playUrl;
/**
 *
 *   暂停音乐
 */
- (void)pause;
/**
 *
 *   播放速度
 */
- (CGFloat)rate;


@end
