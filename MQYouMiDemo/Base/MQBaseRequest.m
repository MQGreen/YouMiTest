//
//  MQBaseRequest.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQBaseRequest.h"
#import "MQBaseModel.h"

@implementation MQBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
        [agent setValue:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil] forKeyPath:@"_manager.responseSerializer.acceptableContentTypes"];
    }
    return self;
}

- (NSString *)baseUrl {
    return @"https://3evjrl4n5d.execute-api.us-west-1.amazonaws.com/dev/message";
}

- (NSTimeInterval)requestTimeoutInterval {
    return 10.;
}


- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGET;
}

- (id)requestArgument {
    return [self yy_modelToJSONObject];
}

- (YTKRequestSerializerType)requestSerializerType {
    return YTKRequestSerializerTypeJSON;
}

/**
 设置黑名单，model转dic的时候会忽略的字段，
 该设置的字段是YTKRequest里面的属性，可注释该协议，打印查看。
 
 @return 要忽略字段的数组
 */
+ (NSArray<NSString *> *)modelPropertyBlacklist {
    return @[@"dataFromCache",
             @"ignoreCache",
             @"requestPriority",
             @"tag"];
}

- (NSString *)id {
    if (_id.length == 0) {
        _id = @"123";
    }
    return _id;
}

- (BOOL)showToast {
    return NO;
}

- (BOOL)showErrorToast {
    return YES;
}

- (BOOL)showFailureToast {
    return YES;
}

- (BOOL)showLoading {
    return YES;
}

#pragma mark -
#pragma mark - tool

- (void)mq_startWithCompletionBlockWithSuccess:(SuccessBlock)success failure:(ErrorCodeBlock)failure {
    if ([self showLoading]) {
        [MQProgressHUD mq_show];
    }
    NSString *url = [NSString stringWithFormat:@"【%@/%@】", self.baseUrl, self.requestUrl];
    MQLog(@"\n>>>URL:%@ \n param:%@", url, [self.requestArgument yy_modelToJSONString]);
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        if ([self showLoading]) {
            [MQProgressHUD mq_dismiss];
        }
        MQLog(@">>>\n header:%@", request.originalRequest.allHTTPHeaderFields);
        MQLog(@"\n>>>succ:\n URL:%@ \n responseString:%@", url, request.responseString);
        MQBaseModel *model = [MQBaseModel yy_modelWithDictionary:request.responseObject];
        if (request.responseStatusCode == 200) {
            if ([self showToast]) {
                [MQProgressHUD mq_showMessage:model.message];
            }
            if (success) {
                success(YES, request.responseObject);
            }
        }else {
            if ([self showErrorToast]) {
                [MQProgressHUD mq_showMessage:model.message];
            }
            if (success) {
                success(NO, request.responseObject);
            }
        }
       
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        MQLog(@">>>\n header:%@", request.originalRequest.allHTTPHeaderFields);
        MQLog(@"\n>>>fail:\n URL:%@ \n responseString:%@", url, request.responseString);
        MQBaseModel *model = [MQBaseModel yy_modelWithDictionary:request.responseObject];
        if ([self showLoading]) {
            [MQProgressHUD mq_dismiss];
        }
        if ([self showFailureToast]) {
            [MQProgressHUD mq_showMessage:@"网络不给力"];
        }
        if (failure) {
            failure(request.responseStatusCode, request.responseString);
        }
    }];
}

@end
