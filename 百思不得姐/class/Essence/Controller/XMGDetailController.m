//
//  XMGDetailController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/20.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGDetailController.h"
#import "XMGTopicCell.h"
#import "XMGNormalHeader.h"
#import "XMGRefreshFooter.h"
#import "XMGCommentModel.h"
#import "XMGSessionManager.h"
#import "XMGCommentHeaderView.h"
#import "XMGCommentCell.h"
#import <MJExtension/MJExtension.h>


@interface XMGDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstaton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic, strong) XMGTopicModel *topicModel;
@property (nonatomic, strong) RACDisposable *keyBoardDisposable;
@property (nonatomic, strong) NSArray <XMGCommentModel *>*hotArray;
@property (nonatomic, strong) NSMutableArray <XMGCommentModel *>*commonArray;
@property (nonatomic, strong) XMGCommentModel *saveCommnentModel;

@end

@implementation XMGDetailController

static NSString * const topic_id = @"topic";
static NSString * const common_Cell_id = @"commonCellId";
static NSString * const headerAndFooter_id = @"headerAndFooterId";

- (NSArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSArray array];
    }
    return _hotArray;
}
- (NSMutableArray *)commonArray {
    if (!_commonArray) {
        _commonArray = [NSMutableArray array];
    }
    return _commonArray;
}
/**
 *
 *   创建model
 */
-(instancetype)initWithModel:(XMGTopicModel *)topicModel {
    if (self == [super init]) {
        self.topicModel = topicModel;
        self.saveCommnentModel = topicModel.top_cmt;
        self.topicModel.cellHeight = 0;
        self.topicModel.top_cmt = nil;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化nav
    [self setUpNav];
    // 创建tableview
    [self setUpTableView];
    // 获取数据
    [self getData];
    // 添加通知
    [self addNotification];
}
/**
 *
 *  创建nav
 */
- (void)setUpNav {
    self.navigationItem.title = @"详情";
}
/**
 *
 *  注册tableview
 */
- (void)setUpTableView {
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGTopicCell class]) bundle:nil] forCellReuseIdentifier:topic_id];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGCommentCell class]) bundle:nil] forCellReuseIdentifier:common_Cell_id];
     [self.tableView registerClass:[XMGCommentHeaderView class] forHeaderFooterViewReuseIdentifier:headerAndFooter_id];
    // 分割线去掉
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = XMG_BACKGROUND_COLOR;
    // 自动计算高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
}
/**
 *
 *  获取数据
 */
- (void)getData {
    // 下拉刷新
    self.tableView.mj_header = [XMGNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullRefreshData)];
    [self.tableView.mj_header beginRefreshing];
    // 上拉加载更多
    self.tableView.mj_footer = [XMGRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
/**
 *
 *  下拉获取新的数据
 */
- (void)pullRefreshData {
    [XMGSessionManager.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    parma[@"a"] = @"dataList";
    parma[@"c"] = @"comment";
    parma[@"data_id"] = self.topicModel.topicId;
    parma[@"hot"] = @(1);
    
        @weakify(self);
    [XMGSessionManager.manager GET:GetEssenceData parameters:parma progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        @strongify(self);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        self.hotArray = [XMGCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];        
        self.commonArray = [XMGCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        if ([responseObject[@"total"] integerValue] == (self.hotArray.count + self.commonArray.count)) {
             [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        [self.tableView.mj_header endRefreshing];
    }];
}
/**
 *
 *  上拉加载更多
 */
- (void)loadMoreData {
    [XMGSessionManager.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *parma = [NSMutableDictionary dictionary];
    parma[@"a"] = @"dataList";
    parma[@"c"] = @"comment";
    parma[@"data_id"] = self.topicModel.topicId;
    parma[@"lastcid"] = [self.commonArray lastObject].commentId;
    @weakify(self);
    [XMGSessionManager.manager GET:GetEssenceData parameters:parma progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        @strongify(self);
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        NSArray *temArray = [XMGCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (!temArray.count) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }
        [self.commonArray addObjectsFromArray:temArray];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        @strongify(self);
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (void)addNotification {
        @weakify(self);
    self.keyBoardDisposable = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillChangeFrameNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        CGRect rect = [x.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomViewConstaton.constant = rect.origin.y - ScreenHeight;
        }];
    }];
}
#pragma mark - datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.hotArray.count) {
        return 3;
    }else if (self.commonArray.count){
        return 2;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1 && self.hotArray.count) {
        return self.hotArray.count;
    }
    return self.commonArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        XMGTopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:topic_id];
        topicCell.topicModel = self.topicModel;
        return topicCell;
    }else {
        XMGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:common_Cell_id];
        if (indexPath.section == 1 && self.hotArray.count) {
            cell.commentModel = self.hotArray[indexPath.row];
        }else {
            cell.commentModel = self.commonArray[indexPath.row];
        }
        return cell;
    }
}
#pragma mark - tableview -delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.topicModel.cellHeight;
    }else {
        return self.tableView.rowHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 30;
}
/**
 *
 *  设置头部的标题
 */
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XMGCommentHeaderView *headFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerAndFooter_id];
    if (section == 0) {
    }else if (section == 1 && self.hotArray.count){
        headFootView.textLabel.text = @"最热评论";
    }else{
        headFootView.textLabel.text = @"最新的评论";
    }
    return headFootView;
//    UIButton *button = [[UIButton alloc] init];
//    [button setTitle:@"哈哈哈" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:10.0];
//    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    // 设置水平靠左
//    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    // 设置左边距
//    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//    return button;
}
- (void)dealloc {
    [self.keyBoardDisposable dispose];
    self.topicModel.top_cmt = self.saveCommnentModel;
    self.topicModel.cellHeight = 0;
}
@end
