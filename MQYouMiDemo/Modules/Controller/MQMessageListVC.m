//
//  MQMessageListVC.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQMessageListVC.h"
#import "MQGetMessageApi.h"
#import "MQSendMessageVC.h"

@interface MQMessageListVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MQMessageModel *msgModel;

@end

static NSString *const CellId = @"CellId";

@implementation MQMessageListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Message";
    [self navConfig];
    [self setUpViews];
    [self autoLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark -
#pragma mark - init

- (void)navConfig {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStylePlain target:self action:@selector(sendMessage)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setUpViews {
    [self.view addSubview:self.tableView];
}

- (void)autoLayoutSubviews {
    
}

#pragma mark -
#pragma mark - tool

- (void)updateViews {
    
}

- (void)sendMessage {
    MQSendMessageVC *vc = [MQSendMessageVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark - request

- (void)refreshData {
    MQGetMessageApi *api = [MQGetMessageApi new];
    api.limit = 20;
    [api mq_startWithCompletionBlockWithSuccess:^(BOOL Success, id responseObject) {
        [self.tableView endHeaderRefresh];
        [self.tableView resetNoMoreData];
        if (Success) {
            self.msgModel = [MQMessageModel yy_modelWithDictionary:responseObject];
            [self.tableView reloadData];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [self.tableView endHeaderRefresh];
    }];
}

- (void)loadData {
    MQGetMessageApi *api = [MQGetMessageApi new];
    api.limit = 20;
    api.lastItem = self.msgModel.data.lastItem.creationTime;
    [api mq_startWithCompletionBlockWithSuccess:^(BOOL Success, id responseObject) {
        [self.tableView endFooterRefresh];
        [self.tableView resetNoMoreData];
        if (Success) {
            MQMessageModel *model = [MQMessageModel yy_modelWithDictionary:responseObject];
            if (model.data.items.count != api.limit) {
                [self.tableView endFooterNoMoreData];
            }
            [self.msgModel.data.items addObjectsFromArray:model.data.items];
            self.msgModel.data.lastItem = model.data.lastItem;
            [self.tableView reloadData];
        }
    } failure:^(NSInteger errCode, NSString *errorMsg) {
        [self.tableView endFooterRefresh];
    }];
}

#pragma mark -
#pragma mark - delegate ---> tableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgModel.data.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    //这种方式是为了使用detailTextLabel
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellId];
    }
    MQMessageItemModel *model = [self.msgModel.data.items objectAtIndex:indexPath.row];
    cell.textLabel.text = model.id;
    cell.detailTextLabel.text = model.content;
    return cell;
}

#pragma mark -
#pragma mark - getter ---> view

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = CGRectMake(0, kTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTopHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellId];
        if (@available(iOS 11, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        MQWeakSelf(self)
        [_tableView addHeaderWithHeaderWithBeginRefresh:YES animation:YES refreshBlock:^{
            [weakself refreshData];
        }];
        [_tableView addFooterWithAutomaticallyRefresh:YES loadMoreBlock:^{
            [weakself loadData];
        }];
    }
    return _tableView;
}

@end
