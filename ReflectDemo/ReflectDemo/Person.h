//
//  Person.h
//  ReflectDemo
//
//  Created by SoDo on 2018/12/21.
//  Copyright © 2018 shaochong du. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^myBlock)(NSString *, NSString*);

@interface Person : NSObject

/**
 类方法
 */
+ (void)printPerson;

- (void)logInfo;

/**
 一个参数

 @param userName 姓名
 */
- (void)printUserName:(NSString *)userName;

- (void)printUserName:(NSString *)userName age:(NSInteger)age;

- (NSString *)logName:(NSString *)name address:(NSString *)address;


- (id)addressOfUser:(NSString *)userName;

- (void)printInfoBlock:(myBlock)block;


@end

NS_ASSUME_NONNULL_END
