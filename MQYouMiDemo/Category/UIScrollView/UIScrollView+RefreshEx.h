//
//  UIScrollView+RefreshEx.h
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (RefreshEx)

/**
 下拉刷新
 
 @param beginRefresh 是否自动刷新
 @param animation 是否需要动画
 @param refreshBlock 刷新回调
 */
- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(void))refreshBlock;


/**
 上啦加载
 
 @param automaticallyRefresh 是否自动加载
 @param loadMoreBlock 加载回调
 */
- (void)addFooterWithAutomaticallyRefresh:(BOOL)automaticallyRefresh loadMoreBlock:(void(^)(void))loadMoreBlock;

/**
 普通请求结束刷新
 */

- (void)endHeaderRefresh;

/**
 普通请求结束刷新
 */
- (void)endFooterRefresh;

/**
 没有数据结束刷新
 */
- (void)endFooterNoMoreData;

/*
 *  重置刷新状态
 */
- (void)resetNoMoreData;

@end

NS_ASSUME_NONNULL_END
