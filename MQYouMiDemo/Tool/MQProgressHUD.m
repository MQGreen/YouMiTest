//
//  MQProgressHUD.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQProgressHUD.h"

@implementation MQProgressHUD

+ (void)mq_show {
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD show];
}

+ (void)mq_dismiss {
    [SVProgressHUD dismiss];
}

+ (void)mq_showMessage:(NSString *)msg {
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:msg];
    [SVProgressHUD dismissWithDelay:HudShowTimeInterval];
}


@end
