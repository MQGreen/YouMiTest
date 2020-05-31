//
//  UILabel+Title.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "UILabel+Title.h"

@implementation UILabel (Title)

- (void)mq_setLabelText:(NSString *)text Color:(UIColor *)color Font:(UIFont *)font {
    self.text = text;
    self.textColor = color;
    self.font = font;
}

@end
