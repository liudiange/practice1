//
//  XMGCommentHeaderView.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/21.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGCommentHeaderView.h"

@implementation XMGCommentHeaderView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor redColor];
        self.textLabel.font = [UIFont systemFontOfSize:13.0];
        self.backgroundColor = XMG_BACKGROUND_COLOR;
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.textLabel.xmg_left = MarGen;
    
    
    
}

@end
