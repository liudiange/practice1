//
//  XMGMusicManager.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/11.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGMusicManager.h"
#import <AVFoundation/AVFoundation.h>

@interface XMGMusicManager()
// 声音播放boplayer
@property (nonatomic, strong) AVPlayer *player;


@end

@implementation XMGMusicManager
/**
 *
 *   类方法
 */
+(instancetype)shareManager {
    
    static XMGMusicManager * _manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}
/**
 *
 *   播放音乐
 */
- (void)playMusicWithUrl:(NSString *)playUrl {
    
    self.currentUrl = playUrl;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:playUrl]];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    [self.player play];
   
}
/**
 *
 *   暂停音乐
 */
- (void)pauseWithUrl:(NSString *)playUrl {
    
    [self.player pause];
    self.player = nil;
}
/**
 *
 *   暂停音乐
 */
- (void)pause {
    [self.player pause];
    self.player = nil;
}
/**
 *
 *   播放速度
 */
- (CGFloat)rate {
    return self.player.rate;
}

@end
