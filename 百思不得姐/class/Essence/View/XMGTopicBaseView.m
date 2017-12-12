//
//  XMGTopicBaseView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicBaseView.h"

@implementation XMGTopicBaseView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //  去掉自动的约束，他默认会根据父试图变化 加上这个就不会变化了
    self.autoresizingMask = UIViewAutoresizingNone;
    
    
    
}

@end
