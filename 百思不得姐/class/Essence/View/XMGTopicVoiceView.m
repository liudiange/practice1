//
//  XMGTopicVoiceView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicVoiceView.h"

@implementation XMGTopicVoiceView
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.progressView.progressTintColor = [UIColor redColor];
}
/**
 *
 *  点击按钮的事件
 */
- (IBAction)iconListenButtonAction:(UIButton *)sender {
    
    
    
}
/**
 *
 *  重写model进行付值
 */
- (void)setTopicModel:(XMGTopicModel *)topicModel {
    
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
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.2f%%",progress];
            
        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.iconListenButton.hidden = NO;
            self.progressView.hidden = YES;
            self.progressView.roundedCorners = 0;
        });
    }];
    
}


@end
