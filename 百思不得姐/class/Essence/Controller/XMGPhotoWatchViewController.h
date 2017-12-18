//
//  XMGPhotoWatchViewController.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/13.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGPhotoWatchViewController : UIViewController

/**
 *
 *   创建控制器
 */
- (instancetype)initWithDownloadUrl:(NSString *)downloadUrl;
/**
 *
 *   通过image来进行创建
 */
- (instancetype)initWithImage:(UIImage *)image;

@end
