//
//  XMGSetViewController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/8/9.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGSetViewController.h"
#import "XMGSetClearCell.h"


@interface XMGSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) RACDisposable *dispose;
@end

@implementation XMGSetViewController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self == [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XMG_BACKGROUND_COLOR;
    self.navigationItem.title = @"设置";
    self.tableView.delegate = self;
    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
   
}
#pragma mark - tableview 的 - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_id = @"setting";
    XMGSetClearCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[XMGSetClearCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView *)cell.accessoryView;
        [indicatorView startAnimating];
    }
    return cell;
}
- (void)dealloc {
    
    [self.dispose dispose];
}
@end
