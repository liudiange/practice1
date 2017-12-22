//
//  XMGCommentCell.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/21.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGCommentCell.h"
@interface XMGCommentCell ()

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLable;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentLable;

@end
@implementation XMGCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.voiceButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    self.voiceButton.titleEdgeInsets = UIEdgeInsetsMake(0, -75, 0, 0);
    self.commentLable.numberOfLines = 0;

}
/**
 *
 *  重写model
 */
- (void)setCommentModel:(XMGCommentModel *)commentModel {
    _commentModel = commentModel;
    // 头像
    [self.headerImageView xmg_setCircleHeader:commentModel.user.profile_image withPlaceHolder:@"bdj_mj_refresh_1"];
    // 性别
    self.userNameLable.text = [NSString stringWithFormat:@"%@:%@",commentModel.user.sex,commentModel.user.username];
    // 下边的内容
    if (!NSStringIsNull(commentModel.voiceuri)) {
        self.voiceButton.hidden = NO;
        self.commentLable.text = nil;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''",commentModel.voicetime] forState:UIControlStateNormal];
    }else {
        self.voiceButton.hidden = YES;
        self.commentLable.text = commentModel.content;
    }
    // 点赞数
    [self.zanButton setTitle:[NSString stringWithFormat:@"%zd",commentModel.like_count] forState:UIControlStateNormal];
}
-(void)setFrame:(CGRect)frame {
    
    frame.size.height -= 2;
    [super setFrame:frame];

}
@end
