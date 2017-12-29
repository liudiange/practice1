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
#import <MagicalRecord/MagicalRecord.h>
#import <CoreData/CoreData.h>
#import "XMGDetailController.h"
#import "UIView+XMGWindow.h"


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
    //  初始化tableveiw
    [self setUpTableView];
    //  下拉刷新
    [self setRefresh];
    //  下拉加载更多
    [self loadMore];
    //  监听通知
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
         @strongify(self);
        XMGTopicModel *model = (XMGTopicModel *)x.object;
        [self creatOperationVc:model];
    }];
    // 监听是否该在此刷新
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:RepeatClickNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
         @strongify(self);
        // 是否是window
        if (self.view.window == nil) return;
        // 判断包含
        if (![self.view intersectsView:[UIApplication sharedApplication].keyWindow]) return;
        // 刷新
        [self.tableView.mj_header beginRefreshing];
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
        [XMGSessionManager.manager GET:GetEssenceData parameters:parma progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
            @strongify(self);
            self.maxTime = responseObject[@"info"][@"maxtime"];
            self.dataArray = [XMGTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            // 缓存数据
            [self cacheData:self.dataArray.copy];
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
        if (![self isHaveMoreDataAndRefresh]) {
            NSMutableDictionary *parma = [NSMutableDictionary dictionary];
            parma[@"a"] = @"list";
            parma[@"c"] = @"data";
            parma[@"maxtime"] = self.maxTime;
            parma[@"type"] = @(self.type);
            [XMGSessionManager.manager GET:GetEssenceData parameters:parma progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
                @strongify(self);
                self.maxTime = responseObject[@"info"][@"maxtime"];
                NSArray *array = [XMGTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                [self.dataArray addObjectsFromArray:array];
                // 开始缓存数据
                [self cacheData:array];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                });
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                @strongify(self);
                [self.tableView.mj_footer endRefreshing];
            }];
        }
    }];
    self.tableView.mj_footer = freshFooter;
}
#pragma mark - table - delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGTopicModel *model = self.dataArray[indexPath.row];
    XMGDetailController *detailVc = [[XMGDetailController alloc] initWithModel:model];
    [self.navigationController pushViewController:detailVc animated:YES];
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
 *  从数据库开始获取数据 ，其中bool是证明是否有数据
 */
- (BOOL)isHaveMoreDataAndRefresh {
    // 先从数据库获取 取到直接获取 没有直接加载更多
    NSFetchRequest *request =  nil;
    if (self.type == TopicTypeAll) {
        request = [XMGDBTopicModel MR_requestAll];
    }else {
        request = [XMGDBTopicModel MR_requestAllWithPredicate:[NSPredicate predicateWithFormat:@"type = %d",(self.type)]];
    }
    request.fetchLimit = 20;
    request.fetchOffset = self.dataArray.count;
    NSArray *getDataArray = [XMGDBCommentModel MR_executeFetchRequest:request];
    // 倒序输出
   //  getDataArray = [[getDataArray reverseObjectEnumerator] allObjects];
    if (getDataArray.count) {
        for (XMGDBTopicModel *dbTopicModel in getDataArray) {
            XMGTopicModel *topicModel = [XMGGlobalTool changeDBTopicModelToTopicModel:dbTopicModel];
            [self.dataArray addObject:topicModel];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }
    return getDataArray.count;
}

/**
 *
 *  开始缓存数据
 */
- (void)cacheData:(NSArray *)cacheArray {
    // 进行保存数据
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        for (XMGTopicModel *topicModel in cacheArray) {
            XMGDBTopicModel *temDBModel = [[XMGDBTopicModel MR_findByAttribute:@"topicId" withValue:topicModel.topicId] lastObject];
            if (!temDBModel) {
                [XMGGlobalTool changeTopicModelToDBTopicModel:topicModel withContext:localContext];
            }
        }
    }completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if (!error) {
            XMGLOG(@"保存成功了");
        }else {
            XMGLOG(@"保存失败了 error --  %@",error);
        }
    }];
}
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
            //这个不在这处理了
        }
            break;
        case TopicTypePicture: // 创建图片查看器
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

