//
//  XMGsubscribeController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/18.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGsubscribeController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "XMGSubscribeModel.h"
#import "XMGSubscribeCell.h"
#import "XMGSubscribeServer.h"

@interface XMGsubscribeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;


@end
@implementation XMGsubscribeController

static NSString *cell_id = @"subscribe";
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置setnav
    [self setNav];
    // 初始化tableview
    [self setUpTable];
    // 获取数据
    [self getData];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

/**
 *
 *  初始化导航栏
 */
- (void)setNav {
    
    self.navigationItem.title = @"订购";
}
/**
 *
 *  获取数据
 */
- (void)getData {

    [SVProgressHUD show];
     @weakify(self);
    XMGSubscribeServer *subServer = [[XMGSubscribeServer alloc] init];
    [subServer startRequest:^(NSError * _Null_unspecified error) {
        if (!error) {
            @strongify(self);
            self.dataArray = [XMGSubscribeModel mj_objectArrayWithKeyValuesArray:subServer.responDic];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [SVProgressHUD showWithStatus:@"网络数据错误了"];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     [SVProgressHUD dismiss];
                 });
             });
        }
    }];
}
/**
 *
 *   获取tableview
 */
- (void)setUpTable {
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGSubscribeCell class]) bundle:nil] forCellReuseIdentifier:cell_id];
    self.tableView.rowHeight = 60;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = XMG_BACKGROUND_COLOR;
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMGSubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    cell.subscribeModel = self.dataArray[indexPath.row];
    return cell;
}
@end
