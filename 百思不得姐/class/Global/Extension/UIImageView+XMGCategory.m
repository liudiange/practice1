//
//  UIImageView+XMGCategory.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/18.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "UIImageView+XMGCategory.h"
@implementation UIImageView (XMGCategory)
/**
 *
 *   根据url来进行获取图片
 */
- (void)xmg_setHeaderWithUrl:(NSString *)headerUrl withPlaceHolder:(NSString *)placeHolderName{ //bdj_mj_refresh_1
    [self xmg_setCircleHeader:headerUrl withPlaceHolder:placeHolderName];
}
/**
 *
 *  设置圆形的头像
 */
- (void)xmg_setCircleHeader:(NSString *)headerUrl withPlaceHolder:(NSString *)placeHolderName {
    @weakify(self);
    UIImage *placeHoldImage = [UIImage xmg_circleName:placeHolderName];
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:placeHoldImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image) {
                self.image = [image xmg_CircleImage];
            }
        });
    }];
}
/**
 *
 *  设置方形的header
 */
- (void)xmg_setSquareHeader:(NSString *)headerUrl withPlaceHolder:(NSString *)placeHolderName {
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:placeHolderName]];
}

@end
