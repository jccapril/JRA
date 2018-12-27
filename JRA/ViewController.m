//
//  ViewController.m
//  JRA
//
//  Created by 蒋晨成 on 2018/12/19.
//  Copyright © 2018年 Jaba. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC.h>
#import "TestRACSubjectViewController.h"
#import "UITextFieldViewController.h"
#import "UIButtonViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *dataSource;

/* 11.代替NSTimer计时器 */
// 可以代替 NSTimer 使用
@property (nonatomic, strong) RACDisposable *disposable;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"RAC-Obj";
    [self initSetTableViewConfigureStyle:UITableViewStylePlain];
    [self setupTableViewConstrint:0 left:0 right:0 bottom:0];
    
    
    HSTextCellModel *RACSignal = [[HSTextCellModel alloc] initWithTitle:@"1.RACSignal 信号" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        [self rac_demo_0];
    }];
    NSMutableArray *section0 = [NSMutableArray arrayWithObjects:RACSignal, nil];
    [self.hs_dataArry addObject:section0];

    
    HSTextCellModel *RACSubject0 = [[HSTextCellModel alloc] initWithTitle:@"2-1.RACSubject 信号" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        [self rac_demo_1_0];
    }];
    
    HSTextCellModel *RACSubject1 = [[HSTextCellModel alloc] initWithTitle:@"2-2.RACSubject 信号" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        [self rac_demo_1_1];
    }];
    
    NSMutableArray *section1 = [NSMutableArray arrayWithObjects:RACSubject0, RACSubject1, nil];
    [self.hs_dataArry addObject:section1];
    
    
    HSTextCellModel *RACTuple = [[HSTextCellModel alloc] initWithTitle:@"3. RACTuple 元组" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        [self rac_demo_2];
    }];
    NSMutableArray *section2 = [NSMutableArray arrayWithObjects:RACTuple, nil];
    [self.hs_dataArry addObject:section2];
    
    
    HSTextCellModel *RACFor0 = [[HSTextCellModel alloc] initWithTitle:@"4-1. 遍历 Array 数组和 Dictionary 字典" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        [self rac_demo_3_0];
    }];
    HSTextCellModel *RACFor1 = [[HSTextCellModel alloc] initWithTitle:@"4-2. 替换 Array 数组元素" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        [self rac_demo_3_1];
    }];
    NSMutableArray *section3 = [NSMutableArray arrayWithObjects:RACFor0, RACFor1, nil];
    [self.hs_dataArry addObject:section3];
    
    HSTextCellModel *RACTextField = [[HSTextCellModel alloc] initWithTitle:@"5. 监听 TextField 的输入改变" detailText:nil actionBlock:^(HSBaseCellModel *model) {
       
        UITextFieldViewController *textFieldVC = [[UITextFieldViewController alloc] init];
        [self.navigationController pushViewController:textFieldVC animated:YES];
        
    }];
    NSMutableArray *section4 = [NSMutableArray arrayWithObjects:RACTextField, nil];
    [self.hs_dataArry addObject:section4];
    
    HSTextCellModel *RACButton = [[HSTextCellModel alloc] initWithTitle:@"6. 监听 Button 点击事件 && 登录按钮状态实时监听" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        
        UIButtonViewController *buttonVC = [[UIButtonViewController alloc] init];
        [self.navigationController pushViewController:buttonVC animated:YES];
        
    }];
    NSMutableArray *section5 = [NSMutableArray arrayWithObjects:RACButton, nil];
    [self.hs_dataArry addObject:section5];
    
    [self rac_demo_7];
    HSTextCellModel *RACNotification = [[HSTextCellModel alloc] initWithTitle:@"7. 监听 Notification 通知事件" detailText:nil actionBlock:^(HSBaseCellModel *model) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"rac_demo_7" object:nil];
        
    }];
    NSMutableArray *section6 = [NSMutableArray arrayWithObjects:RACNotification, nil];
    [self.hs_dataArry addObject:section6];
    
    [self rac_demo_10];

    
}




// ReactiveObjc 的使用
// RAC 的核心思想：创建信号 - 订阅信号 - 发送信号

// 1.RACSignal 信号
- (void)rac_demo_0 {
    
    /* 创建信号 */
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
       /* 发送信号 */
        [subscriber sendNext:@"发送信号"];
    
        return nil;
    }];
    
    /* 订阅信号 */
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
    
    /* 取消订阅 */
    [disposable dispose];
}

