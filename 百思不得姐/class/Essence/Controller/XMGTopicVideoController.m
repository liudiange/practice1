//
//  XMGTopicVideoController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicVideoController.h"
#import <AVFoundation/AVFoundation.h>

@interface XMGTopicVideoController ()

@property (strong, nonatomic)AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation XMGTopicVideoController
- (AVPlayer *)player {
    if (!_player) {
        NSURL *url = [NSURL URLWithString:@"http://218.200.160.29/rdp2/test/mac/mv/mp4.do?mvid=600570YAT41&ua=Mac_sst&version=1.0&formatid=050014"];
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        self.playerLayer.frame = CGRectMake(0, 100, 375, 400);
        [self.view.layer addSublayer:self.playerLayer];
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XMG_BACKGROUND_COLOR;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.player play];
}
/**
 *
 *  返回的事件
 */
- (IBAction)backAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
