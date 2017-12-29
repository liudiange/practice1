//
//  UIView+XMGWindow.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/29.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "UIView+XMGWindow.h"

@implementation UIView (XMGWindow)
/**
 *  与某个空间是否相交
 *
 */
- (BOOL)intersectsView:(UIView *)view {
 
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    CGRect currentRect = [self.superview convertRect:self.frame toView:nil];
    return CGRectIntersectsRect(viewRect, currentRect);
}
/**
 *
 *   当前空间是否包含别的控件
 */
- (BOOL)containView:(UIView *)view {
    
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    CGRect currentRect = [self convertRect:self.bounds toView:nil];
    return CGRectContainsRect(currentRect, viewRect);
}

@end
