//
//  XMGSelectCollectionController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGSelectCollectionController.h"
#import "XMGSelectAssetController.h"

@interface XMGSelectCollectionController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 数据开始*/
@property (nonatomic, strong) NSMutableArray <PHAssetCollection *>*dataArray;

@end

@implementation XMGSelectCollectionController
static NSString *cell_id = @"cell";
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
/**
 *
 *   获得数组
 */
-(instancetype)initWithData:(NSMutableArray *)dataArray {
    if (self == [super init]) {
        self.dataArray = dataArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = 100;

}
#pragma mark - tableview 的 datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PHAssetCollection *collection = self.dataArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = collection.localizedTitle;
    return cell;
}
#pragma mark - delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PHAssetCollection *collection = self.dataArray[indexPath.row];
    XMGSelectAssetController *assetController = [[XMGSelectAssetController alloc] initWithCollection:collection];
    [self.navigationController pushViewController:assetController animated:YES];
}

@end
