//
//  XMGSelectViewController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGSelectViewController.h"
#import "XMGSelectCollectionController.h"
#import <Photos/Photos.h>
#import "XMGImageManager.h"

@interface XMGSelectViewController ()
/** 显示的imageview*/
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;
/** 数据开始*/
@property (nonatomic, strong) NSMutableArray <PHAssetCollection *>*dataArray;

@end

@implementation XMGSelectViewController
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加通知
    [self addNotification];
}
/**
 *
 *  添加通知
 */
- (void)addNotification {
        @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:SureImage object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
           self.displayImageView.image = [[XMGImageManager shareManager].imageArray firstObject];
        });
        
    }];
}
/**
 *
 *  选择图片的相关的按钮点击事件
 */
- (IBAction)selectImageAction {
    
    [self.dataArray removeAllObjects];
    // 获取自定义的相簿
    PHFetchResult<PHAssetCollection *> *customResults = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in customResults) {
        [self.dataArray addObject:collection];
    }
    // 获取系统的相簿
    PHAssetCollection  *systemCollection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self.dataArray addObject:systemCollection];
    //  创建相簿
    XMGSelectCollectionController *selectVc = [[XMGSelectCollectionController alloc] initWithData:self.dataArray];
    [self.navigationController pushViewController:selectVc animated:YES];
}



@end
