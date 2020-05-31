//
//  MQSendMessageApi.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQSendMessageApi.h"

@implementation MQSendMessageApi

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (BOOL)showLoading {
    return NO;
}

@end
