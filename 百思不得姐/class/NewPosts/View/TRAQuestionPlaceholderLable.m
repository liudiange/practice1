//
//  TRAQuestionPlaceholderLable.m
//  TrainingAssistantIOS
//
//  Created by 刘殿阁 on 2018/1/10.
//  Copyright © 2018年 cmcc. All rights reserved.
//

#import "TRAQuestionPlaceholderLable.h"

@implementation TRAQuestionPlaceholderLable
/**
 *
 *    创建placeholdText
 */
- (instancetype)initWithPlaceHolderColor:(UIColor *)placeColor fontNumber:(CGFloat )fontNumber placeHoldText:(NSString *)placeHolderText {
    if (self == [super init]) {
        self.numberOfLines = 0;
        self.text = placeHolderText;
        self.font = [UIFont systemFontOfSize:fontNumber];
        self.textColor =placeColor;
        [self sizeToFit];
    }
    return self;
}

@end
