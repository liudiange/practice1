//
//  UIBarButtonItem+XMGBarButtonItem.m
//  百思不得姐
//
//  Created by Connect on 2017/8/2.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "UIBarButtonItem+XMGBarButtonItem.h"

@implementation UIBarButtonItem (XMGBarButtonItem)
+ (instancetype)barButton:(id)target imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName action:(SEL)action {
    //创建左边的按钮
    UIButton* button = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImageName] forState:UIControlStateHighlighted];
    button.xmg_size = [button imageForState:UIControlStateNormal].size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
