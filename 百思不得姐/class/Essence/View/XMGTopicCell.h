//
//  XMGTopicCell.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/21.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopicCell.h"
#import "UIImageView+WebCache.h"
#import "XMGTopicModel.h"

@interface XMGTopicCell : UITableViewCell
/** model*/
@property (nonatomic, strong) XMGTopicModel *topicModel;
/** 底部的buttonview*/
@property (weak, nonatomic) IBOutlet UIView *bottomButtonView;


@end
