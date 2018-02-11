//
//  XMGHttpManager.h
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/29.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "XMGSuccessModel.h"
#import "XMGFailureModel.h"
#import "XMGHttpConfig.h"

@interface XMGHttpManager : NSObject

/**
 请求的管理者
 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
// 一个小小的测试
@property (nonatomic, strong) NSString *str;
/**
 请求的任务
 */
@property (nonatomic, strong) NSURLSessionDataTask *task;


/**
 post 请求

 @param path 链接
 @param parmaDic 请求的参数
 @param isNeedHub 是否需要显示加载信息
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)XMG_POST:(NSString *)path
         parma:(NSMutableDictionary *)parmaDic
         needHub:(BOOL)isNeedHub
         success:(void(^)(XMGSuccessModel *successModel))success
         failure:(void (^)(XMGFailureModel *failureModel))failure;
/**
 get 请求
 
 @param path 链接
 @param parmaDic 请求的参数
 @param isNeedHub 是否需要显示加载信息
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)XMG_GET:(NSString *)path
        parma:(NSMutableDictionary *)parmaDic
        needHub:(BOOL)isNeedHub
        success:(void(^)(XMGSuccessModel *successModel))success
        failure:(void (^)(XMGFailureModel *failureModel))failure;

/**
 带有进度的 post 请求

 @param path 基本的路径
 @param parmaDic 参数
 @param isNeedHub 是否需要显示加载的动画
 @param progress 显示的进度
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)XMG_POST:(NSString *)path
         parma:(NSMutableDictionary *)parmaDic
         needHub:(BOOL)isNeedHub
         progress:(void (^)(NSProgress * progress))progress
         success:(void(^)(XMGSuccessModel *successModel))success
         failure:(void (^)(XMGFailureModel *failureModel))failure;
/**
 带有进度的 get 请求
 
 @param path 基本的路径
 @param parmaDic 参数
 @param isNeedHub 是否需要显示加载的动画
 @param progress 显示的进度
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)XMG_GET:(NSString *)path
         parma:(NSMutableDictionary *)parmaDic
         needHub:(BOOL)isNeedHub
         progress:(void (^)(NSProgress * progress))progress
         success:(void(^)(XMGSuccessModel *successModel))success
         failure:(void (^)(XMGFailureModel *failureModel))failure;


/**
 图片上传的网络请求（post方式）

 @param image 图片
 @param imageName 图片的名字
 @param fileName 图片的存储路径
 @param isNeedHub 是否需要显示隐藏hub
 @param url 上转的链接
 @param paramDic 字典参数
 @param progress 进度
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)XMG_UploadWithImage:(UIImage *)image
                  imageName:(NSString *)imageName
                   fileName:(NSString *)fileName
                  uploadUrl:(NSString *)url
                    needHub:(BOOL)isNeedHub
                      param:(NSMutableDictionary *)paramDic
                   progress:(void (^)(NSProgress * progress))progress
                    success:(void (^)(XMGSuccessModel *successModel))success
                    failure:(void (^)(XMGFailureModel *failureModel))failure;


@end
