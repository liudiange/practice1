//
//  XMGEssenceViewController.m
//  百思不得姐
//
//  Created by Connect on 2017/7/24.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGTitleButton.h"
#import "XMGAllViewController.h"
#import "XMGWordViewController.h"
#import "XMGAudioViewController.h"
#import "XMGVideoViewController.h"
#import "XMGPictureViewController.h"
#import "XMGsubscribeController.h"


@interface XMGEssenceViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) XMGTitleButton *currrentTitleButton;
@property (nonatomic, strong) UIView *indictorView;
@property (nonatomic, strong) UIScrollView *bottomScrollerView;
@property (nonatomic, strong) UIView *titleView;

@end
@implementation XMGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XMG_BACKGROUND_COLOR;
    [self setUpNav];
    [self setChildViewController];
    [self setBottomScrollerView];
    [self setTitleScrollerView];
    
}
#pragma mark - 方法的响应
/**
 *
 *  初始化底部的scrolllerview
 */
- (void)setBottomScrollerView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *bottomScrollerView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    bottomScrollerView.backgroundColor = XMG_BACKGROUND_COLOR;
    [self.view addSubview:bottomScrollerView];
    bottomScrollerView.delegate = self;
    self.bottomScrollerView = bottomScrollerView;
    
    
    NSInteger childCount = self.childViewControllers.count;
    bottomScrollerView.contentSize = CGSizeMake(bottomScrollerView.xmg_width * childCount, 0);
    bottomScrollerView.showsVerticalScrollIndicator = NO;
    bottomScrollerView.showsHorizontalScrollIndicator = NO;
    bottomScrollerView.pagingEnabled = YES;
    
}
/**
 *
 *  设置子控制器
 */
- (void)setChildViewController {
   
    XMGAllViewController *allVc = [[XMGAllViewController alloc] init];
    [self addChildViewController:allVc];
    
    XMGVideoViewController *videoVc = [[XMGVideoViewController alloc] init];
    [self addChildViewController:videoVc];
    
    XMGAudioViewController *audioVc = [[XMGAudioViewController alloc] init];
    [self addChildViewController:audioVc];
    
    XMGPictureViewController *pictureVc = [[XMGPictureViewController alloc] init];
    [self addChildViewController:pictureVc];
    
    XMGWordViewController *wordVc = [[XMGWordViewController alloc] init];
    [self addChildViewController:wordVc];
   
    
}
/**
 *  头部的scrollerview
 *
 */
- (void)setTitleScrollerView {
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 35)];
    titleView.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 创建button
    NSArray *titleArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titleArray.count;
    CGFloat titleButtonW = ScreenWidth/5;
    CGFloat titleButtonH = titleView.xmg_height;
    for (NSInteger index = 0; index < count; index ++) {
        XMGTitleButton *button = [XMGTitleButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.tag = index;
        button.frame = CGRectMake(index *titleButtonW, 0, titleButtonW, titleButtonH);
        [titleView addSubview:button];
        [button addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 创建指示view
    UIView *indicatorView = [[UIView alloc] init];
    XMGTitleButton *button = [titleView.subviews firstObject];
    indicatorView.backgroundColor = [button titleColorForState:UIControlStateSelected];
    indicatorView.xmg_height = 1;
    indicatorView.xmg_top = titleView.xmg_height - indicatorView.xmg_height;
    [titleView addSubview:indicatorView];
    self.indictorView = indicatorView;
    // 第一次默认选中
    [button.titleLabel sizeToFit];
    self.indictorView.xmg_width = button.titleLabel.xmg_width;
    self.indictorView.xmg_centerX = button.xmg_centerX;
    [self buttonClickAction:button];
    // 默认全部有值
    [self setCreatChildVc];
    
}
/**
 *
 *  初始化nav
 */
- (void)setUpNav {
    //创建标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1百思不得姐1_146x146_@1x"]];
    //创建左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButton:self imageName:@"点击马赛克_27x27_" selectImageName:@"点击马赛克_27x27_" action:@selector(buttonAction)];
}
/**
 按钮的点击事件
 @param button button的点击事件
 */
- (void)buttonClickAction:(XMGTitleButton *)button {
    
    if (self.currrentTitleButton == button) {
        [[NSNotificationCenter defaultCenter] postNotificationName:RepeatClickNotification object:nil];
    }
    //  button选中的样式
    self.currrentTitleButton.selected = NO;
    button.selected = YES;
    self.currrentTitleButton = button;
    //  指示器的选中
    [UIView animateWithDuration:0.25 animations:^{
        self.indictorView.xmg_width = button.titleLabel.xmg_width;
        self.indictorView.xmg_centerX = button.xmg_centerX;
    }];
    NSUInteger index = button.tag;
    CGPoint point = self.bottomScrollerView.contentOffset;
    point.x = index * self.bottomScrollerView.xmg_width;
    [self.bottomScrollerView setContentOffset:point animated:YES];
    
}
/**
 *
 *  左上角按钮的点击
 */
- (void)buttonAction {
    XMGsubscribeController *subscribeVc = [[XMGsubscribeController alloc] init];
    [self.navigationController pushViewController:subscribeVc animated:YES];
}
/**
 *
 *  创建view
 */
- (void)setCreatChildVc {
    
    NSUInteger index = self.bottomScrollerView.contentOffset.x/self.bottomScrollerView.xmg_width;
    UIViewController *childVc = self.childViewControllers[index];
    // 方法之一
//    if ([childVc.view window]) {
//        return;
//    }
    //  方法之二
//    if ([childVc.view superview]) {
//        return;
//    }
    // 方法三
    if ([childVc viewIfLoaded]) {
        return;
    }
    childVc.view.frame = self.bottomScrollerView.bounds;
    [self.bottomScrollerView addSubview:childVc.view];

}
#pragma mark - delegate
/**
 *
 *  手动滑动结束的停止的方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 设置button选中
    NSInteger index = scrollView.contentOffset.x/scrollView.xmg_width;
    XMGTitleButton *titleButton = (XMGTitleButton *)self.titleView.subviews[index];
    [self buttonClickAction:titleButton];
    [self setCreatChildVc];
    
}
/**
 *
 *  代码设置执行动画的时候才会调用
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self setCreatChildVc];
    
}

@end
