//
//  UIColor+Addition.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "UIColor+Addition.h"


@implementation UIColor (Addition)

+ (UIColor *)mq_placeHoldColorWithIndex:(NSInteger)index {
    NSArray *arr = @[@(0xDCF4F5), @(0xACE0DD), @(0xFA6690),@(0xFEC0CF),@(0xFEEBF2),@(0xAE7F6C),@(0xB6DCB6),@(0xD2E9E1),@(0xFBEDC9),@(0xF8DDA9),@(0xFCB6D0),@(0xFFDEE1),@(0xFFD6DA),@(0xFFC6D0),@(0xE1F7F7),@(0xD1FAF5),@(0xC3D6F2),@(0x789CCE),@(0xF6D7C3),@(0xACBFEA),@(0xC8D5F6),@(0xFED7DD),@(0xFFC5CE),@(0xFFACBB)];
    index = (index > arr.count - 1) ? (index % arr.count) : index;
    NSInteger hex = [arr[index] integerValue];
    return MQHEXColor(hex);
}

@end
