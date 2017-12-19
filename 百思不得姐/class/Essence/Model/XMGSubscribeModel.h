//
//  XMGSubscribeModel.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/18.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGSubscribeModel : NSObject

/** 名字*/
@property (copy, nonatomic) NSString *theme_name;
/** 图片*/
@property (copy, nonatomic) NSString *image_list;
/** 订阅数*/
@property (nonatomic, assign) NSInteger sub_number;



@end
