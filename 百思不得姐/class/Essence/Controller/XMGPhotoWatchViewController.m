//
//  XMGPhotoWatchViewController.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/13.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGPhotoWatchViewController.h"
#import "DALabeledCircularProgressView.h"
#import <Photos/Photos.h>

@interface XMGPhotoWatchViewController ()

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) UIImage *downloadImage;
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (nonatomic, copy) NSString *downloadUrl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstaton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstaton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstaton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollerView;


@end

@implementation XMGPhotoWatchViewController
static NSString *collectionTitle = @"百思不得姐的相簿";
/**
 *
 *   创建控制器
 */
- (instancetype)initWithDownloadUrl:(NSString *)downloadUrl {
    if (self == [super init]) {
        self.downloadUrl = downloadUrl;
    }
    return self;
}
/**
 *
 *   通过image来进行创建
 */
- (instancetype)initWithImage:(UIImage *)image {
    if (self == [super init]) {
        self.downloadImage = image;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.progressView.progressLabel.textColor = [UIColor redColor];
    self.progressView.progressTintColor = [UIColor greenColor];
    self.progressView.progressLabel.font = [UIFont systemFontOfSize:12.0];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!NSStringIsNull(self.downloadUrl)) {
        // 开始下载图片
        @weakify(self);
        [self.displayImageView sd_setImageWithURL:[NSURL URLWithString:self.downloadUrl] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            @strongify(self);
            CGFloat progress = 1.0 * receivedSize/expectedSize;
            if (progress <= 0) {
                progress = 0.0;
            }
            self.progressView.progress = progress;
            self.progressView.hidden = NO;
            self.progressView.roundedCorners = 5;
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.0f%%",progress*100];
        } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            @strongify(self);
            self.downloadImage = image;
            [self updateImageSize];
        }];
    }else if (self.downloadImage){
         [self updateImageSize];
    }
}
- (void)updateImageSize {
    self.progressView.hidden = YES;
    self.progressView.roundedCorners = 0;
    if (self.downloadImage) {
        self.saveButton.enabled = YES;
    }
    // 获得图片的宽和高的比例
    CGFloat scale = 1.0*self.downloadImage.size.height/self.downloadImage.size.width;
    CGFloat getHeight = ScreenWidth * scale;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.heightConstaton.constant = getHeight;
        if (getHeight > ScreenHeight) {
            self.bottomConstaton.constant = 0;
            self.scrollerView.contentSize = CGSizeMake(0, getHeight);
        }else {
            self.bottomConstaton.constant = (ScreenHeight - getHeight)/2.0;
            self.topConstaton.constant = (ScreenHeight - getHeight)/2.0;
        }
    });
    self.displayImageView.image = self.downloadImage;
}
/**
 *
 *  返回的事件
 */
- (IBAction)backAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
/**
 *
 *   保存的事件
 */
- (IBAction)saveAction {
   
    // 请求全新
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        // 先判断是否可以授权
        switch (status) {
            case PHAuthorizationStatusNotDetermined:
            {
                XMGLOG(@"用户还没有开始做出选择");
            }
                break;
            case PHAuthorizationStatusAuthorized:
            {
                XMGLOG(@"用户授权了");
                [self saveImage];
            }
                break;
                
            default:
            {
                XMGLOG(@"用户不允许");
            }
                break;
        }
    }];
}
/**
 *
 *   保存图片到自定义的相册
 */
- (void)saveImage {
    
    __block NSString *assetIdentifier = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        // 1.将图片保存到相簿
        assetIdentifier = [PHAssetCreationRequest creationRequestForAssetFromImage:self.downloadImage].placeholderForCreatedAsset.localIdentifier;
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                // 3. 将相片保存到自定义的相薄
                PHAssetCollection *collection = [self getCollection];
                PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetIdentifier] options:nil].lastObject;
                PHAssetCollectionChangeRequest *requestCollection = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
                // 添加进自定义的相册
                [requestCollection addAssets:@[asset]];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    XMGLOG(@"保存相册成功了 哈哈哈");
                }
            }];
        }
    }];
}
/**
 *
 *  获取相薄
 */
- (PHAssetCollection *)getCollection {
    
    // 获取原来存在的collection
     __block NSString *collectionIdentifier = nil;
    PHFetchResult<PHAssetCollection *> *results =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *getCollection in results) {
        if ([getCollection.localizedTitle isEqualToString:collectionTitle]) {
            return getCollection;
        }
    }
   // 创建原来的collection 这个方法是同步执行的
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
          collectionIdentifier =  [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:collectionTitle].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
     return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionIdentifier] options:nil].lastObject;
}
@end
