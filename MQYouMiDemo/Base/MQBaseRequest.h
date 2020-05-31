//
//  MQBaseRequest.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "YTKBaseRequest.h"


@interface MQBaseRequest : YTKBaseRequest

@property (nonatomic, copy) NSString *id;

/**
 设置是否显示响应成功信息 默认NO
 
 @return BOOL
 */
- (BOOL)showToast;

/**
 设置是否显示服务器返回错误信息 默认YES
 
 @return BOOL
 */
- (BOOL)showErrorToast;

/**
 设置是否显示请求失败（网络不通或超时） 默认YES
 
 @return BOOL
 */
- (BOOL)showFailureToast;

/**
 设置是否显示loading 默认YES
 
 @return BOOL
 */
- (BOOL)showLoading;

#pragma mark -
#pragma mark - Request

- (void)mq_startWithCompletionBlockWithSuccess:(SuccessBlock)success failure:(ErrorCodeBlock)failure;

@end

