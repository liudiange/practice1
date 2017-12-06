//
//  XMGMigrationManager.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/27.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGMigrationManager.h"
#import "XMGDBBase.h"
@implementation XMGMigrationManager
/**
 *
 *   执行迁移操作
 */
- (void)migration {
       // 创建迁移函数等等
       BOOL result = [self migrationWithPath:DATABASE_NAME];
        // 查询数据并迁移
        if (result) {
            [self migrationWithMessageComplete:^(BOOL flag) {
                if(flag){
                    XMGLOG(@"插入成功了");
                }
            }];
        }
}
/**
 *
 *  迁移message数据
 */
- (void)migrationWithMessageComplete:(void (^)(BOOL flag))complete {
    NSArray *bitchValues = @[@"158",@"啊合适的哈哈是的",@(2),@"asdgasdasd"];
    [self insertIntoOrReplace:@"t_message" field:@[@"message_id", @"content", @"send_status",@"message_detail"] batchValue:bitchValues complete:complete];
}
@end
