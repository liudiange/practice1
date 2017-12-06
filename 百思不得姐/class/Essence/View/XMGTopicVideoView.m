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
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.cdn_img] placeholderImage:[UIImage imageNamed:@"bdj_mj_refresh_3"]];
    self.currentModel = topicModel;
}
@end
