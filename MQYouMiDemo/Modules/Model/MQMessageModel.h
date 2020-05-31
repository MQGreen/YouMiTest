//
//  MQMessageModel.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MQMessageItemModel : MQBaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *creationTime;


@end

@interface MQMessageDataModel : MQBaseModel

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray<MQMessageItemModel *> *items;
@property (nonatomic, strong) MQMessageItemModel *lastItem;


@end

@interface MQMessageModel : MQBaseModel

@property (nonatomic, strong) MQMessageDataModel *data;

@end

NS_ASSUME_NONNULL_END
