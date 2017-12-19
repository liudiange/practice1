//
//  XMGSelectAssetController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGSelectAssetController.h"
#import "XMGImageCollectionViewCell.h"
#import "XMGImageManager.h"
#import "XMGSelectViewController.h"
#import "XMGPhotoWatchViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>



@interface XMGSelectAssetController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/** collection的*/
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** 数据array*/
@property (nonatomic, strong) NSMutableArray *dataArray;
/** collection*/
@property (nonatomic, strong) PHAssetCollection *collection;
/** 显示数量*/
@property (weak, nonatomic) IBOutlet UILabel *countLable;
/** consatton*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLableConstaton;

@end

@implementation XMGSelectAssetController
static NSString *Image_cell = @"imageCell";

/**
 *
 *   创建控制器
 */
-(instancetype)initWithCollection:(PHAssetCollection *)collection {
    if (self = [super init]) {
        self.collection = collection;
    }
    return self;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //  创建collectionview
    [self setUpCollection];
    //  晴空数据
    [self clearData];
    //  开始组装数据
    [self getData];
    //  添加通知
    [self addNotification];
}
- (void)clearData {
    
    [[XMGImageManager shareManager].smallImageArray removeAllObjects];
    [[XMGImageManager shareManager].bigImageArray removeAllObjects];
    
}

/**
 *
 *  确定图片的按钮
 */
- (IBAction)sureButtonAction {
    [[NSNotificationCenter defaultCenter] postNotificationName:SureImage object:nil];
    NSArray *controllerArray = self.navigationController.viewControllers;
    XMGSelectViewController *selectVc = nil;
    for (UIViewController *controllerVc  in controllerArray) {
        if ([controllerVc isKindOfClass:[XMGSelectViewController class]]) {
            selectVc = (XMGSelectViewController *)controllerVc;
        }
    }
    if (selectVc) {
        [self.navigationController popToViewController:selectVc animated:YES];
    }
}
/**
 *
 *  添加通知
 */
- (void)addNotification {
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:ImageLableCount object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([XMGImageManager shareManager].smallImageArray.count) {
                self.bottomLableConstaton.constant = 0;
                self.countLable.text = [NSString stringWithFormat:@"已经选中:%zd",[XMGImageManager shareManager].smallImageArray.count];
            }else {
                self.bottomLableConstaton.constant = -20;
            }
        });
    }];
}
/**
 *
 *  开始组装数据
 */
- (void)getData {
    [SVProgressHUD showWithStatus:@"正在加载中----"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.isAccessibilityElement = YES;
        PHFetchResult<PHAsset *> *assetArray = [PHAsset fetchAssetsInAssetCollection:self.collection options:options];
        PHImageRequestOptions *imageOption = [[PHImageRequestOptions alloc] init];
        imageOption.synchronous = YES;
        // 特别说明 imageOption.synchronous = YES 和 CGSizeMake(asset.pixelWidth, asset.pixelHeight) 返回的是原图
        // 特别说明 imageOption.synchronous = YES 和 CGSizeZero 返回的是缩略图
        // 特别说明 imageOption.synchronous = NO 和 CGSizeMake(asset.pixelWidth, asset.pixelHeight) 原图和缩略图都返回
        // 特别说明 imageOption.synchronous = NO 和 CGSizeZero 返回的是缩略图
        
        for (PHAsset *asset in assetArray) {
            //这个方法是同步执行的
            __block UIImage *smallImage = nil;
            __block UIImage *bigImage = nil;
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeZero contentMode:PHImageContentModeAspectFit options:imageOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                smallImage = result;
            }];
            
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(asset.pixelWidth, asset.pixelHeight) contentMode:PHImageContentModeAspectFit options:imageOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                bigImage = result;
            }];
            XMGImageModel *modle = [[XMGImageModel alloc] init];
            modle.smallImage = smallImage;
            modle.bigImage = bigImage;
            modle.isSelected = NO;
            [self.dataArray addObject:modle];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            // 刷新界面
            [self.collectionView reloadData];
        });
    });
}
/**
 *
 *  创建collectionview
 */
- (void)setUpCollection {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth/4.0, ScreenWidth/4.0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(50, 0 , 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = flowLayout;
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:Image_cell];
    
}

#pragma mark - collection - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMGImageCollectionViewCell * imageCell = [collectionView dequeueReusableCellWithReuseIdentifier:Image_cell forIndexPath:indexPath];
    imageCell.imageModel = self.dataArray[indexPath.item];
    return imageCell;
}
#pragma mark - delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMGImageModel *imageModel = self.dataArray[indexPath.item];
    XMGPhotoWatchViewController *watchVc = [[XMGPhotoWatchViewController alloc] initWithImage:imageModel.bigImage];
    [self presentViewController:watchVc animated:YES completion:nil];
}

@end
