//
//  XMGBaseLoginTextfield.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/10/10.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGBaseLoginTextfield.h"
#import <objc/message.h>

@interface XMGBaseLoginTextfield ()<UITextFieldDelegate>

@property (nonatomic, strong) id observer;

@end

@implementation XMGBaseLoginTextfield

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tintColor = [UIColor grayColor];
    
    //设置ploahoder的相关的属性
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor greenColor];
//    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:dic];
//    self.attributedPlaceholder = attrString;
    
//    unsigned int count;
//    Ivar *listArray = class_copyIvarList([UITextField class], &count);
//    for (int index = 0; index < count; index ++) {
//        Ivar iva = listArray[index];
//        NSLog(@"%s",ivar_getName(iva));
//    }
//    free(listArray);
//   // 设置代理的方法
//    self.delegate = self;
//    // 添加通知的方法
//    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:UITextFieldTextDidBeginEditingNotification object:self queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//        
//    }];
    // add target的方法
//    [self addTarget:self action:@selector(becomeEditAction) forControlEvents:UIControlEventEditingDidBegin];
    
}
#pragma mark - delegate
/**
 *
 *  开始编辑
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {


}
/**
 *
 *  结束编辑
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {


}
/**
 *
 *  开始编辑
 */
- (void)becomeEditAction {

}

///**
// *
// *  这个方法 也可以 二者择其一
// */
//- (void)drawPlaceholderInRect:(CGRect)rect {
//    
//    CGRect placeholdRect = CGRectMake(10, 0, rect.size.width, self.font.lineHeight);
//    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
//    dic[NSForegroundColorAttributeName] = [UIColor greenColor];
//    dic[NSFontAttributeName] = [UIFont systemFontOfSize:14.0];
//    
//    [self.placeholder drawInRect:placeholdRect withAttributes:dic];
//
//}
/**
 *
 *  这也是一种方法，重写苹果的方法
 */
- (BOOL)becomeFirstResponder {
    self.placeholderColor = [UIColor greenColor];
    return [super becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    
    self.placeholderColor = [UIColor grayColor];
   return [super resignFirstResponder];
}
- (void)dealloc {
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}
@end
