//
//  Person.m
//  ReflectDemo
//
//  Created by SoDo on 2018/12/21.
//  Copyright © 2018 shaochong du. All rights reserved.
//

#import "Person.h"

@implementation Person

+ (void)printPerson {
    NSLog(@"I'm a person.");
}

- (void)logInfo {
    NSLog(@"实例方法打印");
}

- (void)printUserName:(NSString *)userName {
    NSLog(@"My name is %@.", userName);
}

- (void)printUserName:(NSString *)userName age:(NSInteger)age {
    //  反射调用age作为object对象传入
    NSLog(@"UserName:%@ age:%@",userName, age);
}

- (NSString *)logName:(NSString *)name address:(NSString *)address {
    return [NSString stringWithFormat:@"%@ 的地址是 %@", name, address];
}

- (id)addressOfUser:(NSString *)userName {
    return [NSString stringWithFormat:@"%@:北京-中国", userName];
}

- (void)printInfoBlock:(myBlock)block {
    block(@"你好", @"中国");
}

@end
