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
        [[XMGImageManager shareManager].smallImageArray removeObject:_imageModel.smallImage];
        [[XMGImageManager shareManager].bigImageArray removeObject:_imageModel.bigImage];
    }else {
        self.selectButton.selected = YES;
        self.markView.hidden = NO;
        _imageModel.isSelected = YES;
         [[XMGImageManager shareManager].smallImageArray addObject:_imageModel.smallImage];
         [[XMGImageManager shareManager].bigImageArray addObject:_imageModel.bigImage];
    }
    // 发出通知显示下边的lable
    [[NSNotificationCenter defaultCenter] postNotificationName:ImageLableCount object:nil];
}

@end
