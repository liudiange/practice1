//
//  UIBarButtonItem+XMGBarButtonItem.h
//  百思不得姐
//
//  Created by Connect on 2017/8/2.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XMGBarButtonItem)

+ (instancetype)barButton:(id)target imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName action:(SEL)action;
@end
