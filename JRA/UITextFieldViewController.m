//
//  UITextFieldViewController.m
//  JRA
//
//  Created by 蒋晨成 on 2018/12/25.
//  Copyright © 2018年 Jaba. All rights reserved.
//

#import "UITextFieldViewController.h"
#import <ReactiveObjC.h>
@interface UITextFieldViewController ()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation UITextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[UITextField alloc] init];
    self.textField.frame = CGRectMake(20, 100, 100, 30);
    self.textField.placeholder = @"输入内容";
    [self.view addSubview:_textField];
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输入框的内容：%@", x);
    }];
    
    [[[self.textField rac_textSignal] filter:^BOOL(NSString * _Nullable value) {
        return value.length > 5;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@">5输入框的内容：%@", x);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
