//
//  XMGTopicModel.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/20.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicModel.h"

@implementation XMGTopicModel

/**
 *
 *  重写高度 到时候直接获取
 */
- (CGFloat)cellHeight {
    
    if (_cellHeight) return _cellHeight;
    _cellHeight = 60;
    // 计算发表内容的高度
    NSString *contextStr = self.text;
    CGSize size = CGSizeMake(ScreenWidth - 2*MarGen, MAXFLOAT);
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont systemFontOfSize:15.0]
                          };
    CGSize contextSize = [contextStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size;
    _cellHeight += contextSize.height + MarGen;
    // 根据类型判断
    if (self.type != TopicTypeWord) {
        CGFloat imageHeight = (ScreenWidth-2*MarGen)*(self.height/self.width);
        self.frame = CGRectMake(MarGen, _cellHeight, ScreenWidth-2*MarGen, imageHeight);
        _cellHeight += imageHeight + MarGen;
    }else {
        _cellHeight += 0;
    }
    // 计算评论的高度
    CGSize getCommentSize = CGSizeMake(0, 0);
    // 最热的评论
    if (self.top_cmt) {
        NSString *commentStr = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.user.username,self.top_cmt.content];
        CGSize commentSize = CGSizeMake(ScreenWidth - 2*MarGen, MAXFLOAT);
        NSDictionary *commentDic = @{
                                     NSFontAttributeName : [UIFont systemFontOfSize:15.0]
                                     };
        getCommentSize = [commentStr boundingRectWithSize:commentSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:commentDic context:nil].size;
        // 整合高度
        _cellHeight += getCommentSize.height + MarGen + 55;
        
    }else {
        // 整合高度
        _cellHeight += 55;
    }
    return _cellHeight;
}

@end
