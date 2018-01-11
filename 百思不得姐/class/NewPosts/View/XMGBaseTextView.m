//
//  XMGBaseTextView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/11.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGBaseTextView.h"

@implementation XMGBaseTextView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        //配置默认的相关的属性
        self.font = [UIFont systemFontOfSize:15.0];
        self.xmg_placeHolderColor = [UIColor lightGrayColor];
        self.xmg_placeHolder = @"请输入文字";
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        //配置默认的相关的属性
        self.font = [UIFont systemFontOfSize:15.0];
        self.xmg_placeHolderColor = [UIColor lightGrayColor];
        self.xmg_placeHolder = @"请输入文字";
        // 添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeText:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    return self;
}
/**
 *
 *   观察变化
 */
- (void)changeText:(NSNotification *)info {
    [self setNeedsDisplay];
}
#pragma mark - 重写方法

/**
 *
 *   重写字体方法
 */
- (void)setFont:(UIFont *)font {
    
    [super setFont:font];
    [self setNeedsDisplay];
}
/**
 *
 *  重写placeHolder
 */
- (void)setXmg_placeHolder:(NSString *)xmg_placeHolder {
    _xmg_placeHolder = xmg_placeHolder;
    [self setNeedsDisplay];
    
}
/**
 *
 *  重写placeHolderColor
 */
- (void)setXmg_placeHolderColor:(UIColor *)xmg_placeHolderColor {
    _xmg_placeHolderColor = xmg_placeHolderColor;
     [self setNeedsDisplay];
}
/**
 *
 *   重写attributedText
 */
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
/**
 *
 *  重写draw方法
 */
- (void)drawRect:(CGRect)rect {
    
    if (self.text.length > 0) {
        return;
    }
    NSDictionary *dic = @{
                          NSFontAttributeName : self.font,
                          NSForegroundColorAttributeName :self.xmg_placeHolderColor
                          };
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2*rect.origin.x;
    [self.xmg_placeHolder drawInRect:rect withAttributes:dic];
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
 这段代码是用运行时方式书写的
 //  题目的placeHoldLabl
 TRAQuestionPlaceholderLable *topicLable = [[TRAQuestionPlaceholderLable alloc] initWithPlaceHolderColor:TRARGBColor(102, 102, 102) fontNumber:21.0 placeHoldText:@"请输入题目"];
 [self.topicTextView addSubview:topicLable];
 
 */

@end


