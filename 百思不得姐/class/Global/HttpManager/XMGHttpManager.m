//
//  XMGHttpManager.m
//  百思不得姐
//
//  Created by 刘殿阁 on 2018/1/29.
//  Copyright © 2018年 Connect. All rights reserved.
//

#import "XMGHttpManager.h"

@implementation XMGHttpManager

#pragma mark 懒加载
- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _manager.requestSerializer.timeoutInterval = XMG_TimeOut;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                   @"text/html",
                                                                                   @"text/json",
                                                                                   @"text/plain",
                                                                                   @"text/javascript",
                                                                                   @"text/xml",
                                                                                   @"image/*"]];
    }
    return _manager;
}

#pragma mark - 正常的方法请求
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
         failure:(void (^)(XMGFailureModel *failureModel))failure{
    
    // 开始的操作
    [self startOpention:isNeedHub];
    self.task = [self.manager POST:[self configUrl:path] parameters:parmaDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGSuccessModel *successM = [[XMGSuccessModel alloc] init];
        successM.successCode = XMG_SUCCESSCODE;
        successM.successDic = responseObject;
        success(successM);
        // 这里可以增加是否确定根据后台的情况判断是否在增加一个error code
        if (0) {
            XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
            NSError *errorM = [NSError  errorWithDomain:@"sadasdasd" code:0 userInfo:nil];
            failureM.errorCode = 0;
            failureM.errorMessage = @"后台错误";
            failureM.error = errorM;
            failure(failureM);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
        switch (error.code) {
            case 404:
            {
                failureM.errorCode = XMG_ERRORCODE404;
                failureM.errorMessage = @"后台错误";
            }
                break;
            case 900:
            {
                failureM.errorCode = XMG_ERRORCODE500;
                failureM.errorMessage = @"登录错误";
            }
                break;
            default:
            {
                failureM.errorCode = 0;
                failureM.errorMessage = @"出现错误了";
            }
                break;
        }
        failureM.error = error;
        failure(failureM);
    }];
    [self.task resume];
    
}
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
        failure:(void (^)(XMGFailureModel *failureModel))failure{
    
    // 开始的操作
    [self startOpention:isNeedHub];
    self.task = [self.manager GET:[self configUrl:path] parameters:parmaDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        // 需要根据后台的数据进行判断
        XMGSuccessModel *successM = [[XMGSuccessModel alloc] init];
        successM.successCode = XMG_SUCCESSCODE;
        successM.successDic = responseObject;
        success(successM);
        // 这里可以增加是否确定根据后台的情况判断是否在增加一个error code
        if (0) {
            XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
            NSError *errorM = [NSError  errorWithDomain:@"sadasdasd" code:0 userInfo:nil];
            failureM.errorCode = 0;
            failureM.errorMessage = @"后台错误";
            failureM.error = errorM;
            failure(failureM);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
        switch (error.code) {
            case 404:
            {
                failureM.errorCode = XMG_ERRORCODE404;
                failureM.errorMessage = @"后台错误";
            }
                break;
            case 900:
            {
                failureM.errorCode = XMG_ERRORCODE500;
                failureM.errorMessage = @"登录错误";
            }
                break;
            default:
            {
                failureM.errorCode = 0;
                failureM.errorMessage = @"出现错误了";
            }
                break;
        }
        failureM.error = error;
        failure(failureM);
    }];
    [self.task resume];
}
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
         failure:(void (^)(XMGFailureModel *failureModel))failure {
    
    // 开始的操作
    [self startOptionWithNoHub];
    self.task = [self.manager POST:[self configUrl:path] parameters:parmaDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        if (isNeedHub) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat progressF = 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
                [SVProgressHUD showProgress:progressF];
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGSuccessModel *successM = [[XMGSuccessModel alloc] init];
        successM.successCode = XMG_SUCCESSCODE;
        successM.successDic = responseObject;
        success(successM);
        // 这里可以增加是否确定根据后台的情况判断是否在增加一个error code
        if (0) {
            XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
            NSError *errorM = [NSError  errorWithDomain:@"sadasdasd" code:0 userInfo:nil];
            failureM.errorCode = 0;
            failureM.errorMessage = @"后台错误";
            failureM.error = errorM;
            failure(failureM);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
        switch (error.code) {
            case 404:
            {
                failureM.errorCode = XMG_ERRORCODE404;
                failureM.errorMessage = @"后台错误";
            }
                break;
            case 900:
            {
                failureM.errorCode = XMG_ERRORCODE500;
                failureM.errorMessage = @"登录错误";
            }
                break;
            default:
            {
                failureM.errorCode = 0;
                failureM.errorMessage = @"出现错误了";
            }
                break;
        }
        failureM.error = error;
        failure(failureM);
    }];
    [self.task resume];
}
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
        failure:(void (^)(XMGFailureModel *failureModel))failure {
    
    // 开始的操作
    [self startOptionWithNoHub];
    self.task = [self.manager GET:[self configUrl:path] parameters:parmaDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
        if (isNeedHub) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat progressF = 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
                [SVProgressHUD showProgress:progressF];
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGSuccessModel *successM = [[XMGSuccessModel alloc] init];
        successM.successCode = XMG_SUCCESSCODE;
        successM.successDic = responseObject;
        success(successM);
        // 这里可以增加是否确定根据后台的情况判断是否在增加一个error code
        if (0) {
            XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
            NSError *errorM = [NSError  errorWithDomain:@"sadasdasd" code:0 userInfo:nil];
            failureM.errorCode = 0;
            failureM.errorMessage = @"后台错误";
            failureM.error = errorM;
            failure(failureM);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
        switch (error.code) {
            case 404:
            {
                failureM.errorCode = XMG_ERRORCODE404;
                failureM.errorMessage = @"后台错误";
            }
                break;
            case 900:
            {
                failureM.errorCode = XMG_ERRORCODE500;
                failureM.errorMessage = @"登录错误";
            }
                break;
            default:
            {
                failureM.errorCode = 0;
                failureM.errorMessage = @"出现错误了";
            }
                break;
        }
        failureM.error = error;
        failure(failureM);
    }];
    [self.task resume];
    
}
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
                    failure:(void (^)(XMGFailureModel *failureModel))failure {
    
    if (fileName.length == 0 || image == nil) {
        return;
    }
    // 开始的操作
    [self startOptionWithNoHub];
    
    self.task = [self.manager POST:[self configUrl:url] parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        NSString *imageN = imageName;
        if (imageN.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMdd";
            imageN = [formatter stringFromDate:[NSDate date]];
            imageN = [NSString stringWithFormat:@"%@.jpg",imageN];
        }
        // 以文件流的方式上传
        [formData appendPartWithFileData:imageData name:imageN fileName:fileName mimeType:@"image/JPEG"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (isNeedHub) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CGFloat progressF = 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
                [SVProgressHUD showProgress:progressF];
            });
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGSuccessModel *successM = [[XMGSuccessModel alloc] init];
        successM.successCode = XMG_SUCCESSCODE;
        successM.successDic = responseObject;
        success(successM);
        // 这里可以增加是否确定根据后台的情况判断是否在增加一个error code
        if (0) {
            XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
            NSError *errorM = [NSError  errorWithDomain:@"sadasdasd" code:0 userInfo:nil];
            failureM.errorCode = 0;
            failureM.errorMessage = @"后台错误";
            failureM.error = errorM;
            failure(failureM);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(isNeedHub){
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        XMGFailureModel *failureM = [[XMGFailureModel alloc] init];
        switch (error.code) {
            case 404:
            {
                failureM.errorCode = XMG_ERRORCODE404;
                failureM.errorMessage = @"后台错误";
            }
                break;
            case 900:
            {
                failureM.errorCode = XMG_ERRORCODE500;
                failureM.errorMessage = @"登录错误";
            }
                break;
            default:
            {
                failureM.errorCode = 0;
                failureM.errorMessage = @"出现错误了";
            }
                break;
        }
        failureM.error = error;
        failure(failureM);
    }];
    [self.task resume];
}
#pragma mark - 其他的相关的操作
/**
 配置url

 @param path 给的路径
 */
- (NSString *)configUrl:(NSString *)path {
    /*
    正常的配置
     
    NSString *str = @"http://218.200.160.29/rdp2/test/mac/";
    path = [str stringByAppendingString:path];
    NSString *versionStr = [NSString stringWithFormat:@"ua=%@&version=%@",XMG_UA,XMG_VERSION];
    path = [path stringByAppendingString:versionStr];
     */
    return path;
}

/**
 网络请求开始的操作

 @param isNeedHub 是否需要显示加载的动画
 */
- (void)startOpention:(BOOL)isNeedHub {
    
    [self cancelRequest];
    [self addHeadOpention];
    if(isNeedHub){
        dispatch_async(dispatch_get_main_queue(), ^{
         [SVProgressHUD show];
        });
    }
}
/**
 开始的相关的操作
 */
- (void)startOptionWithNoHub {
    [self cancelRequest];
    [self addHeadOpention];
}
/**
 取消任务操作
 */
- (void)cancelRequest {
    // 取消任务
    [self.task cancel];
    self.task = nil;
    // 清除网络的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

/**
 添加头部的操作
 */
- (void)addHeadOpention {
//    [AFHTTPSessionManager.manager.requestSerializer setValue:@"" forHTTPHeaderField:@""];
    
}

@end
