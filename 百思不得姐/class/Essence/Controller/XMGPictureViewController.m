//
//  XMGPictureViewController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/10.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGPictureViewController.h"

@interface XMGPictureViewController ()

@end

@implementation XMGPictureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Cell_ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cell_ID];
    }
    cell.backgroundColor = XMG_RANDM_COLOR;
    cell.textLabel.text = [NSString stringWithFormat:@"%@---%zd",[self class],indexPath.row];
    return cell;
}

@end
