//
//  XMGBaseButton.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/8/30.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGBaseButton.h"

@implementation XMGBaseButton

-(void)awakeFromNib {
    [super awakeFromNib];
    // 位置居中显示
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置图片
    self.imageView.xmg_top = 0;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    // 设置文字
    self.titleLabel.xmg_left = 0;
    self.titleLabel.xmg_width = self.xmg_width;
    self.titleLabel.xmg_top = self.imageView.xmg_height;
    self.titleLabel.xmg_height = self.xmg_height - self.imageView.xmg_height;
    
    
    
 
}
@end
