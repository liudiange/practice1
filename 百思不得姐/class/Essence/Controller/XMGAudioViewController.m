//
//  XMGTopicTableController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/10.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGAudioViewController.h"
#import "XMGTopicModel.h"



@interface XMGAudioViewController ()

@property (strong, nonatomic) XMGTopicModel *curModel;

@end

@implementation XMGAudioViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 监听通知
    [self addNotificaion];
    
}
#pragma mark - 方法的响应
/**
 *
 *  进行付值
 */
- (TopicType)type {
    return TopicTypeVoice;
}
/**
 *
 *  监听通知
 */
- (void)addNotificaion {
    @weakify(self);
    //  刷新界面
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:VoiceRefreshFinish object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}
@end


