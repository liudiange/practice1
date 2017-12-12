//
//  XMGTopicTableController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/10.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicTableController.h"
#import "XMGNormalHeader.h"
#import <AFNetworking/AFNetworking.h>
#import "XMGTopicModel.h"
#import "XMGRefreshFooter.h"
#import "XMGTopicCell.h"
#import "XMGSessionManager.h"
#import "XMGCommentModel.h"
#import "XMGTopicVideoController.h"

@interface XMGTopicTableController ()

@property (nonatomic,strong) UIRefreshControl *refresh;
@property (nonatomic, copy) NSString *maxTime;


@end

@implementation XMGTopicTableController
static NSString * const TOPICId = @"topic";
/**
 *
 *  懒加载
 */
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化tableveiw
    [self setUpTableView];
    //  下拉刷新
    [self setRefresh];
    //  下拉加载更多
    [self loadMore];
    // 监听通知
    [self addNotificaion];
    
}
#pragma mark - 方法的响应
/**
 *
 *  防止空实现
 */
- (TopicType)type{
    return 0;
}
/**
 *
 *  初始化tabkeivew
 */
- (void)setUpTableView {
    
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.tableView.backgroundColor = XMG_BACKGROUND_COLOR;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:TOPICId];
}
/**
 *
 *  监听通知
 */
- (void)addNotificaion {
    // 监听视频播放
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:VideoPlay object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        XMGTopicModel *model = (XMGTopicModel *)x.object;
        @strongify(self);
        [self creatOperationVc:model];
    }];
    
}
/**
 *
 *   下拉刷新
 */
- (void)setRefresh {
    XMGNormalHeader *normalHeader = [XMGNormalHeader headerWithRefreshingBlock:^{
        
        @weakify(self);
        [XMGSessionManager.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
        
        NSMutableDictionary *parma = [NSMutableDictionary dictionary];
        parma[@"a"] = @"list";
        parma[@"c"] = @"data";
        parma[@"type"] = @(self.type);
        [XMGSessionManager.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parma progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            @strongify(self);
            [responseObject writeToFile:@"/Users/liudiange/Desktop/index.plist" atomically:YES];
            self.maxTime = responseObject[@"info"][@"maxtime"];
            self.dataArray = [XMGTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            @strongify(self);
            [self.tableView.mj_header endRefreshing];
        }];
    }];
    self.tableView.mj_header = normalHeader;
    [self.tableView.mj_header beginRefreshing];
    
}
/**
 *
 *  上拉加载更多
 */
- (void)loadMore {
    XMGRefreshFooter *freshFooter = [XMGRefreshFooter footerWithRefreshingBlock:^{
        @weakify(self);
        [XMGSessionManager.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
        
        NSMutableDictionary *parma = [NSMutableDictionary dictionary];
        parma[@"a"] = @"list";
        parma[@"c"] = @"data";
        parma[@"maxtime"] = self.maxTime;
        parma[@"type"] = @(self.type);
        [XMGSessionManager.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parma progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            @strongify(self);
            self.maxTime = responseObject[@"info"][@"maxtime"];
            [self.dataArray addObjectsFromArray:[XMGTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            });
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            @strongify(self);
            [self.tableView.mj_footer endRefreshing];
        }];
    }];
    self.tableView.mj_footer = freshFooter;
}
#pragma mark - table - delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGTopicModel *model = self.dataArray[indexPath.row];
    [self creatOperationVc:model];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTopicModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XMGTopicModel *model = self.dataArray[indexPath.row];
    XMGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TOPICId];
    cell.topicModel = model;
    return cell;
}
#pragma mark - 其他事件的响应
/**
 *
 *  创建操作播放器
 */
- (void)creatOperationVc:(XMGTopicModel *)topicModel {
    switch (topicModel.type) {
        case TopicTypeVideo: // 播放视频
        {
            // 创建一个视频播放器
            [self creatVideoVc:topicModel.videourl];
        }
            break;
        case TopicTypeVoice: // 播放声音
        {

        }
            break;
            
        default:
            break;
    }
}
/**
 *
 *  创建视频播放器
 */
- (void)creatVideoVc:(NSString *)videoUrl {
    XMGTopicVideoController *videoVc = [[XMGTopicVideoController alloc] initWithUrl:videoUrl];
    [self presentViewController:videoVc animated:YES completion:nil];
}
@end

