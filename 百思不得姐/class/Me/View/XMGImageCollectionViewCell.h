//
//  XMGImageCollectionViewCell.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMGImageModel.h"


@interface XMGImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *displayImageView;
@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (nonatomic, strong) XMGImageModel *imageModel;


@end
