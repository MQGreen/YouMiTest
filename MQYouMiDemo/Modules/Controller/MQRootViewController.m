//
//  MQRootViewController.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQRootViewController.h"
#import "MQMessageListVC.h"

@interface MQRootViewController ()

@end

@implementation MQRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Root";
    [self MQ_AddBtn];
}

- (void)MQ_AddBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"Touch Me" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)btnClick:(UIButton *)sender {
    MQMessageListVC *vc = [MQMessageListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
