//
//  TRAQuestionPlaceholderLable.h
//  TrainingAssistantIOS
//
//  Created by 刘殿阁 on 2018/1/10.
//  Copyright © 2018年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>

@interface TRAQuestionPlaceholderLable : UILabel
/**
 *
 *    创建placeholdText
 */
- (instancetype)initWithPlaceHolderColor:(UIColor *)placeColor fontNumber:(CGFloat )fontNumber placeHoldText:(NSString *)placeHolderText;
@end
