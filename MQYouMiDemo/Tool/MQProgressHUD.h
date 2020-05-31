//
//  MQProgressHUD.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQProgressHUD : NSObject

+ (void)mq_show;
+ (void)mq_dismiss;
+ (void)mq_showMessage:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
