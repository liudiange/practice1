//
//  UITextField+XMGTextField.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/10/23.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "UITextField+XMGTextField.h"



@implementation UITextField (XMGTextField)

NSString * const PLHOLDERCOLOR = @"placeholderLabel.textColor";

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
   
    // 解决placeholder 和 placeholderColor的位置问题
    NSString *placeHolderText = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeHolderText;
    // 设置颜色
    [self setValue:placeholderColor forKeyPath:PLHOLDERCOLOR];
    // 为nil的标示
    if (placeholderColor == nil) {
      [self setValue:[UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22] forKeyPath:PLHOLDERCOLOR];
    }
   

}
- (UIColor *)placeholderColor {
    
   return [self valueForKeyPath:PLHOLDERCOLOR];
}

@end
