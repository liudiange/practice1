//
//  XMGAllViewController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/10.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGAllViewController.h"

@interface XMGAllViewController ()


@end

@implementation XMGAllViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotificaTion];
}
/**
 *
 *  监听通知
 */
- (void)addNotificaTion {
    @weakify(self);
    //  刷新界面
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:VoiceRefresh object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

/**
 *
 *  返回所有的类型
 */
-(TopicType)type {
    return TopicTypeAll;
}
@end
