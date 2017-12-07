//
//  XMGTopicPictureView.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/6.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopicBaseView.h"
#import <DACircularProgress/DALabeledCircularProgressView.h>

@interface XMGTopicPictureView : XMGTopicBaseView
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
@property (weak, nonatomic) IBOutlet UIButton *changeBigButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;





@end
