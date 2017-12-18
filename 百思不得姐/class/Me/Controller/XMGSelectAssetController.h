//
//  XMGSelectAssetController.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface XMGSelectAssetController : UIViewController
/**
 *
 *   创建控制器
 */
-(instancetype)initWithCollection:(PHAssetCollection *)collection;

@end
