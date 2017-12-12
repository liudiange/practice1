//
//  XMGTopicTableController.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/8.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGTopicModel.h"

@interface XMGTopicTableController : UITableViewController
/**
 *
 *   数组
 */
@property (nonatomic, strong) NSMutableArray *dataArray;
/**
 *
 *   外部传递来的model
 */
-(TopicType)type;




@end
