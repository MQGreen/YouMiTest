//
//  NSString+Safe.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "NSString+Safe.h"

@implementation NSString (Safe)

+ (NSString *)mq_notNil:(NSString *)str {
    return (str.length == 0) ? @"" : str;
}

@end
