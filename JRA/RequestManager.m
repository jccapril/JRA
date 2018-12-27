//
//  RequestManager.m
//  JRA
//
//  Created by 蒋晨成 on 2018/12/27.
//  Copyright © 2018年 Jaba. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

- (RACSignal *)getFile:(NSString *)urlString withParam:(NSDictionary *)param {
    
    CGFloat time = arc4random() % 15 / 10.0f;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:urlString ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"wait for %.1fs",time);
    return [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:dict];
        [subscriber sendCompleted];
        return nil;
    }] delay:time];
    
}

- (RACSignal *)get:(NSString *)urlString withParam:(NSDictionary *)param {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 5;
    
    RACSubject *sub = [RACSubject subject];
    
    [manager GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [sub sendNext:responseObject];
        [sub sendCompleted];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [sub sendNext:error];
        [sub sendCompleted];
    }];
    
    
    return sub;
}

@end
