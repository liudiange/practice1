//
//  XMGTopicCell.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/21.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGTopicCell.h"
#import "XMGCommentModel.h"
#import "XMGTopicVideoView.h"
#import "XMGTopicVoiceView.h"
#import "XMGTopicPictureView.h"
#import "XMGTopicBaseView.h"

@interface XMGTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *text_lable;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *recentComment;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, weak) XMGTopicVideoView *topicVideoView;
@property (nonatomic, weak) XMGTopicVoiceView *topicVoiceView;
@property (nonatomic, weak) XMGTopicPictureView *topicPictureView;

@end
@implementation XMGTopicCell
#pragma mark - 懒加载
- (XMGTopicPictureView *)topicPictureView {
    if (!_topicPictureView) {
        _topicPictureView = [XMGTopicPictureView  xmg_viewFromXib];
        [self.contentView addSubview:_topicPictureView];
    }
    return _topicPictureView;
}
- (XMGTopicVoiceView *)topicVoiceView {
    if (!_topicVoiceView) {
        _topicVoiceView = [XMGTopicVoiceView  xmg_viewFromXib];
        [self.contentView addSubview:_topicVoiceView];
    }
    return _topicVoiceView;
}
- (XMGTopicVideoView *)topicVideoView {
    if (!_topicVideoView) {
        _topicVideoView = [XMGTopicVideoView  xmg_viewFromXib];
        [self.contentView addSubview:_topicVideoView];
    }
    return _topicVideoView;
}
/**
 *
 *  初始化
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2.0;
    self.profileImageView.layer.masksToBounds = YES;
}
/**
 *
 *  重写model
 */
- (void)setTopicModel:(XMGTopicModel *)topicModel {
    _topicModel = topicModel;
    [self.profileImageView xmg_setHeaderWithUrl:topicModel.profile_image withPlaceHolder:@"activities_black"];
    
    self.nameLable.text = topicModel.name;
    self.timeLable.text = [self timeStr:topicModel.created_at];
    self.text_lable.text = topicModel.text;
    // 最新评论
    if (!NSStringIsNull(topicModel.top_cmt.content)) {
        self.commentView.hidden = NO;
        NSString *commentStr = [NSString stringWithFormat:@"%@ : %@",topicModel.top_cmt.user.username,topicModel.top_cmt.content];
        self.recentComment.text = commentStr;
    }else{
        self.commentView.hidden = YES;
    }
    // 各种按钮
    [self.dingButton setTitle:topicModel.ding forState:UIControlStateNormal];
    [self.caiButton setTitle:topicModel.cai forState:UIControlStateNormal];
    [self.shareButton setTitle:topicModel.repost forState:UIControlStateNormal];
    [self.commentButton setTitle:topicModel.comment forState:UIControlStateNormal];    
}
/**
 *
 *  初始化好了在计算frame
 */
-(void)layoutSubviews {
    [super layoutSubviews];
    // 根据类型进行区分
    switch (self.topicModel.type) {
        case TopicTypePicture: // 图片
        {
            self.topicPictureView.frame = self.topicModel.frame;
            // 隐藏或者显示某一个view
            [self displayOrHide:self.topicPictureView];
            self.topicPictureView.topicModel = self.topicModel;
        }
            break;
        case TopicTypeWord:   //  段子
        {
            // 隐藏或者显示某一个view
            [self displayOrHide:nil];
        }
            break;
        case TopicTypeVoice:  //  声音
        {
            self.topicVoiceView.frame = self.topicModel.frame;
            // 隐藏或者显示某一个view
            [self displayOrHide:self.topicVoiceView];
            self.topicVoiceView.topicModel = self.topicModel;
        }
            break;
        case TopicTypeVideo:  //  视频
        {
            self.topicVideoView.frame = self.topicModel.frame;
            // 隐藏或者显示某一个view
            [self displayOrHide:self.topicVideoView];
            self.topicVideoView.topicModel = self.topicModel;
        }
            break;
        default:
            break;
    }
}


/**
 *
 *  显示时间的lable
 */
- (NSString *)timeStr:(NSString *)creatTime {
    // 2017-11-20 09:20:02
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creatDate = [format dateFromString:creatTime];
    NSDate *nowDate = [NSDate date];
    
    NSCalendar *calender = nil;
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        // 格林日志的
        calender = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
        calender = [NSCalendar currentCalendar];
    }
    NSCalendarUnit unit = kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay|kCFCalendarUnitHour|kCFCalendarUnitMinute|kCFCalendarUnitSecond;
    NSDateComponents *compents =  [calender components:unit fromDate:creatDate toDate:nowDate options:0];
    NSString *timeStr = nil;
    if (compents.year > 0) {
        timeStr = [NSString stringWithFormat:@"%zd年前",compents.year];
    }else if (compents.month){
        timeStr = [NSString stringWithFormat:@"%zd月前",compents.month];
    }else if (compents.day > 0){
        timeStr = [NSString stringWithFormat:@"%zd天前",compents.day];
        if (compents.day == 1) {
            timeStr = [NSString stringWithFormat:@"昨天"];
            if (compents.hour > 0){
              timeStr = [NSString stringWithFormat:@"昨天 %zd时",compents.hour];
            }
        }
    }else if (compents.hour > 0){
        timeStr = [NSString stringWithFormat:@"%zd小时前",compents.hour];
    }else if (compents.minute > 0){
        timeStr = [NSString stringWithFormat:@"%zd分钟前",compents.minute];
    }else {
        timeStr = [NSString stringWithFormat:@"刚刚"];
    }
    return timeStr;
}
/**
 *
 *  显示当前的view 隐藏出了这个的view
 */
- (void)displayOrHide:(XMGTopicBaseView *)displayView {
    
    if (displayView == nil) {
        self.topicPictureView.hidden = YES;
        self.topicVideoView.hidden = YES;
        self.topicVoiceView.hidden = YES;
        return;
    }
    displayView.hidden = NO;
    if ([displayView isKindOfClass:[XMGTopicPictureView class]]) {
        self.topicVideoView.hidden = YES;
        self.topicVoiceView.hidden = YES;
    }else if ([displayView isKindOfClass:[XMGTopicVoiceView class]]){
        self.topicPictureView.hidden = YES;
        self.topicVideoView.hidden = YES;
    }else if ([displayView isKindOfClass:[XMGTopicVideoView class]]){
        self.topicPictureView.hidden = YES;
        self.topicVoiceView.hidden = YES;
    }
}
/**
 *
 *   重写frame
 */
- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 10;
    [super setFrame:frame];
}
@end
