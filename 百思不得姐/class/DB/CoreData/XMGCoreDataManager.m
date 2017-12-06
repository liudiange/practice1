//
//  XMGCoreDataManager.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/29.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import "XMGCoreDataManager.h"
#import "Student+CoreDataClass.h"

@implementation XMGCoreDataManager
/**
 *
 *  创建表
 */
- (void)creatCoreData {
    
    // 创建上下文
    NSManagedObjectContext *ctx = [[NSManagedObjectContext alloc] init];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"School" withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    // 创建一个持久化序列化器
    NSPersistentStoreCoordinator *storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"liudiange.sqlite"];
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:path] options:nil error:nil];
    ctx.persistentStoreCoordinator = storeCoordinator;
    self.ctx = ctx;
}

/**
 *
 *  button 点击的事件
 */
- (void)buttonAction:(UIButton *)button {
    // @"插入",@"删除",@"更新",@"查询"
    switch (button.tag) {
        case 0:   // 插入
        {
            // 循环插入
            for (int64_t index = 0; index < 10; index ++) {
                
                Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.ctx];
                student.name = [NSString stringWithFormat:@"liudiange %zd",index];
                student.age = index;
                student.height = (CGFloat)(index *1.5);
                [self.ctx save:nil];
            }
        }
            break;
        case 1:  // 删除
        {
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
            request.predicate = [NSPredicate predicateWithFormat:@"name = %@",@"liudiange 0"];
            
            NSArray *array = [self.ctx executeFetchRequest:request error:nil];
            for (Student *stu in array) {
                [self.ctx deleteObject:stu];
                [self.ctx save:nil];
            }
        }
            break;
        case 2:  // 更新
        {
            
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
            request.predicate = [NSPredicate predicateWithFormat:@"name = %@",@"liudiange 1"];
            
            NSArray *array = [self.ctx executeFetchRequest:request error:nil];
            for (Student *stu in array) {
                stu.height = 100.0;
                [self.ctx save:nil];
            }
            
        }
            break;
        case 3:  // 查询
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
            // 分页查询
            //            request.fetchLimit = 10;
            //            request.fetchOffset = 10;
            // 模糊查询
            // 以什么开头 BEDINSWITH  / ENDSWITH
            //request.predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@",@"liudiange"];
            // 包含什么
            request.predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"1"];
            // 生序／降序
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"height" ascending:YES];
            request.sortDescriptors = @[sortDescriptor];
            
            NSArray *dataArray = [self.ctx executeFetchRequest:request error:nil];
            for (Student *stu in  dataArray) {
                XMGLOG(@"名字 - %@ 身高 - %f 年龄 - %lld",stu.name,stu.height,stu.age);
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark - magicalRecord 的框架使用的增删改查
/**
 *
 *  保存 (mr)
 */
- (void)mr_save{
    // 保存数据
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        for (int index = 0; index < 10; index ++) {
            Student *student = [Student MR_createEntityInContext:localContext];
            student.name = [NSString stringWithFormat:@"大王叫我来巡山 %d",index];
            student.height = (12.0 + index);
            student.age = 10*index;
        }
    }completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if (contextDidSave) {
            
        }
    }];
}
/**
 *
 *  查询（mr）
 */
- (void)mr_selectAction {
    // 查询数据
    // 基本查询 查询全部
    //    NSArray *dataArray = [Student MR_findAll];
    // 按照高度生序方式查出(或者降序)
    //              NSArray *dataArray = [Student MR_findAllSortedBy:@"height" ascending:YES];
    //              NSArray *dataArray = [Student MR_findAllSortedBy:@"height,name" ascending:YES];
    //  按照height降序 name生序排列
    //            NSArray *dataArray = [Student MR_findAllSortedBy:@"height:NO,name" ascending:YES];
    // 查询name为 大王叫我来巡山 6 的学生
    //             NSArray *dataArray = [Student MR_findByAttribute:@"name" withValue:@"大王叫我来巡山 6"];
    // 高级搜索谓词过滤的方式
    //            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS %@",@"6"];
    //            NSArray *dataArray = [Student MR_findAllWithPredicate:predicate];
    //            for (Student *student in dataArray) {
    //                XMGLOG(@"student.name -- %@ --- %f----%lld",student.name,student.height,student.age);
    //            }
    //  查询实体个数
    NSNumber *count = [Student MR_numberOfEntities];
    
    XMGLOG(@"%d",[count intValue]);
    
}
/**
 *
 *  删除的时间（mr）
 */
- (void)mr_deleteAction {
    NSArray *dataArray = [Student MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"name = %@",@"大王叫我来巡山 6"]];
    for (Student *student in dataArray) {
        [student MR_deleteEntity];
    }
    NSArray *getDataArray = [Student MR_findAll];
    for (Student *student in getDataArray) {
        XMGLOG(@"student.name -- %@",student.name);
    }
}
/**
 *
 *   修改(mr)
 */
- (void)mr_updateAction {
    NSArray *dataArray = [Student MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"name = %@",@"大王叫我来巡山 2"]];
    for (Student *student in dataArray) {
        student.name = @"啊还是多哈是大手大脚錒是大手大脚";
    }
    NSArray *getDataArray = [Student MR_findAll];
    for (Student *student in getDataArray) {
        XMGLOG(@"student.name -- %@",student.name);
    }
}
/**
 *
 *   数据库迁移
 */
- (void)mr_migration {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        Student *stu = [Student MR_createEntityInContext:localContext];
        stu.name = @"胡萨多久啊啥的";
        stu.height = 18.0;
        stu.age = 10;
        stu.weight = 17.2555;
    }completion:^(BOOL contextDidSave, NSError * _Nullable error) {
        if (contextDidSave) {
            NSArray *array = [Student MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"name = %@",@"胡萨多久啊啥的"]];
            for (Student *stu  in array) {
                XMGLOG(@"%@",stu.name);
            }
        }
    }];
}

@end
