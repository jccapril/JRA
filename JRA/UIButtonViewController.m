//
//  UIButtonViewController.m
//  JRA
//
//  Created by 蒋晨成 on 2018/12/25.
//  Copyright © 2018年 Jaba. All rights reserved.
//

#import "UIButtonViewController.h"
#import <ReactiveObjC.h>
@interface UIButtonViewController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UITextField *accountTextField;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation UIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.frame = CGRectMake(100, 100, 100, 30);
    [self.button setTitle:@"button" forState:UIControlStateNormal];
    [self.view addSubview:_button];
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@ 按钮被点击了", x); //x 是 button 按钮对象
    }];
    
    
    
    self.accountTextField = [[UITextField alloc] init];
    self.accountTextField.placeholder = @"账号";
    self.accountTextField.frame= CGRectMake(100, 150, 100, 30);
    [self.view addSubview:_accountTextField];
    
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.placeholder = @"密码";
    self.passwordTextField.frame = CGRectMake(100, 200, 100, 30);
    [self.view addSubview:_passwordTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    self.loginButton.frame = CGRectMake(100, 250, 100, 30);
    [self.view addSubview:_loginButton];
    
    RAC(_loginButton, enabled) = [RACSignal combineLatest:@[_accountTextField.rac_textSignal,_passwordTextField.rac_textSignal] reduce:^id _Nonnull(NSString *username, NSString *password){
        return @(username.length && password.length);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
