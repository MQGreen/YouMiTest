//
//  MQGetMessageApi.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQGetMessageApi.h"

@implementation MQGetMessageApi

- (NSInteger)limit {
    if (_limit == 0) {
        _limit = 10;
    }
    return _limit;
}

- (BOOL)showLoading {
    return NO;
}

@end
