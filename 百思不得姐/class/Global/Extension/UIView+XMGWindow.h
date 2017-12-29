//
//  UIView+XMGWindow.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/29.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XMGWindow)

/**
 *  与某个空间是否相交
 *
 */
- (BOOL)intersectsView:(UIView *)view;
/**
 *
 *   当前空间是否包含别的控件
 */
- (BOOL)containView:(UIView *)view;

@end
