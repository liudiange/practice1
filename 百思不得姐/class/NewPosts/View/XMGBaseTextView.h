//
//  XMGBaseTextView.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/11.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGBaseTextView : UITextView

// 默认的文字
@property (copy, nonatomic) NSString *xmg_placeHolder;
// 默认文字的颜色
@property (copy, nonatomic) UIColor *xmg_placeHolderColor;

@end
