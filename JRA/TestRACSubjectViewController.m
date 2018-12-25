//
//  TestRACSubjectViewController.m
//  JRA
//
//  Created by 蒋晨成 on 2018/12/19.
//  Copyright © 2018年 Jaba. All rights reserved.
//

#import "TestRACSubjectViewController.h"

@interface TestRACSubjectViewController ()

@end

@implementation TestRACSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(screenWidth/2-50, 100, 100, 10);
    [backButton setTitle:@"back" forState:UIControlStateNormal];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeSystem];
    testButton.frame = CGRectMake(screenWidth/2-50, 150, 100, 10);
    [testButton setTitle:@"test" forState:UIControlStateNormal];
    [self.view addSubview:testButton];
    [testButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)test:(UIButton *)sender {
    [self.delegateSubject sendNext:@"test 被点击了"];
}


@end
