//
//  NSObject+XMGGetCurrentController.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/14.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XMGGetCurrentController)
/**
 *
 *  获取当前的页面的控制器
 */
- (UIViewController *)getCurrentVC;
@end
