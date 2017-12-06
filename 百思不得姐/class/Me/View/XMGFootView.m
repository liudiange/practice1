//
//  XMGFootView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/10/30.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGFootView.h"
#import "XMGMeSquareButton.h"
#import "UIButton+WebCache.h"

@implementation XMGFootView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        // 设置一些基本的属性
        self.backgroundColor = [UIColor greenColor];
        
    }
    return self;
}
/**
 *
 *  加载好了调用这个方法
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonW = ScreenWidth * 0.25;
    CGFloat buttonH = buttonW;
    // 创建button
    for (NSInteger index  = 0; index < 30; index ++) {
        XMGMeSquareButton *button = [[XMGMeSquareButton alloc] init];
        button.xmg_left = index % 4 * buttonW;
        button.xmg_top = index / 4 *buttonH;
        button.xmg_width = buttonW - 1;
        button.xmg_height = buttonH - 1;
        [button sd_setImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"no_user"]];
        [button setTitle:@"哈哈" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self addSubview:button];
    }
    // 设置tabkleview的高度
    self.xmg_height =  [self.subviews lastObject].xmg_bottom;;
    UITableView *tableView =  (UITableView *)self.superview;
    tableView.tableFooterView = self;
    [tableView reloadData];
}


@end
