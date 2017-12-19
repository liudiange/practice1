//
//  UIImage+XMGCategory.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/18.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XMGCategory)

/**
 * 讲一个图片变成圆的图片
 *
 */
-(instancetype)xmg_CircleImage;
/**
 *
 *   根据图片的名字来进行将图片切成圆形
 */
+ (instancetype)xmg_circleName:(NSString *)name;


@end
