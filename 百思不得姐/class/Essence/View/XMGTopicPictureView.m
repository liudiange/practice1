//
//  XMGTopicPictureView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicPictureView.h"



@implementation XMGTopicPictureView
/**
 *
 *  点击查看大图
 */
- (IBAction)changeBigAction {
    
    
}
/**
 *
 *  重写model进行付值
 */
- (void)setTopicModel:(XMGTopicModel *)topicModel {
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.cdn_img] placeholderImage:[UIImage imageNamed:@"bdj_mj_refresh_3"]];
    int numValue = [topicModel.is_gif intValue];
    if (numValue) {
        self.gifImageView.hidden = NO;
    }else {
        self.gifImageView.hidden = YES;
    }
}


@end
