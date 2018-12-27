//
//  RequestManager.h
//  JRA
//
//  Created by 蒋晨成 on 2018/12/27.
//  Copyright © 2018年 Jaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import <ReactiveObjC.h>
@interface RequestManager : NSObject

- (RACSignal *)getFile:(NSString *)urlString withParam:(NSDictionary *)param;

- (RACSignal *)get:(NSString *)urlString withParam:(NSDictionary *)param;

@end
