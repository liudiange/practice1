//
//  UIImageView+XMGCategory.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/18.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface UIImageView (XMGCategory)
/**
 *
 *   根据url来进行获取图片
 */
- (void)xmg_setHeaderWithUrl:(NSString *)headerUrl withPlaceHolder:(NSString *)placeHolderName;
/**
 *
 *  设置圆形的头像
 */
- (void)xmg_setCircleHeader:(NSString *)headerUrl withPlaceHolder:(NSString *)placeHolderName;
/**
 *
 *  设置方形的header
 */
- (void)xmg_setSquareHeader:(NSString *)headerUrl withPlaceHolder:(NSString *)placeHolderName;



@end
