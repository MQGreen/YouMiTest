//
//  UIScrollView+RefreshEx.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "UIScrollView+RefreshEx.h"
#import <objc/runtime.h>

typedef void(^RefreshBlock)(void);
typedef void(^LoadMoreBlock)(void);

@interface UIScrollView ()

/**下拉时候触发的block*/
@property (nonatomic, copy) RefreshBlock refreshBlock;
/**上拉时候触发的block*/
@property (nonatomic, copy) LoadMoreBlock loadMoreBlock;

@end


@implementation UIScrollView (RefreshEx)

- (void)addHeaderWithHeaderWithBeginRefresh:(BOOL)beginRefresh animation:(BOOL)animation refreshBlock:(void(^)(void))refreshBlock {
    
    __weak typeof(self) weakSelf = self;
    self.refreshBlock = refreshBlock;
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.refreshBlock) {
            weakSelf.refreshBlock();
        }
    }];
    
    if (beginRefresh && animation) {
        //有动画的刷新
        [self beginHeaderRefresh];
    }else if (beginRefresh && !animation){
        //刷新，但是没有动画
        [self.mj_header executeRefreshingCallback];
    }
    header.lastUpdatedTimeLabel.hidden = YES;
    header.mj_h = 50.0;
    self.mj_header = header;
    
    
}

- (void)addFooterWithAutomaticallyRefresh:(BOOL)automaticallyRefresh  loadMoreBlock:(void(^)(void))loadMoreBlock {
    
    self.loadMoreBlock = loadMoreBlock;
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.loadMoreBlock) {
            self.loadMoreBlock();
        }
    }];
    footer.triggerAutomaticallyRefreshPercent = 0.1;
    footer.automaticallyRefresh = automaticallyRefresh;
    footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
    footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
    [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"~~这是我的底线啦~~" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;
}

- (void)beginHeaderRefresh {
    [self.mj_header beginRefreshing];
    [self checkFooterLabel];
}

- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
    [self checkFooterLabel];
}

- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
    [self resetNoMoreData];
    [self checkFooterLabel];
}

- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
    [self checkFooterLabel];
}

- (void)endFooterNoMoreData {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshingWithNoMoreData];
        [self checkFooterLabel];
    });
}

/** 数据不满一屏时，隐藏footer stateLabel */
- (void)checkFooterLabel {
    if ([self.mj_footer isKindOfClass:[MJRefreshAutoNormalFooter class]]) {
        MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.mj_footer;
        if (self.frame.size.height == 0) {
            //适配用masonry的情况
            [self layoutIfNeeded];
        }
        if (self.contentSize.height <= self.frame.size.height) {//数据不满屏
            footer.stateLabel.hidden = YES;
        }else {
            footer.stateLabel.hidden = NO;
        }
    }
}

#pragma mark -
#pragma mark - 属性关联

static void *RefreshBlockKey = &RefreshBlockKey;
- (void)setRefreshBlock:(void (^)(void))RefreshBlock {
    objc_setAssociatedObject(self, &RefreshBlockKey, RefreshBlock, OBJC_ASSOCIATION_COPY);
}

- (RefreshBlock)refreshBlock {
    return objc_getAssociatedObject(self, &RefreshBlockKey);
}

static void *LoadMoreBlockKey = &LoadMoreBlockKey;
- (void)setLoadMoreBlock:(LoadMoreBlock)loadMoreBlock {
    objc_setAssociatedObject(self, &LoadMoreBlockKey, loadMoreBlock, OBJC_ASSOCIATION_COPY);
}

- (LoadMoreBlock)loadMoreBlock {
    return objc_getAssociatedObject(self, &LoadMoreBlockKey);
}


@end
