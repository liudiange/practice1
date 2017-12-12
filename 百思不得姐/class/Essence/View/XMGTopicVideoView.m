//
//  XMGTopicVideoView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicVideoView.h"

@interface XMGTopicVideoView ()

@property (strong, nonatomic) XMGTopicModel * currentModel;

@end

@implementation XMGTopicVideoView
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.progressLabel.font = [UIFont systemFontOfSize:12.0];
}
/**
 *
 *  播放的按钮点击事件
 */
- (IBAction)iconPlayeButtonAction {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:VideoPlay object:self.currentModel];
}
/**
 *
 *  重写model进行付值
 */
- (void)setTopicModel:(XMGTopicModel *)topicModel {
    
    self.rightToplable.text = [NSString stringWithFormat:@"%zd播放",topicModel.playcount];
    NSInteger minute = topicModel.videotime / 60;
    NSInteger second = topicModel.videotime % 60;
    // 其中2： 代表占几位 0： 表示不足的用0来代替
    self.rightBottomLable.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.small_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.hidden = NO;
            self.iconPlayButton.hidden = YES;
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
            self.iconPlayButton.hidden = NO;
            self.progressView.hidden = YES;
            self.progressView.roundedCorners = 0;
        });
    }];
    self.currentModel = topicModel;
}
@end
