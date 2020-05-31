//
//  YouMiHeader.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#ifndef YouMiHeader_h
#define YouMiHeader_h


typedef void(^NILBlock)(void);//空block
typedef void(^ResponseBlock)(id responseObject);//参数为id类型的block
typedef void(^ErrorBlock)(NSError *error);//参数为error的block

typedef void(^SuccessBlock)(BOOL Success, id responseObject);
typedef void (^ErrorCodeBlock)(NSInteger errCode, NSString *errorMsg);//参数为解析后error的block

/** 需要横屏或者竖屏，获取屏幕宽度与高度 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上

#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

/** 用分辨率做屏幕的适配（基于XS） */
#define kMaxOfWOrH MAX(SCREEN_WIDTH, SCREEN_HEIGHT)
#define kMinOfWOrH MIN(SCREEN_WIDTH, SCREEN_HEIGHT)


/** 相对数值 */
#define kRelative_H(h) ((h) * kMaxOfWOrH / 812.0)
#define kRelative_W(w) ((w) * kMinOfWOrH / 375.0)

/** 日志打印 */
#ifdef DEBUG
# define MQLog(fmt, ...) NSLog((@"[function: %s] [Line: %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define MQLog(...)
#endif

/** 设置 view 圆角和边框 */
#define MQViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/** 设置RGB颜色/设置RGBA颜色 */
#define MQRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define MQRGBColor(r, g, b) MQRGBAColor(r, g, b, 1.)

#define MQHEXColor(hexValue)  [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define MQHexString(hex) [UIColor colorWithHexString:(hex)]

/* 弱引用/强引用 */
#define MQWeakSelf(type) __weak typeof(type) weak##type = type;
#define MQStrongSelf(type)  __strong typeof(type) strong##type = type;


/** 字体 */

#define MQFont(float) [UIFont systemFontOfSize:float]
#define MQFontBold(float) [UIFont boldSystemFontOfSize:float]

#define MQFontLight(float) [UIFont systemFontOfSize:float weight:UIFontWeightLight]
#define MQFontThin(float) [UIFont systemFontOfSize:float weight:UIFontWeightThin]
#define MQFontHeavy(float) [UIFont systemFontOfSize:float weight:UIFontWeightHeavy]
#define MQFontMedium(float) [UIFont systemFontOfSize:float weight:UIFontWeightMedium]
#define MQFontSemibold(float) [UIFont systemFontOfSize:float weight:UIFontWeightSemibold]


/** 适配iPhone 刘海 */
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define KSafeBottomHeight (kStatusBarHeight > 20. ? 34. : 0)
#define KTabbarHeight (KSafeBottomHeight + 49.)

#define HudShowTimeInterval 1.5


#define KUserToken @"8ed7ddfde5ca37849b7c43591957d7fb73adc2a1"


#endif /* YouMiHeader_h */
