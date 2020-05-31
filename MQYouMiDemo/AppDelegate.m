//
//  AppDelegate.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "AppDelegate.h"
#import "MQRootViewController.h"

@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = UIColor.whiteColor;
    MQRootViewController *vc = [MQRootViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [self hudConfig];
    return YES;
}

- (void)hudConfig {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0.000 green:0.020 blue:0.059 alpha:0.8]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:HudShowTimeInterval];
}



@end
