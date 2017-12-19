//
//  XMGSubscribeCell.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/18.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGSubscribeCell.h"


@interface XMGSubscribeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *subscribeCount;
@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;

@end

@implementation XMGSubscribeCell

- (void)awakeFromNib {
    [super awakeFromNib];
	
}
-(void)setSubscribeModel:(XMGSubscribeModel *)subscribeModel {
    _subscribeModel = subscribeModel;
    
    [self.headImageView xmg_setHeaderWithUrl:subscribeModel.image_list withPlaceHolder:@"bdj_mj_refresh_1"];
    self.nameLable.text = subscribeModel.theme_name;
    self.subscribeCount.text = [NSString stringWithFormat:@"已经订阅 %zd",subscribeModel.sub_number];

}
-(void)setFrame:(CGRect)frame {
    CGRect getFrame = frame;
    getFrame.size.height -= 2;
    frame = getFrame;
    [super setFrame:frame];
}
@end
