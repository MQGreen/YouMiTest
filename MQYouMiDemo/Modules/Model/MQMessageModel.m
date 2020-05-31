//
//  MQMessageModel.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQMessageModel.h"

@implementation MQMessageItemModel

@end

@implementation MQMessageDataModel

- (NSMutableArray<MQMessageItemModel *> *)items {
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"items":MQMessageItemModel.class};
}

@end

@implementation MQMessageModel

@end
