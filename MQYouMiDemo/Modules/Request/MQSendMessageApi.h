//
//  MQSendMessageApi.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface MQSendMessageApi : MQBaseRequest

@property (nonatomic, strong) NSString *content;

@end

NS_ASSUME_NONNULL_END
