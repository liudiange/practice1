//
//  XMGCoreDataManager.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2017/11/29.
//  Copyright © 2017年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student+CoreDataClass.h"
#import <CoreData/CoreData.h>

@interface XMGCoreDataManager : NSObject

#pragma mark   这个主要就是增删改查，至于表的联系关系主要在 在model开始就设计了 不需要个人过多的考虑

@property (nonatomic, strong) NSManagedObjectContext *ctx;
/**
 *
 *  创建表
 */
- (void)creatCoreData;

/**
 *
 *  button 点击的事件
 */
- (void)buttonAction:(UIButton *)button;
#pragma mark - magicalRecord 的框架使用的增删改查
/**
 *
 *  保存 (mr)
 */
- (void)mr_save;
/**
 *
 *  查询（mr）
 */
- (void)mr_selectAction;
/**
 *
 *  删除的时间（mr）
 */
- (void)mr_deleteAction;
/**
 *
 *   修改(mr)
 */
- (void)mr_updateAction;
/**
 *
 *   数据库迁移
 */
- (void)mr_migration;







@end
