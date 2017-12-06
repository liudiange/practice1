//
//  XMGMeSquareButton.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/10/30.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGMeSquareButton.h"

@implementation XMGMeSquareButton
-(instancetype)initWithFrame:(CGRect)frame {
    if(self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:20.0];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.xmg_top = self.xmg_width * 0.15;
    self.imageView.xmg_width = self.xmg_width * 0.5;
    self.imageView.xmg_height = self.imageView.xmg_width;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    
    self.titleLabel.xmg_left = 0;
    self.titleLabel.xmg_width = self.xmg_width;
    self.titleLabel.xmg_top = self.imageView.xmg_bottom;
    self.titleLabel.xmg_height = self.titleLabel.font.lineHeight;
    
}


@end
