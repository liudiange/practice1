//
//  XMGTopicPictureView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "HZImagesGroupView.h"
#import "HZPhotoItemModel.h"
#import "HZPhotoBrowser.h"
#import "XMGPhotoWatchViewController.h"


@interface XMGTopicPictureView ()<HZPhotoBrowserDelegate>

/** 组*/
@property (strong, nonatomic)HZImagesGroupView *groupImageView;
@property (nonatomic, strong) NSMutableArray *photoItemArray;
@property (nonatomic, strong) XMGTopicModel *currentModel;

@end

@implementation XMGTopicPictureView

- (NSMutableArray *)photoItemArray {
    if (!_photoItemArray) {
        _photoItemArray = [NSMutableArray array];
    }
    return _photoItemArray;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.progressView.progressTintColor = [UIColor redColor];
    self.progressView.progressLabel.font = [UIFont systemFontOfSize:12.0];
}
/**
 *
 *  点击查看大图
 */
- (IBAction)changeBigAction {
    //启动图片浏览器
//    HZPhotoBrowser *browserVc = [[HZPhotoBrowser alloc] init];
//    browserVc.sourceImagesContainerView = self; // 原图的父控件
//    browserVc.imageCount = self.photoItemArray.count; // 图片总数
//    browserVc.currentImageIndex = 0;
//    browserVc.delegate = self;
//    [browserVc show];
    
    XMGPhotoWatchViewController *photoWatchVc = [[XMGPhotoWatchViewController alloc] initWithDownloadUrl:self.currentModel.large_image];
    [[self getCurrentVC] presentViewController:photoWatchVc animated:NO completion:nil];
    
}
/**
 *
 *  重写model进行付值
 */
- (void)setTopicModel:(XMGTopicModel *)topicModel {
    self.currentModel = topicModel;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.small_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.changeBigButton.hidden = YES;
            CGFloat progress = 1.0 * receivedSize/expectedSize;
            if (progress <= 0) {
                progress = 0.0;
            }
            self.progressView.progress = progress;
            self.progressView.hidden = NO;
            self.progressView.roundedCorners = 5;
            self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.0f%%",progress*100];

        });
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.progressView.hidden = YES;
            self.progressView.roundedCorners = 0;
            self.changeBigButton.hidden = NO;
            //self.changeBigButton.hidden = !topicModel.is_largeImage;
        });
    }];
    self.gifImageView.hidden = !topicModel.is_gif;
    if (topicModel.is_largeImage) {
       self.backImageView.contentMode = UIViewContentModeTop;
       self.backImageView.clipsToBounds = YES;
    }else {
       self.backImageView.contentMode = UIViewContentModeScaleToFill;
       self.backImageView.clipsToBounds = NO;
    }
    // 创建组
//    HZPhotoItemModel *itemModel = [[HZPhotoItemModel alloc] init];
//    itemModel.thumbnail_pic = topicModel.large_image;
//    [self.photoItemArray removeAllObjects];
//    [self.photoItemArray addObject:itemModel];
}
#pragma mark - photobrowser代理方法
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return self.backImageView.image;
}

- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [[self.photoItemArray[index] thumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    return [NSURL URLWithString:urlStr];
}
@end
