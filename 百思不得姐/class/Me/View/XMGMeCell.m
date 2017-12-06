//
//  XMGMeCell.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/10/24.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGMeCell.h"

@implementation XMGMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}
/**
 *
 *  最后调用
 */
- (void)layoutSubviews {
    // 重写父类
    [super layoutSubviews];
    if (self.imageView.image == nil) {
        return;
    }
    self.imageView.xmg_top = 5;
    self.imageView.xmg_height = self.contentView.xmg_height - self.imageView.xmg_top*2;
    
    self.textLabel.xmg_left = self.imageView.xmg_right + MarGen;
}


@end
