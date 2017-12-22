//
//  XMGNormalHeader.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/16.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGNormalHeader.h"

@interface XMGNormalHeader ()

@property (weak, nonatomic) UIImageView *logoImageView;

@end

@implementation XMGNormalHeader

- (void)prepare {
    [super prepare];
    //    //  隐藏时间
    //    normalHeader.lastUpdatedTimeLabel.hidden = YES;
    //    //  隐藏状态文字
    //    normalHeader.stateLabel.hidden = YES;
    // 设置字体颜色
    [self setTitle:@"开始下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"正在刷新中" forState:MJRefreshStateRefreshing];
    [self setTitle:@"松手就可以刷新了" forState:MJRefreshStatePulling];
    [self setTitle:@"不要太过分，差不多就得了" forState:MJRefreshStateNoMoreData];
    
    self.automaticallyChangeAlpha = YES;
    self.stateLabel.font = [UIFont systemFontOfSize:30.0];
    self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:10.0];
    
    self.stateLabel.textColor = [UIColor redColor];
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.arrowView.image = [UIImage imageNamed:@"perm-settings_30x30_@1x"];
    
    // 自定义的控件
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"bottom-setting-photosClick_35x35_"];
    [self addSubview:logoImageView];
    self.logoImageView = logoImageView;
}
- (void)placeSubviews {
    [super placeSubviews];
    
    self.logoImageView.mj_y = -100;
    self.logoImageView.mj_w = ScreenWidth;
    self.logoImageView.mj_h = 100;
    
}
@end
