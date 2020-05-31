//
//  MQGetMessageApi.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQBaseRequest.h"
#import "MQMessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MQGetMessageApi : MQBaseRequest

/** 1到20，默认10 */
@property (nonatomic, assign) NSInteger limit;


#pragma mark -
#pragma mark - Optional

/** timestamp 前一次调用返回的最后一个元素 */
@property (nonatomic, copy) NSString *lastItem;
/** 0或1，缺省为0取更旧的元素，1取更新的元素（注意lastItem作相应选择） */
@property (nonatomic, assign) NSInteger direction;

@end

NS_ASSUME_NONNULL_END
