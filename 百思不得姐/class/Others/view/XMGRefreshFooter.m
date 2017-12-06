//
//  XMGRefreshFooter.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/20.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGRefreshFooter.h"

@implementation XMGRefreshFooter

- (void)prepare {
    [super prepare];
    
//    self.stateLabel.textColor = [UIColor redColor];
//    // 设置什么位置开始加载数据
//    self.triggerAutomaticallyRefreshPercent = 10;
//    // 手动点击才开始加载
//    self.automaticallyRefresh = NO;
    // 隐藏加载的文字
//    self.stateLabel.hidden = YES;
 
    // 自定义文字
    [self setTitle:@"哈哈哈" forState:MJRefreshStateIdle];
    [self setTitle:@"正在刷新中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"你管的着吗" forState:MJRefreshStatePulling];
//    // 自定义的图片
//    UIImage *image = [UIImage imageNamed:@"activities_black"];
//    UIImage *image1 = [UIImage imageNamed:@"activities_white"];
//    UIImage *image2 = [UIImage imageNamed:@"animals_black"];
//    UIImage *image3 = [UIImage imageNamed:@"animals_white"];
//    UIImage *image4 = [UIImage imageNamed:@"emotion_black"];
//
//    NSArray *imageArray = @[image,image1,image2,image3,image4];
//
//    [self setImages:imageArray forState:MJRefreshStateIdle];
//    [self setImages:imageArray forState:MJRefreshStatePulling];
//    [self setImages:imageArray forState:MJRefreshStateRefreshing];

    self.stateLabel.font = [UIFont systemFontOfSize:20.0];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [self addSubview:button];
    
}
@end
