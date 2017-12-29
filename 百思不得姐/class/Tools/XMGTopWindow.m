//
//  XMGTopWindow.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/28.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopWindow.h"

@implementation XMGTopWindow
 UIWindow *window_;

/**
 *
 *   显示双击的状态栏
 */
+ (void)show {
    [self addClickScrollerTop];
}
/**
 *
 *  点击状态栏，tableview滚动到头部
 */
+ (void)addClickScrollerTop{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //创建_window
        window_ = [[UIWindow alloc] init];
        window_.frame = CGRectMake(0, 0, ScreenWidth, 20);
        window_.windowLevel = UIWindowLevelAlert;
        window_.backgroundColor = [UIColor redColor];
        // 直接显示了就
        window_.hidden = NO;
        //  添加点击手势
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerTap)];
        [window_ addGestureRecognizer:tapGes];
    });
}
/**
 *
 *  便利控制器，获取scrollerview 进行滚动到顶部
 */
+ (void)scrollerTap {
    
    [self getScrollerView:[UIApplication sharedApplication].keyWindow];
    
}
/**
 *
 *  获取scroller
 */
+ (void)getScrollerView:(UIView *)view {
    
    for (UIView *subView in view.subviews) {
        [self getScrollerView:subView];
    }
    if (![view isKindOfClass:[UIScrollView class]]) return;
    UIScrollView *scrollerView = (UIScrollView *)view;
    // 判断与当前的window有无交叉 ,不交叉的不用管
    // 这个要注意了，nil：默认就是【UIApplication shareApplication].keywindow;
    CGRect scrollerRect = [scrollerView convertRect:scrollerView.bounds toView:nil];
    CGRect windowRect = [UIApplication sharedApplication].keyWindow.bounds;
    if (!CGRectIntersectsRect(scrollerRect, windowRect)) return;
    // 与当前的window有交叉才 进行回到顶部
    CGPoint point = scrollerView.contentOffset;
    point.y = - scrollerView.contentInset.top;
    [scrollerView setContentOffset:point animated:YES];
}
@end