// 2.RACSubject 信号
// 和代理方用法类似， 通常用来代替代理
- (void)rac_demo_1_0 {
    
    /* 创建信号 */
    RACSubject *subject = [RACSubject subject];
    /* 订阅（通常在别的跟试图控制器中订阅，与代理用法类似）*/
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@",x);
    }];
    /* 发送信号 */
    [subject sendNext:@"发送信号"];
}
- (void)rac_demo_1_1 {
    
    TestRACSubjectViewController *vc = [[TestRACSubjectViewController alloc] init];
    vc.delegateSubject = [RACSubject subject];
    [vc.delegateSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"信号内容：%@", x);
    }];
    [self presentViewController:vc animated:YES completion:nil];
    
}


// 3. RACTuple 元组
// RAC 的元组，跟我们 OC 的数组其实是一样的，它其实就是封装了我们的 OC 的数组
- (void)rac_demo_2 {
    
    /* 创建元组 */
    RACTuple *tuple1 = [RACTuple tupleWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
    
    /* 从别的数组中获取内容 */
    RACTuple *tuple2 = [RACTuple tupleWithObjectsFromArray:@[@"1",@"2",@"3",@"4",@"5"]];
    
    /* 利用 RAC 宏快速封装 */
    RACTuple *tuple3 = RACTuplePack(@"1", @"2", @"3", @"4", @"5");
    
    NSLog(@"取元组内容：%@", tuple1);
    NSLog(@"第一个元素：%@", [tuple2 first]);
    NSLog(@"最后一个元素：%@", [tuple3 last]);
    
    
}


// 4. 遍历 Array 数组和 Dictionary 字典
// 可以省去使用 for 循环来遍历
- (void)rac_demo_3_0 {
    /* 遍历数组 */
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"数组内容：%@", x);
    }];
    
    /* 遍历字典 */
    NSDictionary *dictionary = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3"};
    [dictionary.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"字典key,value：%@",x);
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"字典内容：%@：%@", key, value);
    }];
}

// 替换元素，不会改变原数组内容，操作完后都会生成一个新的数组，省去了创建可变数组然后遍历出来单个添加的步骤
- (void)rac_demo_3_1 {
    /* 内容操作 */
    /* 单个操作 */
    NSArray *array = @[@"1",@"2",@"3",@"4",@"4",@"5"];
    NSArray *newArray = [[array.rac_sequence map:^id _Nullable(id  _Nullable value) {
        NSLog(@"数组内容：%@", value);
        return @"0"; //将内容替换为0
    }] array];
    NSLog(@"%@",newArray);
    
    /* 内容快速替换 */
    NSArray *newnewArray = [[newArray.rac_sequence mapReplace:@"1"] array]; //将所有内容替换为1
    NSLog(@"%@",newnewArray);
}


/* 监听Notication通知事件 */
// 可以省去在 -(void)dealloc{} 中清除通知和监听创建方法的步骤
- (void)rac_demo_7 {
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"rac_demo_7" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"rac_demo_7");
    }];
    
}


/* 9.代替Delegate方法 */
// 可以省去监听以及设置 delegate 的步骤，下面表示只要 view 中执行了 btnClick 这个方法，就会发送信号执行回调
- (void)rac_demo_8 {
    
    [[self rac_signalForSelector:@selector(rac_demo_7)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"rac_demo_7 执行了");
    }];
}


/* 10.代替KVO监听 */
// 可以代替KVO监听，下面表示把 view 的frame属性改变转换成信号，只要值改变就会发送信号
- (void)rac_demo_9_0 {
    [[self.view rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@"属性发生了改变：%@",x); //x 是监听属性的改变结果
    }];
}
// 更简单的写法，利用RAC的宏
- (void)rac_demo_9_1 {
    [RACObserve(self.view, frame) subscribeNext:^(id  _Nullable x) {
        NSLog(@"属性发生了改变：%@",x); //x 是监听属性的改变结果
    }];
}

/* 11.代替NSTimer计时器 */
// 可以代替 NSTimer 使用
- (void)rac_demo_10 {
    @weakify(self);
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"当前时间：%@",x);
        /* 关闭计时器 */
        @strongify(self);
        [self.disposable dispose];
    }];
}


@end
