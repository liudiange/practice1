//
//  XMGMeViewController.m
//  百思不得姐
//
//  Created by Connect on 2017/8/2.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGMeViewController.h"
#import "XMGSetViewController.h"
#import "XMGMeCell.h"
#import "XMGFootView.h"

@interface XMGMeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation XMGMeViewController

- (instancetype)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建tablevewi
    [self setUpTableView];
    // 创建导航信息
    [self setupNav];
   
}
/**
 *
 *  创建tableview
 */
- (void)setUpTableView {

    self.tableView.backgroundColor = XMG_BACKGROUND_COLOR;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = MarGen;
    self.tableView.contentInset = UIEdgeInsetsMake(MarGen - 35, 0, 00, 0);
    XMGFootView *footView = [[XMGFootView alloc] init];
    self.tableView.tableFooterView = footView;
}
/**
 *
 *  创建导航信息
 */
- (void)setupNav {
    self.navigationItem.title = @"我的";
    // 设置右标题
    UIBarButtonItem *rightBarButtom = [UIBarButtonItem barButton:self imageName:@"setting_24x24_" selectImageName:@"setting_24x24_" action:@selector(setAction:)];
    UIBarButtonItem *leftBarButtom = [UIBarButtonItem barButton:self imageName:@"spa_ad_gdt_logo" selectImageName:@"spa_ad_gdt_logo" action:@selector(moonAction:)];
    NSArray *array = @[rightBarButtom,leftBarButtom];
    self.navigationItem.rightBarButtonItems = array;
}
#pragma mark - action
/**
 *
 * 点击了月亮
 */
- (void)moonAction:(UIButton *)button {
    XMGLOG(@"点击了月亮");
}
/**
 *
 * 设置的事件
 */
- (void)setAction:(UIButton *)button {
    XMGSetViewController *setVc = [[XMGSetViewController alloc] init];
    [self.navigationController pushViewController:setVc animated:YES];
}
#pragma mark - datasource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_id = @"me";
    XMGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[XMGMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
        
    }
    if (indexPath.section == 0){
        cell.imageView.image = [UIImage imageNamed:@"contract_add_contacts"];
        cell.textLabel.text = @"登陆／注册";
    }else if(indexPath.section == 1){
        cell.imageView.image = nil;
        cell.textLabel.text = @"离线";
    }
    return cell;
}
@end
