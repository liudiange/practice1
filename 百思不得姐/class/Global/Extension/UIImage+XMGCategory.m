//
//  UIImage+XMGCategory.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/18.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "UIImage+XMGCategory.h"

@implementation UIImage (XMGCategory)
/**
 * 讲一个图片变成圆的图片
 *
 */
- (instancetype)xmg_CircleImage {
    
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    if (width > height) {
        width = height;
    }else {
        height = width;
    }
    // 开启上下文
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGRect rect = CGRectMake(0, 0, width, height);
     // 创建一个圆
    CGContextAddEllipseInRect(ctx, rect);
    //  裁剪
    CGContextClip(ctx);
    // 将图片添加到圆上
    [self drawInRect:rect];

    // 获得当前的图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return getImage;
}
/**
 *
 *   根据图片的名字来进行将图片切成圆形
 */
+ (instancetype)xmg_circleName:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    image = [image xmg_CircleImage];
    return image;
}

@end
