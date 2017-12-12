//
//  XMGTopicVoiceView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicVoiceView.h"
#import <AVFoundation/AVFoundation.h>
#import "XMGMusicManager.h"


@interface XMGTopicVoiceView ()

@property (nonatomic, strong) RACDisposable *finishDispable;
@property (nonatomic, strong) RACDisposable *rateDispable;
@property (nonatomic, strong) XMGTopicModel *currentModel;


@end

@implementation XMGTopicVoiceView
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.progressLabel.font = [UIFont systemFontOfSize:12.0];
    // 监听player是否播放完毕
    @weakify(self);
    self.finishDispable = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [[XMGMusicManager shareManager] pause];
        [[NSNotificationCenter defaultCenter] postNotificationName:VoiceRefreshFinish object:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
           self.iconListenButton.hidden = NO;
        });
    }];
}
/**
 *
 *  点击按钮的事件
 */
- (IBAction)iconListenButtonAction:(UIButton *)sender {

    if (![self.currentModel.voiceurl isEqualToString:[XMGMusicManager shareManager].currentUrl] || [XMGMusicManager shareManager].rate == 0) {
        [[XMGMusicManager shareManager] playMusicWithUrl:self.currentModel.voiceurl];
        self.iconListenButton.hidden = YES;
    }
}
/**
 *
 *  重写model进行付值
 */
- (void)setTopicModel:(XMGTopicModel *)topicModel {
    
    self.currentModel = topicModel;

    self.rightTopLable.text = [NSString stringWithFormat:@"%zd播放",topicModel.playcount];
    NSInteger minute = topicModel.voicetime / 60;
    NSInteger second = topicModel.voicetime % 60;
    // 其中2： 代表占几位 0： 表示不足的用0来代替
    self.rightBottomLable.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.small_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.hidden = NO;
            self.iconListenButton.hidden = YES;
            CGFloat progress = 1.0 * receivedSize/expectedSize;
            if (progress <= 0) {
                progress = 0.0;
            }
            self.progressView.progress = progress;
            self.progressView.roundedCorners = 5;
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.0f%%",progress*100];
            
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.hidden = YES;
            self.progressView.roundedCorners = 0;
            if ([XMGMusicManager shareManager].rate == 1 && [self.currentModel.voiceurl isEqualToString:[XMGMusicManager shareManager].currentUrl]) {
                self.iconListenButton.hidden = YES;
            }else {
                self.iconListenButton.hidden = NO;
            }
        });
    }];
}
- (void)dealloc {
    
    [self.finishDispable dispose];
    [self.rateDispable dispose];
}

@end
