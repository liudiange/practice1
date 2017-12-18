//
//  XMGImageCollectionViewCell.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/12/15.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGImageCollectionViewCell.h"
#import "XMGImageManager.h"

@implementation XMGImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)setImageModel:(XMGImageModel *)imageModel {
    _imageModel = imageModel;
    self.displayImageView.image = imageModel.smallImage;
    
    if (imageModel.isSelected) {
        self.selectButton.selected = YES;
        self.markView.hidden = NO;
    }else {
        self.selectButton.selected = NO;
        self.markView.hidden = YES;
    }
}

/**
 *
 *  选择这个图片
 */
- (IBAction)selectButtonAction {
    if (self.selectButton.isSelected) {
        self.selectButton.selected = NO;
        self.markView.hidden = YES;
        _imageModel.isSelected = NO;
        [[XMGImageManager shareManager].imageArray removeObject:self.displayImageView.image];
    }else {
        self.selectButton.selected = YES;
        self.markView.hidden = NO;
        [[XMGImageManager shareManager].imageArray addObject:self.displayImageView.image];
        _imageModel.isSelected = YES;
    }
    // 发出通知显示下边的lable
    [[NSNotificationCenter defaultCenter] postNotificationName:ImageLableCount object:nil];
}

@end
