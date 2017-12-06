//
//  XMGSetClearCell.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/7.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGSetClearCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

#define CACHE_PATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"default"];

@implementation XMGSetClearCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorView startAnimating];
        self.accessoryView = indicatorView;
        self.textLabel.text = @"清除缓存(正在计算中...)";
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        __weak typeof(self)weakSelf = self;
        [queue addOperationWithBlock:^{
            NSString *path = CACHE_PATH;
            unsigned long long size = path.fileSize;
            XMGLOG(@"111");
            [NSThread sleepForTimeInterval:3.0];
            if (weakSelf == NULL) return;
            NSString *sizePath = @"0B";
            if (size > pow(10, 9)) {
                sizePath = [NSString stringWithFormat:@"%0.2fGB",size/pow(10, 9)];
            }else if (pow(10, 6)){
                sizePath = [NSString stringWithFormat:@"%0.2fMB",size/pow(10, 6)];
            }else if (pow(10, 3)){
                sizePath = [NSString stringWithFormat:@"%0.2fKB",size/pow(10, 3)];
            }else {
                sizePath = [NSString stringWithFormat:@"%zdB",size];
            }
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                weakSelf.accessoryView = nil;
                weakSelf.textLabel.text = [NSString stringWithFormat:@"清除缓存(%@)",sizePath];
            }];
        }];
        // 添加单击事件
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClickAction)];
        [self.contentView addGestureRecognizer:tapGes];
    }
    return self;
}
/**
 *
 *  点击的事件(清除缓存)
 */
- (void)tapClickAction {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showWithStatus:@"正在清除---"];
//        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    });
    NSString *path = CACHE_PATH;
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:path error:nil];
    [mgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismissWithDelay:5];
    });
}

@end
