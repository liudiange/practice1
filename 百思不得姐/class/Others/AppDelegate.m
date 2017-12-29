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
#import "XMGNavigationController.h"
#import "XMGEssenceViewController.h"
#import "XMGAllViewController.h"
#import "XMGVideoViewController.h"
#import "XMGAudioViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UIViewController *clickViewVc;

@end
@implementation AppDelegate
#pragma mark - tabbar 的 delegate
static int countNum = 0;
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
   
    countNum ++;
    XMGNavigationController *nav = (XMGNavigationController *)viewController;
    for (UIViewController *viewVc  in nav.viewControllers) {
        if ([viewVc isKindOfClass:[XMGEssenceViewController class]]) {
            self.clickViewVc = viewVc;
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.clickViewVc isKindOfClass:[XMGEssenceViewController class]] && countNum >= 2) {
            XMGEssenceViewController *essenceVc = (XMGEssenceViewController *)self.clickViewVc;
            for (UIViewController *childVc in essenceVc.childViewControllers) {
                CGRect childVcRect = [childVc.view convertRect:childVc.view.bounds toView:nil];
                CGRect windowRect = [UIApplication sharedApplication].keyWindow.bounds;
                if (CGRectContainsRect(windowRect, childVcRect)) {
                    [self refreshVc:childVc];
                }
            }
        }
        countNum = 0;
    });
}
/**
 *
 *  刷新界面
 */
- (void)refreshVc:(UIViewController *)childVc {
    
    if ([childVc isKindOfClass:[XMGAllViewController class]]) {
        XMGAllViewController *allVc = (XMGAllViewController *)childVc;
        [allVc.tableView.mj_header beginRefreshing];
    }else if ([childVc isKindOfClass:[XMGVideoViewController class]]){
        XMGVideoViewController *videoVc = (XMGVideoViewController *)childVc;
        [videoVc.tableView.mj_header beginRefreshing];
    }else if ([childVc isKindOfClass:[XMGAudioViewController class]]){
        XMGAudioViewController *voiceVc = (XMGAudioViewController *)childVc;
        [voiceVc.tableView.mj_header beginRefreshing];
    }else if ([childVc isKindOfClass:[XMGPictureViewController class]]){
        XMGPictureViewController *pictureVc = (XMGPictureViewController *)childVc;
        [pictureVc.tableView.mj_header beginRefreshing];
    }else if ([childVc isKindOfClass:[XMGWordViewController class]]) {
        XMGWordViewController *wordVc = (XMGWordViewController *)childVc;
        [wordVc.tableView.mj_header beginRefreshing];
    }
    
}
#pragma mark - application 的 delegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    // 可以自动升级
     [MagicalRecord setupAutoMigratingCoreDataStack];
    //设置根控制器
    XMGTabBarController *tabBarVc = [[XMGTabBarController alloc]init];
    tabBarVc.delegate = self;
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
