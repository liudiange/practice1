//
//  AppDelegate.m
//  百思不得姐
//
//  Created by Connect on 2017/6/14.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "AppDelegate.h"
#import "XMGTabBarController.h"
#import "XMGDBBase.h"
#import "XMGMigrationManager.h"


@interface AppDelegate ()



@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    // 可以自动升级
     [MagicalRecord setupAutoMigratingCoreDataStack];

    //设置根控制器
    XMGTabBarController *tabBarVc = [[XMGTabBarController alloc]init];
    self.window.rootViewController = tabBarVc;
    [self.window makeKeyAndVisible];
    
    return YES;
}
/**
 *
 *  fmdb加载
 */
- (void)fmdbAction {
    
    XMGDBBase *baseDb = [[XMGDBBase alloc] init];
    //     创建数据裤（普通的方式创建，不可取应该用数据迁移的方式那种）
#warning  注意了
    [baseDb creatDataBase];
    //     插入数据
    NSArray *bitchValues = @[@"158",@"啊合适的哈哈是的",@(2)];
    NSArray *bitchV = @[@"788",@"啊asdjasdasd",@(4)];
    [baseDb insertIntoOrReplace:@"message" field:@[@"message_id", @"content", @"send_status"] batchValue:bitchValues complete:nil];
    [baseDb insertIntoOrReplace:@"message" field:@[@"message_id", @"content", @"send_status"] batchValue:bitchV complete:nil];
    //     获取数据
    NSString *sql = @"select * from message limit 2 offset 1";
    [baseDb getDataWithSql:sql complete:^(NSArray *array) {
        XMGLOG(@"array -- %@",array);
    }];
    [baseDb getDataWithTableName:@"message" condition:@{@"message_id":@"122",@"send_status":@(2),@"content":@"啊合适的哈哈是的"} complete:^(NSArray *dataArray) {
        XMGLOG(@"dataArray -- %@",dataArray);
    }];
    // 更加简单的插入数据
    NSDictionary *dic = @{@"message_id":@"428",@"content":@"适的哈哈"};
    [baseDb saveDataToDBWithTableName:@"message" fieldsValues:dic complete:^(BOOL result) {
        
    }];
    //     根据条件来获取数据
    [baseDb getCountWithTableName:@"message" condition:@{@"content":@"啊合适的哈哈是的"} complete:^(NSInteger count) {
        XMGLOG(@"count --- %zd",count);
    }];
    //     生序或者降序来获取数据
    [baseDb getDataWithName:@"message" condition:@{@"content":@"啊合适的哈哈是的"} orderBy:@"message_id" sortWay:1 complete:^(NSArray *dataArray) {
        XMGLOG(@"dataArray -- %@",dataArray);
    }];
    //     根据limit 限制获得数组
    [baseDb getDataWithName:@"message" condition:@{@"content":@"啊合适的哈哈是的"} limit:20 offset:0 orderBy:nil sortWay:2 complete:^(NSArray *dataArray) {
        XMGLOG(@"dataArray --- %@",dataArray);
    }];
    //     根据条件进行查询
    [baseDb updateWithName:@"message" field:@{@"send_status":@(200),@"content":@"srfedxwsxz"} condition:@{@"message_id":@"456"} complete:^(BOOL result) {
        
    }];
    //     删除表格中的某一个字段
    [baseDb deleteWithName:@"message" condition:@{@"message_id":@"122"} complete:^(BOOL resule) {
        
    }];
    //     删除某一个表
    [baseDb dropTableName:@"message" complete:^(BOOL result) {
        
    }];
    XMGMigrationManager *manager = [[XMGMigrationManager alloc] init];
    [manager migration];
    
}
-(void)applicationWillTerminate:(UIApplication *)application {
    // 清除
    [MagicalRecord cleanUp];
}

@end
