//
//  MQSendMessageVC.m
//  MQYouMiDemo
//
//  Created by 小马 on 2020/5/31.
//  Copyright © 2020 Twist. All rights reserved.
//

#import "MQSendMessageVC.h"
#import "MQSendMessageApi.h"

@interface MQSendMessageVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *changeView;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

static CGFloat const Margin = 20;

@implementation MQSendMessageVC

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Send";
    [self setUpViews];
    [self autoLayoutSubviews];
}



#pragma mark -
#pragma mark - init

- (void)config {
    
}
- (void)setUpViews {
    [self.view addSubview:self.changeView];
    [self.view addSubview:self.confirmBtn];
}

- (void)autoLayoutSubviews {
    [self.changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight + 30);
        make.left.equalTo(Margin);
        make.right.equalTo(-Margin);
        make.height.equalTo(80);
    }];
    MQViewBorderRadius(self.changeView, 5, 0.3, MQRGBColor(151, 151, 151));
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.changeView.mas_bottom).offset(20);
        make.left.right.equalTo(self.changeView);
        make.height.equalTo(40);
    }];
    MQViewBorderRadius(self.confirmBtn, 20, 0, UIColor.clearColor);
}

#pragma mark -
#pragma mark - tool

- (void)updateViews {
    
}

- (void)sendmessage {
    NSString *content = [self.textView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (content.length == 0) {
        [MQProgressHUD mq_showMessage:@"请输入内容"];
        return;
    }
    [self.view endEditing:YES];
    MQSendMessageApi *api = [MQSendMessageApi new];
    api.content = content;
    [api mq_startWithCompletionBlockWithSuccess:^(BOOL Success, id responseObject) {
        if (Success) {
            self.textView.text = nil;
            [MQProgressHUD mq_showMessage:@"发送成功，返回上页查看"];
        }
    } failure:nil];
}

#pragma mark -
#pragma mark - delegate ---> UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    NSInteger max = 32;
    if (textView.text.length > max) {
       textView.text = [textView.text substringWithRange:NSMakeRange(0, max)];
    }
    
}

#pragma mark -
#pragma mark - getter ---> view

- (UIView *)changeView {
    if (!_changeView) {
        _changeView = [UIView new];
        UITextView *textView = [UITextView new];
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请输入内容，最多32个字";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [textView addSubview:placeHolderLabel];

        // same font
        textView.font = [UIFont systemFontOfSize:13.f];
        placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
        [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        [_changeView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(0);
            make.bottom.equalTo(-30);
        }];
        textView.delegate = self;
        self.textView = textView;
    }
    return _changeView;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton new];
        _confirmBtn.backgroundColor = MQRGBColor(142, 51, 214);
        [_confirmBtn setTitle:@"Send" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_confirmBtn addTarget:self action:@selector(sendmessage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}


@end
