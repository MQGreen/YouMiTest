//
//  NSString+Safe.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Safe)

/** 字符串不会为nil */
+ (NSString *)mq_notNil:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
