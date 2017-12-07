//
//  XMGTopicVoiceView.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicBaseView.h"
#import "DALabeledCircularProgressView.h"


@interface XMGTopicVoiceView : XMGTopicBaseView
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *iconListenButton;
@property (weak, nonatomic) IBOutlet UILabel *rightTopLable;
@property (weak, nonatomic) IBOutlet UILabel *rightBottomLable;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;






@end
